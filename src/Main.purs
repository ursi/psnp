module Main (main) where

import MasonPrelude
import Data.Argonaut
  ( Json
  , JsonDecodeError
  , (.:)
  , (.:?)
  , decodeJson
  , parseJson
  , printJsonDecodeError
  )
import Data.Array ((!!))
import Data.List ((:))
import Data.Set (Set)
import Data.Set as Set
import Effect.Exception (Error, error)
import Foreign.Object (Object)
import Foreign.Object as Obj
import Git as Git
import Node.Path as Path
import Node.Process as Process
import Substitute (class Homogeneous, createSubstituter)
import Substitute as Sub
import Task (Task, throwError)
import Task as Task
import Task.ChildProcess as CP
import Task.File as File

substitute :: ∀ r. Homogeneous r String => String -> Record r -> String
substitute = createSubstituter (Sub.defaultOptions { marker = '@' })

type Spago
  = { dependencies :: Array String
    , name :: String
    , packages :: Object Package
    , sources :: Array String
    , psnp ::
        { command :: Maybe String
        , version :: String
        }
    }

decodeSpago :: Json -> JsonDecodeError \/ Spago
decodeSpago =
  decodeJson
    >=> \almostSpago -> do
        command <- almostSpago.psnp .:? "command"
        version <- almostSpago.psnp .: "version"
        pure $ almostSpago { psnp = { command, version } }

type Package
  = { dependencies :: Array String
    , repo :: String
    , version :: String
    }

foreign import tmpdir :: Effect String

main :: Effect Unit
main = do
  projectName <- (Process.argv <#> (_ !! 2)) >>= maybe (throw "No name was given for this project") pure
  version <- (Process.argv <#> (_ !! 3)) >>= maybe (throw $ "No " <> projectName <> " version was specified") pure
  let
    getRefRev ::
      { name :: String
      , repo :: String
      , ref :: String
      , tmp :: String
      } ->
      Task Error { ref :: String, rev :: String }
    getRefRev { name, repo, ref, tmp } = do
      let
        path = Path.concat [ tmp, projectName <> "_" <> name ]
      Git.clone repo path
      refRev <- Git.getRefRev path ref
      _ <- CP.exec ("rm -r " <> path) CP.defaultExecOptions
      pure refRev
  tmp <- tmpdir
  Task.capture
    ( case _ of
        Left error -> logShow error
        Right _ -> pure unit
    ) do
    data_ <- CP.exec "dhall-to-json --file spago.dhall" CP.defaultExecOptions
    nix <- case decodeSpago =<< parseJson data_ of
      Right (spago :: Spago) -> do
        { fetchGits, compilerPaths } <-
          foldl
            ( \acc name ->
                ( Obj.lookup name spago.packages
                    <#> \package ->
                        getRefRev
                          { name
                          , repo: package.repo
                          , ref: package.version
                          , tmp
                          }
                          <#> \{ ref, rev } ->
                              { name
                              , url: package.repo
                              , rev
                              , ref
                              }
                )
                  : acc
            )
            Nil
            (getAllDeps spago.packages spago.dependencies)
            # sequence
            <#> ( parSequence
                  .> map
                      ( foldl
                          ( \acc fgd ->
                              let
                                dir = srcDir <> fgd.name <> "/"
                              in
                                { fetchGits:
                                    substitute
                                      """
                                      @{name} = builtins.fetchGit {
                                        url = "@{url}";
                                        rev = "@{rev}";
                                        ref = "@{ref}";
                                      };
                                      """
                                      fgd
                                      : acc.fetchGits
                                , compilerPaths: ("\"" <> dir <> "src/**/*.purs\"") : acc.compilerPaths
                                }
                          )
                          { fetchGits: Nil, compilerPaths: Nil }
                          .> \{ fetchGits, compilerPaths } ->
                              { fetchGits: intercalate "\n" fetchGits
                              , compilerPaths: intercalate " " compilerPaths
                              }
                      )
              )
            # fromMaybe (throwError $ error "something went wrong with packages")
        pure
          $ substitute
              """
              # generated by @{projectName} @{projectVersion}
              { lib, pkgs }:
                let
                  @{attribute} = {
                    @{fetchGits}
                  };

                  mkInstallPhase = args: ''
                      mkdir -p $out/bin
                      mkdir -p $out/lib
                      cp index.js $out/lib
                      echo "if [[ \$1 = --version ]]; then
                        echo $version
                      else
                        export PATH=$PATH
                        node $out/lib/index.js ${args}
                      fi" > $out/bin/@{command}
                      chmod +x $out/bin/@{command}
                  '';
                in
                  with pkgs;
                  stdenv.mkDerivation {
                    pname = lib.strings.sanitizeDerivationName "@{name}";
                    version = "@{version}";
                    nativeBuildInputs = [ purescript ];
                    buildInputs = [ nodejs ];
                    dontUnpack = true;
                    src = ./src;

                    buildPhase = ''
                      mkdir @{srcDir}

                      ${
                        builtins.concatStringsSep ";"
                        (map
                          (name: "ln -rs ${psPackages.${name}} @{srcDir}${name}")
                          (builtins.attrNames psPackages)
                        )
                      }

                      purs compile @{compilerPaths} "$src/**/*.purs"

                      purs bundle "output/*/*.js" -m Main --main Main -o index.js
                    '';

                    passthru = {
                      inherit mkInstallPhase;
                    };

                    installPhase = mkInstallPhase "\\$@";
                  }
              """
              { projectName
              , projectVersion: version
              , attribute
              , fetchGits
              , command: fromMaybe spago.name spago.psnp.command
              , name: spago.name
              , version: spago.psnp.version
              , srcDir
              , compilerPaths
              }
      Left decodeError -> throwError $ error $ printJsonDecodeError decodeError
    File.write (projectName <> ".nix") nix

attribute :: String
attribute = "psPackages"

srcDir :: String
srcDir = "sources/"

getAllDeps :: Object Package -> Array String -> Set String
getAllDeps packages = foldl go mempty
  where
  go :: Set String -> String -> Set String
  go deps packageName =
    ( ( Obj.lookup packageName packages
          <#> _.dependencies
          .> foldl go (Set.insert packageName deps)
      )
        # fromMaybe deps
    )
