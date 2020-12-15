# PureScript Nix Packager

Generate Nix packages from PureScript projects.

## How to use

- Set up a PureScript project with a `Main` module that exports a `main` effect.
- Run `psnp`. This will generate a file called `psnp.nix` which is a function that returns a derivation for you package.
- In your `flake.nix`/`default.nix`, import `psnp.nix` and call it with a `pkgs` argument and optionally a `runtimeDeps` argument which is a list of packages.
