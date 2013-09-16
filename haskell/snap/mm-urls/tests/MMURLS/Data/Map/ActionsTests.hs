module MMURLS.Data.Map.ActionsTests (tests) where
import qualified MMURLS.Data.ActionsTests as ActionsTests
import MMURLS.Data.Map.Actions (ActionsMap(ActionsMap))
import Data.Map (fromList)

tests = ActionsTests.tests "ActionMap" $ ActionsMap $ fromList []
