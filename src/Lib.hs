module Lib (
    main,
) where

import Data.Function ((&))
import qualified Data.Text as T
import Faker
import Faker.Marketing (buzzwords)
import GHC.Generics (Generic)
import Options.Generic (ParseRecord, getRecord)

main :: IO ()
main = do
    command <- getRecord "Command"
    let fakerLocales = case command of
            Default -> Nothing
            Custom t -> Just t
    result <- getRandomWordsConfig fakerLocales
    putStrLn . T.unpack $ result

data Command = Default | Custom T.Text
    deriving (Generic, Show)

instance ParseRecord Command

getRandomWordsConfig :: Maybe T.Text -> IO T.Text
getRandomWordsConfig fakerLocales = do
    let fakerSettings = case fakerLocales of
            Just prefix ->
                setNonDeterministic
                    . setLocaleDir prefix
                    $ defaultFakerSettings
            Nothing ->
                setNonDeterministic defaultFakerSettings
    buzz <- generateWithSettings fakerSettings buzzwords
    pure $
        buzz & T.toTitle
            & T.splitOn " "
            & T.concat
