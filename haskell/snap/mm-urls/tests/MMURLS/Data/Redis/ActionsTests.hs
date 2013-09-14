module MMURLS.Data.Redis.ActionsTests (tests) where
import Database.Redis (connect, defaultConnectInfo)
import MMURLS.Data.Redis.Actions
import Control.Monad
import qualified MMURLS.Data.ActionsTests as ActionsTests

db = new `liftM` connect defaultConnectInfo

tests = ActionsTests.tests "Redis Action Tests" =<< db
