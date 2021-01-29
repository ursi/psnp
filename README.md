# PureScript Nix Packager

Generate Nix packages from PureScript projects.

## How to use

- Set up a PureScript project with a `Main` module that exports a `main` effect.
- `psnp` uses values from your `spago.dhall` to generate code.
	- A sanitized version of `(./spago.dhall).name` is used for the `pname` of the derivation.
	- `(./spago.dhall).psnp.version` is used for the `version` of the derivation.
	- `(./spago.dhall).psnp.command` is an optional value used to determine the name of the executable. If omitted, `(./spago.dhall).name` is used.
- Once the appropriate values have been added to your `spago.dhall`, run `psnp`. This will generate a file called `psnp.nix` which is a function that returns a derivation for your package.
- In your `flake.nix`/`default.nix`, import `psnp.nix` and call it with `lib` and `pkgs` arguments. You can use [.overrideAttrs](https://nixos.org/manual/nixpkgs/stable/#sec-pkg-overrideAttrs) to extend the derivation. For an example, check the [flake.nix](https://github.com/ursi/psnp/blob/master/flake.nix) for this project.
- The generated executable automatically supports a `--version` flag, which `echo`s the value in `(./spago.dhall).psnp.version`.

## I don't use flakes

Don't worry! You can still easily build this package (or any flake) using [flake-compat](https://github.com/edolstra/flake-compat):

```nix
let
  flake-compat = import (builtins.fetchGit "https://github.com/edolstra/flake-compat");
  psnp = builtins.fetchGit "https://github.com/ursi/psnp";
in
  (flake-compat { src = psnp; }).defaultNix.default
```
