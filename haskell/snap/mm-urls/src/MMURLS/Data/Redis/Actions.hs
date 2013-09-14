{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
-------------------------------------------------------------------------------
-- Actions DB in Redis
-------------------------------------------------------------------------------
module MMURLS.Data.Redis.Actions (new) where
import Database.Redis (runRedis)
import qualified Database.Redis as Redis
import MMURLS.Data.Actions
import Control.Lens
import Control.Monad
import Data.ByteString.Char8 (unpack, pack)
import Data.Either

data RedisActionsDB = RedisActionsDB {
  _connection :: Redis.Connection 
} 
makeLenses ''RedisActionsDB

new :: Redis.Connection -> RedisActionsDB
new = RedisActionsDB

instance ActionsDB RedisActionsDB where
  get ks db = do
    result <- runRedis (db^.connection) $ Redis.mget $ map pack ks
    return $ either
      (\_ -> [])
      (\mbs -> map (liftM unpack) mbs)
      result

  store items db =
    runRedis (db^.connection) $ Redis.mset itemsBS >> return db
    where
      itemsBS = map (\(k,v) -> ((pack k), (pack v))) items
  delete ks db =
    runRedis (db^.connection) $ Redis.del keysBS >> return db
    where
      keysBS = map pack ks
