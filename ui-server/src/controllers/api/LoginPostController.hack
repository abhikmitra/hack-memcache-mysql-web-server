namespace HackFacebook\UiServer\Controllers\API;

use Facebook\HackRouter\UriPattern;
use HackFacebook\UiServer\Memcache;
use HackFacebook\UiServer\Models\User;
use type Facebook\HackRouter\{SupportsGetRequests};
use type HHVM\UserDocumentation\{GuidesIndex, GuidesProduct};
type LoginPostResponseData = shape('userId' => string);
final class LoginPostController
    extends AbstractAPIController<LoginPostResponseData>
    implements IRoutablePostController {
    const type PostRequestParams = shape('username' => string, 'password' => string);
    protected async function getAPIResponseAsync(
    ): Awaitable<shape(
        'statusCode' => int,
        'data' => LoginPostResponseData,
        ?'headers' => dict<string, vec<string>>,
    )> {
        $username = $this->getRawBody_UNSAFE("username");
        $password = $this->getRawBody_UNSAFE("password");
        invariant($username != null && $password != null, "Data Check");
        try {
            $userId = await User::getUserByNameAndPassword(
                $username,
                $password,
            );
            $sessionId = await Memcache\MemcacheConnector::addSessionId(
                $userId,
            );
            $tData = shape(
                'statusCode' => 200,
                'data' => shape('userId' => "1"),
                'headers' => dict[
                    'x-session-id' => vec[$sessionId],
                    'Set-Cookie' => vec['x-session-id='.$sessionId],
                    'Location' => vec['/'],
                ],
            );
        } catch (\Exception $e) {
            \var_dump($e);
            $e->toString();
            $tData = shape(
                'statusCode' => 200,
                'data' => shape('error' => $e->toString()),
                'headers' => dict[
                    'Location' => vec['/signUp'],
                ],
            );
        }

        
        
        return $tData;
    }

    public static function getUriPattern(): UriPattern {
        return (new UriPattern())->literal('/login');
    }

}
