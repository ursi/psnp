{
  outputs = { self, nixpkgs, utils }:
    utils.defaultSystems
      (pkgs: with pkgs;
        {
          defaultPackage = import ./psnp.nix {
            inherit pkgs;
            runtimeDeps = [ dhall-json git ];
          };

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
