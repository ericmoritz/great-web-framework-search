module MMURLS.Data.Actions where
-------------------------------------------------------------------------------
-- |
-- Module : Database.Actions
-- 
-- The interface to the actions database
-------------------------------------------------------------------------------

class ActionsDB a where
  get       :: [String] -> a -> IO [(Maybe String)]
  store     :: [(String, String)] -> a -> IO a
  delete    :: [String] -> a -> IO a

