module MMURLS.Data.Actions where
-------------------------------------------------------------------------------
-- |
-- Module : Database.Actions
-- 
-- The interface to the actions database
-------------------------------------------------------------------------------
import qualified Data.Map as Map

class ActionsDB a where
  get       :: String -> a -> IO (Maybe String)
  store     :: String -> String -> a -> IO a
  delete    :: String -> a -> IO a

-------------------------------------------------------------------------------
-- A dummy in-memory actions database
-------------------------------------------------------------------------------
data ActionsMap = ActionsMap (Map.Map String String) deriving (Show)


instance ActionsDB ActionsMap where
  get k (ActionsMap map) = return $ Map.lookup k map
  store k v (ActionsMap map) = return $ ActionsMap $ Map.insert k v map
  delete k (ActionsMap map) = return $ ActionsMap $ Map.delete k map
