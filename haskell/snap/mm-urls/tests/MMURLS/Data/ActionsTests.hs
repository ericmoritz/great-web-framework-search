module MMURLS.Data.ActionsTests (tests) where
import Test.HUnit (Assertion, (@?=), (~:))
import qualified Test.HUnit as HU
import qualified Test.Framework as TF
import Test.Framework.Providers.HUnit

import MMURLS.Data.Actions (ActionsDB, get, store, delete)
import Data.Map (fromList)

tests :: ActionsDB a => String -> a -> IO TF.Test
tests group db =
  return $ TF.testGroup group
  $ concat $ map (\f -> f db) [hUnitTestToTests . testGetExists,
                               hUnitTestToTests . testGetNotFound,
                               hUnitTestToTests . testStoreInsert,
                               hUnitTestToTests . testStoreUpdate]

reset :: ActionsDB a => a -> IO a
reset = delete "foo"


testGetExists :: ActionsDB a => a -> HU.Test
testGetExists db =
  "testGet exists" ~: do
    result <- get "foo" =<< store "foo" "bar" =<< reset db
    result @?= Just "bar"


testGetNotFound :: ActionsDB a => a -> HU.Test
testGetNotFound db =
  "testGet not found" ~: do
    result <- get "foo" =<< reset db
    result @?= Nothing


testStoreInsert :: ActionsDB a => a -> HU.Test
testStoreInsert db =
  "testStore insert" ~: do
    result <- get "foo" =<< store "foo" "bar" =<< reset db
    result @?= Just "bar"

testStoreUpdate :: ActionsDB a => a -> HU.Test
testStoreUpdate db =
  "testStore update" ~: do
    result <- get "foo" =<< store "foo" "baz" =<< reset db
    result @?= Just "baz"

         
         
