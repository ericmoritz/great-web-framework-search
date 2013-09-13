-------------------------------------------------------------------------------
-- |
-- Module : Database.Actions
-- 
-- The interface to the actions database
-------------------------------------------------------------------------------
import qualified Data.Map as Map

class ActionsDB a where
  get       :: a -> String -> Maybe String
  store     :: a -> String -> String -> a

data ActionsMap = ActionsMap (Map.Map String String) deriving (Show)

instance ActionsDB ActionsMap where
  get (ActionsMap map) k = Map.lookup k map
  store (ActionsMap map) k v = ActionsMap $ Map.insert k v map
