let name-version = ./name-version.dhall

in  { name = name-version.name
    , dependencies =
      [ "argonaut"
      , "exceptions"
      , "mason-prelude"
      , "node-process"
      , "substitute"
      , "task-file"
      , "task-node-child-process"
      ]
    , packages = ./packages.dhall
    , sources = [ "src/**/*.purs" ]
    , version = name-version.version
    }
