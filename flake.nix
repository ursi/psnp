rec
{ description = "PureScript Nix Packager - generate nix packages from PureScript projects";
  inputs.dhall-to-nix.url = "github:ursi/dhall-to-nix";

  outputs = { nixpkgs, utils, dhall-to-nix, ... }:
    utils.defaultSystems
      ({ pkgs, system }: with pkgs;
         let
           inherit (dhall-to-nix system ./name-version.dhall) name version;

           psnp =
             let
               base =
                 import (./. + "/${name}.nix") pkgs;
             in
             base.overrideAttrs
               (old:
                  { buildInputs = [ dhall-json git ] ++ old.buildInputs;

                    installPhase = base.mkInstallPhase "${name} ${version}";

                    meta =
                      { inherit description;
                        homepage = "https://github.com/ursi/${name}";

                        maintainers =
                          [ { name = "Mason Mackaman";
                              email = "masondeanm@aol.com";
                              github = "ursi";
                              githubId = "17836748";
                            }
                          ];
                      };
                  }
               );
         in
         { defaultApp = psnp;
           defaultPackage = psnp;

           devShell =
             mkShell
               { buildInputs =
                   [ dhall
                     dhall-json
                     purescript
                     nodejs
                     spago
                   ];

                 shellHook =
                   ''
                   echo 'To run the current PureScript code as ${name}, just use the "${name}" command provided by the "shellHook".'

                   ${name}() {
                     spago bundle-app
                     node . ${name} ${version}
                     rm index.js
                   }
                   '';
               };
         }
      )
      nixpkgs;
}
