namespace HackFacebook\UiServer\Controllers\API;

use Facebook\HackRouter\UriPattern;
use HackFacebook\UiServer\Memcache;
use type Facebook\HackRouter\{SupportsGetRequests};
use type HHVM\UserDocumentation\{GuidesIndex, GuidesProduct};
use HackFacebook\UiServer\Models\User;
type SignUpPostTData = shape('userId' => string);
final class SignUpPostController
    extends AbstractAPIController<SignUpPostTData>
    implements IRoutablePostController {
    
    protected async function getAPIResponseAsync(
    ): Awaitable<shape(
        'statusCode' => int,
        'data' => SignUpPostTData,
        ?'headers' => dict<string, vec<string>>,
    )> {
        $username = $this->getRawParameter_UNSAFE("username");
        $password = $this->getRawParameter_UNSAFE("password");
        invariant($username != null, "Username cannot be null");
        invariant($password != null, "Username cannot be null");
        $userId = await User::getUserByNameAndPassword($username, $password);
        $sessionId = await Memcache\MemcacheConnector::addSessionId($userId);

        $this->getRawParameter_UNSAFE("username");
        $tData = shape(
            'statusCode' => 200,
            'data' => shape('userId' => "1"),
            'headers' => dict[
                'x-session-id' => vec[$sessionId],
                'Set-Cookie' => vec['x-session-id='.$sessionId],
            ],
        );
        return $tData;
    }

    public static function getUriPattern(): UriPattern {
        return (new UriPattern())->literal('/signUp');
    }

}
