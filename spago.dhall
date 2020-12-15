{ name = "psnp"
, dependencies =
  [ "argonaut"
  , "exceptions"
  , "mason-prelude"
  , "task-file"
  , "task-node-child-process"
  , "template-literals"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
, version = "0.1.2"
}
