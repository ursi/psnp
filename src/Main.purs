module Main where

import MasonPrelude
import Data.Argonaut (decodeJson, parseJson)
import Data.List ((:))
import Data.Set (Set)
import Data.Set as Set
import Data.TemplateString ((<^>))
import Effect.Exception (Error, error)
import Foreign.Object (Object)
import Foreign.Object as Obj
import Git as Git
import Node.Path as Path
import Task (Task, throwError)
import Task as Task
import Task.ChildProcess as CP
import Task.File as File

type Spago
  = { dependencies :: Array String
    , name :: String
    , packages :: Object Package
    , sources :: Array String
    , version :: String
    }

type Package
  = { dependencies :: Array String
    , repo :: String
    , version :: String
    }

foreign import tmpdir :: Effect String

main :: Effect Unit
main = do
  tmp <- tmpdir
  Task.capture
    ( case _ of
        Left error -> logShow error
        Right _ -> pure unit
    ) do
    data_ <- CP.exec "dhall-to-json --file spago.dhall" CP.defaultExecOptions
    nix <- case decodeJson =<< parseJson data_ of
      Right (spago :: Spago) -> do
        { fetchGits, buildPhase, compilerPaths } <-
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
                                    ( """      ${name} = builtins.fetchGit {
        url = "${url}";
        rev = "${rev}";
        ref = "${ref}";
      };"""
                                        <^> [ "name" /\ fgd.name
                                          , "url" /\ fgd.url
                                          , "rev" /\ fgd.rev
                                          , "ref" /\ fgd.ref
                                          ]
                                    )
                                      : acc.fetchGits
                                , buildPhase:
                                    ("        cp -r ${" <> attribute <> "." <> fgd.name <> "} " <> dir)
                                      : acc.buildPhase
                                , compilerPaths: ("\"" <> dir <> "src/**/*.purs\"") : acc.compilerPaths
                                }
                          )
                          { fetchGits: Nil, buildPhase: Nil, compilerPaths: Nil }
                          .> \{ fetchGits, buildPhase, compilerPaths } ->
                              { fetchGits: intercalate "\n\n" fetchGits
                              , buildPhase: intercalate "\n" buildPhase
                              , compilerPaths: intercalate " " compilerPaths
                              }
                      )
              )
            # fromMaybe (throwError $ error "something wen wrong with packages")
        pure
          $ """{ pkgs }: with pkgs;
  let
    ${attribute} = {
${fetchGits}
    };
  in
    stdenv.mkDerivation {
      pname = "${name}";
      version = "${version}";
      buildInputs = [ purescript nodejs spago ];
      dontUnpack = true;
      src = ./src;

      buildPhase = ''
        mkdir ${srcDir}

${buildPhase}

        purs compile ${compilerPaths} "$src/**/*.purs"

        purs bundle "output/*/*.js" -m Main --main Main -o index.js
        sed -i "1i \#! urs/bin/node" index.js
        chmod +x index.js
      '';

      installPhase = ''
        mkdir -p $out/bin
        local ex=$out/bin/index.js
        cp index.js $out/bin
      '';
    }"""
          <^> [ "attribute" /\ attribute
            , "fetchGits" /\ fetchGits
            , "name" /\ spago.name
            , "version" /\ spago.version
            , "srcDir" /\ srcDir
            , "buildPhase" /\ buildPhase
            , "compilerPaths" /\ compilerPaths
            ]
      Left e -> throwError $ error "something went wrong decoding json"
    File.write "purescript.nix" nix

attribute :: String
attribute = "purescript'"

srcDir :: String
srcDir = "sources/"

getRefRev ::
  { name :: String
  , repo :: String
  , ref :: String
  , tmp :: String
  } ->
  Task Error { ref :: String, rev :: String }
getRefRev { name, repo, ref, tmp } = do
  let
    path = Path.concat [ tmp, "ps2nix_" <> name ]
  Git.clone repo path
  refRev <- Git.getRefRev path ref
  _ <- CP.exec ("rm -r " <> path) CP.defaultExecOptions
  pure refRev

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

type Test
  = { string :: Maybe String
    , array :: Maybe (Array Int)
    }

test :: Test
test = (mempty :: Test) { string = Just "hi" }
