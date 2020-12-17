# PureScript Nix Packager

Generate Nix packages from PureScript projects.

## How to use

- Set up a PureScript project (using Spago) with a `Main` module that exports a `main` effect.
- Make sure you have a `version` property in your `spago.dhall`. This will be used for the Nix package version.
- Run `psnp`. This will generate a file called `psnp.nix` which is a function that returns a derivation for your package.
- In your `flake.nix`/`default.nix`, import `psnp.nix` and call it with a `pkgs` argument. You can use [.overrideAttrs](https://nixos.org/manual/nixpkgs/stable/#sec-pkg-overrideAttrs) to extend the derivation. For an example, check the [flake.nix](https://github.com/ursi/psnp/blob/master/flake.nix) for this project.

## I don't use flakes

Don't worry! You can still easily build this package (or any flake) using [flake-compat](https://github.com/edolstra/flake-compat):

```nix
let
  flake-compat = import (builtins.fetchGit "https://github.com/edolstra/flake-compat");
  psnp = builtins.fetchGit "https://github.com/ursi/psnp";
in
  (flake-compat { src = psnp; }).defaultNix.default
```
