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
    const type PostRequestParams =
        shape('username' => string, 'password' => string);
    protected async function getAPIResponseAsync(
    ): Awaitable<shape(
        'statusCode' => int,
        'data' => SignUpPostTData,
        ?'headers' => dict<string, vec<string>>,
    )> {
        $username = $this->getRawBody_UNSAFE("username");
        $password = $this->getRawBody_UNSAFE("password");
        invariant($username != null && $password != null, "Data Check");
        $userId = await User::createUser($username, $password);
        $tData = shape(
            'statusCode' => 200,
            'data' => shape('userId' => "1"),
            'headers' => dict[
                'Location' => vec['/login'],
            ],
        );
        return $tData;
    }

    public static function getUriPattern(): UriPattern {
        return (new UriPattern())->literal('/signUp');
    }

}
