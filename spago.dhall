{ name = "psnp"
, dependencies =
  [ "argonaut"
  , "exceptions"
  , "mason-prelude"
  , "node-child-process"
  , "task-file"
  , "template-strings"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, version = "0.1.0"
}
