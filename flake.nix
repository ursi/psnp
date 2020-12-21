{
  inputs.dhall-to-nix.url = "github:ursi/dhall-to-nix";

  outputs = { self, nixpkgs, utils, dhall-to-nix }:
    utils.defaultSystems
      (pkgs: with pkgs;
        let
          inherit (dhall-to-nix.fromDhall pkgs ./name-version.dhall) name version;
        in
          {
            defaultPackage = (import (./. + "/${name}.nix") {
              inherit (nixpkgs) lib;
              inherit pkgs;
            }).overrideAttrs
              (old:
                {
                  buildInputs = [ dhall-json git ] ++ old.buildInputs;

                  installPhase = ''
                    mkdir -p $out/bin
                    mkdir -p $out/lib
                    cp index.js $out/lib
                    echo "export PATH=$PATH
                    node $out/lib/index.js ${name} ${version}" > $out/bin/${name}
                    chmod +x $out/bin/${name}
                  '';

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
