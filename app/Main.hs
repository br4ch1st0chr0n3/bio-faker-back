module Main where

import Server ( startApp )
-- import Faker.Cannabis as FC
-- import Faker
-- import Faker.Name as FN
-- import qualified Faker.Cannabis as FC
-- import Faker.ChuckNorris as FCN
-- import qualified Faker.ChuckNorris as FCN
import Data.Text.IO as DT


main :: IO ()
main = do
    startApp