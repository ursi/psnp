{
  outputs = { self, nixpkgs, utils }:
    utils.defaultSystems
      (pkgs: with pkgs;
        {
          defaultPackage = (import ./psnp.nix {
            inherit pkgs;
            runtimeDeps = [ dhall-json git ];
          }).overrideAttrs
            (_: {
                meta = {
                  description = "PureScript Nix Packager - generate nix packages from PureScript projects";
                  homepage = "https://github.com/ursi/psnp";
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
