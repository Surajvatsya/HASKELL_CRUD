module Main (main) where

import Server

-- import SharedLogic.Migration

main :: IO ()
main = runServer

-- main = migrateDB localConnString
