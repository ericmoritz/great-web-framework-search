module MMURLS.Data.Map.Actions where
import MMURLS.Data.Actions
import qualified Data.Map as Map

-------------------------------------------------------------------------------
-- A dummy in-memory actions database
-------------------------------------------------------------------------------
data ActionsMap = ActionsMap (Map.Map String String) deriving (Show)


instance ActionsDB ActionsMap where
  get ks (ActionsMap dataMap) = return $ map (\k -> Map.lookup k dataMap) ks
  store items (ActionsMap dataMap) = return $ ActionsMap $ foldl (\m (k,v) -> Map.insert k v m) dataMap items
  delete ks (ActionsMap dataMap) = return $ ActionsMap $ foldl (\m k -> Map.delete k m) dataMap ks
