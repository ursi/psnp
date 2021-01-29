let name-version = ./name-version.dhall

in  { name = name-version.name
    , dependencies =
      [ "exceptions"
      , "mason-prelude"
      , "node-process"
      , "simple-json"
      , "substitute"
      , "task-file"
      , "task-node-child-process"
      ]
    , packages = ./packages.dhall
    , sources = [ "src/**/*.purs" ]
    , psnp.version = name-version.version
    }
