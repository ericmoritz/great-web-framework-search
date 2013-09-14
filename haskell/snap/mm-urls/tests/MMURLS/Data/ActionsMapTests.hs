module MMURLS.Data.ActionsMapTests (tests) where
import qualified MMURLS.Data.ActionsTests as ActionsTests
import MMURLS.Data.Actions (ActionsMap(ActionsMap))
import Data.Map (fromList)

tests = ActionsTests.tests "ActionMap" $ ActionsMap $ fromList []
