{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TypeFamilies #-}

module Domain.Action.User where

import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.Except (throwE)
import Data.Int (Int64)
import Servant.Server
import SharedLogic.Migration
import Storage.Queries.User
import Storage.Types.User

fetchUsersHandler :: Int64 -> Handler User
fetchUsersHandler uid = do
  maybeUser <- liftIO $ fetchUserPG localConnString uid
  case maybeUser of
    Just user -> return user
    Nothing -> Handler (throwE $ err401 {errBody = "Could not find user with that ID"})

postUserHandler :: User -> Handler Int64
postUserHandler my_user = do
  _ <- liftIO $ postUserPG localConnString my_user
  return 1

updateUserHandler :: UserId -> User -> Handler ()
updateUserHandler uid updated_user = do
  liftIO $ updateUserPG localConnString uid updated_user

deleteUserById :: UserId -> Handler ()
deleteUserById uid = liftIO $ deleteUserPG localConnString uid
