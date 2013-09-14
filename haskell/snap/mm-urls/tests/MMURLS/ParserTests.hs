module MMURLS.ParserTests (tests) where
import Test.HUnit (Assertion, (@?=), (~:))
import qualified Test.HUnit as HU
import qualified Test.Framework as TF
import Test.Framework.Providers.HUnit

import MMURLS.Parser (updateActions)


testUpdateActions :: HU.Test
testUpdateActions =
  "updateActions" ~: result @?= expected
  where
    result = updateActions
      "test-secret"
      "http://example.com/-mm-/hash/r=100/local/-/path/image.jpg"
      "r=200"
    expected = Right $
      "http://example.com/-mm-/"
      ++ "e06fca9687b594c8b1b5a6c73a57f772a58ba9e1/r=200/local/-/path/"
      ++ "image.jpg"


tests :: TF.Test
tests = TF.testGroup "ParserTests" $ hUnitTestToTests testUpdateActions
