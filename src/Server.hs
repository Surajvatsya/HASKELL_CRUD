module Server (runServer) where
import qualified API.User as AU
import qualified Domain.Action.User as DAU
import Domain.Types.User
import Network.Wai.Handler.Warp (run)
import Servant.API
import Servant.Server
import SharedLogic.Migration

server :: Server AU.UsersAPI
server =
  DAU.fetchUsersHandler
    :<|> DAU.postUserHandler
    :<|> DAU.updateUserHandler
    :<|> DAU.deleteUserById

runServer :: IO ()
runServer = run 8000 (serve AU.usersApi server)
