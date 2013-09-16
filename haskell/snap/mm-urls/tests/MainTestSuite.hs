module Main (main) where

import Test.Framework (Test, defaultMain)
import qualified MMURLS.ParserTests as ParserTests
import qualified MMURLS.Data.Map.ActionsTests as MapActionsTests
import qualified MMURLS.Data.Redis.ActionsTests as RedisActionsTests  
import Control.Monad

tests :: IO [Test]
tests = sequence [return ParserTests.tests,
                  MapActionsTests.tests,
                  RedisActionsTests.tests]

main = defaultMain =<< tests
