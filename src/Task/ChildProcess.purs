module Task.ChildProcess
  ( module Exports
  , exec
  ) where

import MasonPrelude
import Effect.Exception (Error)
import Data.Posix.Signal (Signal(..))
import Node.Buffer as Buffer
import Node.ChildProcess (ExecOptions)
import Node.ChildProcess as CP
import Node.Encoding (Encoding(..))
import Task (Task, makeTask)
import Node.ChildProcess (ExecOptions, ExecResult, defaultExecOptions) as Exports

exec :: String -> ExecOptions -> Task Error String
exec cmd options =
  makeTask \aC xC -> do
    cp <-
      CP.exec cmd options
        ( \result -> case result.error of
            Just error -> xC error
            Nothing -> aC =<< Buffer.toString UTF8 result.stdout
        )
    pure $ CP.kill SIGTERM cp
