module Git where

import MasonPrelude
import Data.String (Pattern(..))
import Data.String (split) as String
import Data.String.CodeUnits (takeWhile) as String
import Effect.Exception (Error, error)
import Task (Task, throwError)
import Task.ChildProcess as CP

type Repo
  = String

type Path
  = String

clone :: Repo -> Path -> Task Error Unit
clone repo path = void $ CP.exec ("git clone " <> repo <> " " <> path) CP.defaultExecOptions

getRev :: Path -> String -> Task Error String
getRev path ref =
  CP.exec ("git show-ref " <> ref)
    (CP.defaultExecOptions { cwd = Just path })
  <#> String.takeWhile ((/=) '\n')
  .> String.split (Pattern " ")
  >>= \split -> case split of
      [ rev, _ ] -> pure rev
      _ -> throwError $ error $ "refrev error: " <> show split
