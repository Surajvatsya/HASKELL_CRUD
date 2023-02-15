{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module API.User where
import Data.Int (Int64)
import Data.Proxy
import Servant.API
import Storage.Types.User

type UsersAPI =
  "user" :> Capture "userid" Int64 :> Get '[JSON] User
    :<|> "register" :> ReqBody '[JSON] User :> Post '[JSON] Int64
    :<|> "update" :> Capture "userid" UserId :> ReqBody '[JSON] User :> Put '[JSON] ()
    :<|> "delete" :> Capture "userid" UserId :> Delete '[JSON] ()

-- The response will be in JSON format, specified using Post '[JSON] String
usersApi :: Proxy UsersAPI
usersApi = Proxy :: Proxy UsersAPI
