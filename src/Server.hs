{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveDataTypeable #-}
{-# HLINT ignore "Use newtype instead of data" #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeOperators #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Server
  ( startApp,
    app,
  )
where

import Control.Monad.IO.Class
import Control.Monad.Trans.Except
import Data.Aeson
import Data.Aeson.TH
import Data.Text
import Faker
import qualified Faker.Yoda as Yoda
import Network.Wai
import Network.Wai.Handler.Warp
import Network.Wai.Middleware.Cors (CorsResourcePolicy (corsMethods, corsOrigins, corsRequestHeaders), cors, simpleCors, simpleCorsResourcePolicy)
import Servant

import System.Environment (getEnv)
import System.IO.Error
import Faker.Yoda
import Faker.ChuckNorris
import Data.Function ((&))

data MyResponse = MyResponse
  { text :: Text
  }

$(deriveJSON defaultOptions ''MyResponse)

type API = "yoda" :> Get '[JSON] MyResponse :<|> "chuck_norris" :> Get '[JSON] MyResponse

startApp :: IO ()
startApp =
  catchIOError
    ( do
        port <- read <$> getEnv "PORT"
        print port
        run port app
    )
    (\_ -> run 8082 app)

corsPolicy :: Middleware
corsPolicy = cors (const $ Just policy)
  where
    -- CORS origin complaint
    -- https://stackoverflow.com/q/63876281
    policy =
      simpleCorsResourcePolicy
        { corsMethods = ["GET", "POST", "PUT", "OPTIONS"],
          corsOrigins =
            Just
              ( [ "http://localhost:1234"
                ],
                True
              ),
          corsRequestHeaders = ["authorization", "content-type"]
        }

app :: Application
app = corsPolicy $ serve api server

api :: Proxy API
api = Proxy

data Source = Yoda | ChuckNorris

-- fakerSettings :: FakerSettings
-- fakerSettings = defaultFakerSettings
-- & setLocale "en" & setNonDeterministic

server :: Server API
server = han Yoda :<|> han ChuckNorris
  where
    han r = Handler $ ExceptT $ handle r

    handle :: Source -> IO (Either ServerError MyResponse)
    handle s = do
        f <- generateNonDeterministic $
                case s of
                    Yoda -> quotes
                    ChuckNorris -> fact
        return $ Right $ MyResponse f
