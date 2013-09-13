{-# LANGUAGE TemplateHaskell #-}
module MMURLS.Parser (encodeURL, decodeURL, setActions, getActions) where 
import Text.Parsec.Prim
import Text.Parsec.Error
import Text.ParserCombinators.Parsec.Char
import Text.ParserCombinators.Parsec.Combinator
import Data.HMAC
import Data.Char (ord)
import Codec.Utils (Octet)
import Codec.Text.Raw (hexdumpBy)
import Control.Lens
import Data.List (intercalate)

-------------------------------------------------------------------------------
-- Data declarations
-------------------------------------------------------------------------------

data MMBits = MMBits {
  _host         :: String,     -- The http://.../ stuff
  _hash         :: String,     -- The security hash
  _actions      :: String,     -- The r=200 stuff
  _source       :: String,     -- Local or HTTP
  _sourceParams :: String,     -- The source params
  _path         :: String      -- The rest of the path
} deriving (Show, Eq)

makeLenses ''MMBits

-------------------------------------------------------------------------------
-- Public
------------------------------------------------------------------------------
setActions :: String -> MMBits -> MMBits
setActions actionsValue bits = set actions actionsValue bits
  

getActions :: MMBits -> String
getActions bits = bits^.actions


decodeURL :: String -> Either String MMBits
decodeURL url = either (Left . show) Right (parseURL url)


encodeURL :: String -> MMBits -> String
encodeURL secret bits =
  intercalate "/" [(bits^.host), "-mm-", hash', bits^.actions, bits^.source, bits^.sourceParams, bits^.path]
  where
    hash' = securityHash secret (bits^.actions) (bits^.source) (bits^.sourceParams)


-------------------------------------------------------------------------------
-- Internal
-------------------------------------------------------------------------------
  

parseURL :: String -> Either ParseError MMBits
parseURL = parse mmBitsParser ""
           

mmBitsParser :: Parsec String () MMBits
mmBitsParser = do
  proto <- try (string "http://") <|> string "https://"
  host <- hostAndPort
  string "-mm-/"
  hash <- urlPart
  actions <- urlPart
  source <- urlPart
  sourceParams <- urlPart
  path <- many anyChar
  return $ MMBits (proto ++ host) hash actions source sourceParams path
  where
    hostAndPort = urlPart -- I'm lazy
    urlPart = do
      part <- many1 $ noneOf "/"
      char '/'
      return part


securityHash secret actions source sourceParams =
  hexdigest $ hmac_sha1 (strToOctets secret) message
  where
    strToOctets = map (fromIntegral . ord)
    hexdigest = show . hexdumpBy "" 1000
    message = strToOctets $ actions ++ source ++ sourceParams
