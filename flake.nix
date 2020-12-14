{
  outputs = { self, nixpkgs, utils }:
    utils.simpleShell
      [
        "dhall"
        "dhall-json"
        "nodejs"
        "purescript"
        "spago"
      ]
      nixpkgs;
}
