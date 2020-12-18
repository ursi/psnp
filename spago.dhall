{ name = "psnp"
, dependencies =
  [ "argonaut"
  , "exceptions"
  , "mason-prelude"
  , "substitute"
  , "task-file"
  , "task-node-child-process"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, version = "0.2.0"
}
