module MMURLS.Data.Actions where
-------------------------------------------------------------------------------
-- |
-- Module : Database.Actions
-- 
-- The interface to the actions database
-------------------------------------------------------------------------------
import qualified Data.Map as Map

class ActionsDB a where
  get       :: [String] -> a -> IO [(Maybe String)]
  store     :: [(String, String)] -> a -> IO a
  delete    :: [String] -> a -> IO a

-------------------------------------------------------------------------------
-- A dummy in-memory actions database
-------------------------------------------------------------------------------
data ActionsMap = ActionsMap (Map.Map String String) deriving (Show)


instance ActionsDB ActionsMap where
  get ks (ActionsMap dataMap) = return $ map (\k -> Map.lookup k dataMap) ks
  store items (ActionsMap dataMap) = return $ ActionsMap $ foldl (\m (k,v) -> Map.insert k v m) dataMap items
  delete ks (ActionsMap dataMap) = return $ ActionsMap $ foldl (\m k -> Map.delete k m) dataMap ks
