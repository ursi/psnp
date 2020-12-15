# PureScript Nix Packager

Generate Nix packages from PureScript projects.

## How to use

- Set up a PureScript project (using Spago) with a `Main` module that exports a `main` effect.
- Make sure you have a `version` property in your `spago.dhall`. This will be used for the Nix package version.
- Run `psnp`. This will generate a file called `psnp.nix` which is a function that returns a derivation for your package.
- In your `flake.nix`/`default.nix`, import `psnp.nix` and call it with a `pkgs` argument and optionally a `runtimeDeps` argument which is a list of packages.

## I don't use flakes

You can still easily build the package using [flake-compat](https://github.com/edolstra/flake-compat):

```nix
let
  flake-compat = import (builtins.fetchGit "https://github.com/edolstra/flake-compat");
  psnp = builtins.fetchGit "https://github.com/ursi/psnp";
in
  (flake-compat { src = psnp; }).defaultNix.default
```
