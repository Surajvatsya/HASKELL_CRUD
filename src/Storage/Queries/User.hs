{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}

module Storage.Queries.User where

import Control.Monad.Trans
import Data.ByteString (ByteString)
import Data.Int (Int64)
import Data.Text
import Database.Persist
import Database.Persist.Postgresql
import SharedLogic.Migration
import Storage.Types.User

fetchUserPG :: PGInfo -> Int64 -> IO (Maybe User)
fetchUserPG connString uid = runAction connString (get (toSqlKey uid))

postUserPG :: PGInfo -> User -> IO Int64
postUserPG connString my_user = fromSqlKey <$> runAction connString (insert my_user)

updateUserPG :: PGInfo -> UserId -> User -> IO ()
updateUserPG localConnString uid updated_user =
  runAction
    localConnString
    ( updateWhere
        [ UserId ==. uid
        ]
        [ UserName =. userName updated_user,
          UserAge =. userAge updated_user,
          UserEmail =. userEmail updated_user
        ]
    )

deleteUserPG :: PGInfo -> UserId -> IO ()
deleteUserPG localConnString uid = runAction localConnString (deleteWhere [UserId ==. uid])
