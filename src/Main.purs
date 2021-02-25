module Main (main) where

import MasonPrelude
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
import Simple.JSON (readJSON)
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
    nix <- case readJSON data_ of
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
                      mkdir -p @{bin}
                      mkdir -p @{lib}
                      cp @{compilerOutput} @{lib}
                      makeWrapper ${exe args} @{bin}/@{command} \
                        --set PATH $PATH \
                        --set out $out
                  '';

                  exe = args: pkgs.writeShellScript "exe"
                    ''
                      if [[ $1 = --version ]]; then
                        echo @{version}
                      else
                        node @{lib}/@{compilerOutput} ${args}
                      fi
                    '';
                in
                  with pkgs;
                  stdenv.mkDerivation {
                    pname = lib.strings.sanitizeDerivationName "@{name}";
                    version = "@{version}";
                    nativeBuildInputs = [ makeWrapper purescript ];
                    buildInputs = [ nodejs ];
                    dontUnpack = true;
                    src = ./src;

                    buildPhase = ''
                      mkdir @{srcDir}

                      ${
                        builtins.concatStringsSep ";"
                        (map
                          (name: "ln -s ${psPackages.${name}} @{srcDir}${name}")
                          (builtins.attrNames psPackages)
                        )
                      }

                      purs compile @{compilerPaths} "$src/**/*.purs"

                      purs bundle "output/*/*.js" -m Main --main Main -o @{compilerOutput}
                    '';

                    passthru = {
                      inherit mkInstallPhase;
                    };

                    installPhase = mkInstallPhase "$@";
                  }
              """
              { projectName
              , projectVersion: version
              , attribute
              , fetchGits
              , lib: "$out/lib"
              , bin: "$out/bin"
              , compilerOutput: "index.js"
              , command: fromMaybe spago.name spago.psnp.command
              , name: spago.name
              , version: spago.psnp.version
              , srcDir
              , compilerPaths
              }
      Left decodeError -> throwError $ error $ show decodeError
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
