{
  inputs.dhall-to-nix.url = "github:ursi/dhall-to-nix";

  outputs = { self, nixpkgs, utils, dhall-to-nix }:
    utils.defaultSystems
      (pkgs: with pkgs;
        let
          inherit (dhall-to-nix.fromDhall pkgs ./name-version.dhall) name version;
        in
          {
            defaultPackage =
              let
                base = import (./. + "/${name}.nix") {
                  inherit (nixpkgs) lib;
                  inherit pkgs;
                };
              in
                base.overrideAttrs
                  (old:
                    {
                      buildInputs = [ dhall-json git ] ++ old.buildInputs;

                      installPhase = base.mkInstallPhase "${name} ${version}";

                      meta = {
                        description = "PureScript Nix Packager - generate nix packages from PureScript projects";
                        homepage = "https://github.com/ursi/${name}";
                        maintainers = [
                          {
                            name = "Mason Mackaman";
                            email = "masondeanm@aol.com";
                            github = "ursi";
                            githubId = "17836748";
                          }
                        ];
                      };
                    });

            devShell = mkShell {
              buildInputs = [
                dhall
                dhall-json
                purescript
                nodejs
                spago
              ];
            };
          }
      )
      nixpkgs;
}
