(   https://raw.githubusercontent.com/ursi/purescript-package-set/dev/packages.dhall sha256:f1267ae1a35f5f356c76078d0e71c9c9ba4b174af75fc39c13805267b164ff5a
  ⫽ https://github.com/purescript/package-sets/releases/download/psc-0.13.8-20201206/packages.dhall sha256:c9ffd7577fb8ee2197309591d7ccc0f506ee37b9078866f0ef159f5abbb1b32b
  ⫽ { template-strings =
      { dependencies = [ "functions", "tuples" ]
      , repo = "https://github.com/purescripters/purescript-template-strings.git"
      , version = "v5.1.0"
      }
    }
)
  with task-file.version = "v0.1.0"
