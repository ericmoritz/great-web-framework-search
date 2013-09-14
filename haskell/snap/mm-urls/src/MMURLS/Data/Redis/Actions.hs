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
  get k db = do
    result <- runRedis (db^.connection) $ Redis.get (pack k)
    return $ either
      (\_ -> Nothing)
      (\mb -> unpack `liftM` mb)
      result

  store k v db =
    runRedis (db^.connection) $ Redis.set (pack k) (pack v) >> return db
  delete k db =
    runRedis (db^.connection) $ Redis.del [(pack k)] >> return db
