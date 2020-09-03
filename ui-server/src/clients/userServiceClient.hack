namespace HackFacebook\UiServer\Clients;
use HackFacebook\UiServer\Http;
final class UserServiceClient {
    private static string $USER_SERVICE_URL = "http://localhost:8081";
    private static ?\MCRouter $mcRouter = null;
    private static ?\Memcached $memcacheD = null;
    public static async function getUserIdByUsernameAndPassword(string $username, string $password): Awaitable<string> {
        $body = dict["username" => $username, "password" => $password];
        $id = await Http\HttpService::post(UserServiceClient::$USER_SERVICE_URL."/login", $body);
        return $id;
    }

    private static async function createUser(
        string $username,
        string $password,
    ): Awaitable<string> {
        $body = dict["username" => $username, "password" => $password];
        $id = await Http\HttpService::post(
            UserServiceClient::$USER_SERVICE_URL,
            $body,
        );
        return $id;
    }
}
