module Main (main) where

import Test.Framework (Test, defaultMain)
import qualified MMURLS.ParserTests as ParserTests
import qualified MMURLS.Data.ActionsMapTests as ActionsMapTests
import qualified MMURLS.Data.Redis.ActionsTests as RedisActionsTests  
import Control.Monad

tests :: IO [Test]
tests = sequence [return ParserTests.tests,
                  ActionsMapTests.tests,
                  RedisActionsTests.tests]

main = defaultMain =<< tests
