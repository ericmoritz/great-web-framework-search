{-# LANGUAGE OverloadedStrings, TemplateHaskell, InstanceSigs #-}

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

  get :: [String] -> RedisActionsDB -> IO [Maybe String]
  get ks db = do
    result <- runRedis (db^.connection) $ Redis.mget $ map pack ks
    return $ case result of
      Left _    -> []
      Right mbs -> map (liftM unpack) mbs

  store :: [(String, String)] -> RedisActionsDB -> IO RedisActionsDB
  store items db =
    runRedis (db^.connection) $ do
      Redis.mset itemsBS
      return db
    where
      packPair (x,y) = (pack x, pack y)
      itemsBS = map packPair items

  delete :: [String] -> RedisActionsDB -> IO RedisActionsDB
  delete ks db =
    runRedis (db^.connection) $ do
      Redis.del keysBS
      return db
    where
      keysBS = map pack ks
