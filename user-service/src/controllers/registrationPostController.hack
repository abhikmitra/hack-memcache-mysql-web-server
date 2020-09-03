namespace HackFacebook\UserService\Controllers;
use Facebook\HackRouter\UriPattern;
use type Facebook\HackRouter\{SupportsGetRequests, SupportsPostRequests};
use HackFacebook\UserService\Models;
final class RegistrationPostController
    extends WebController
    implements SupportsPostRequests {
    <<__Override>>
    public static function getUriPattern(): UriPattern {
        return (new UriPattern())->literal('/user');
    }

    <<__Override>>
    public function getResponse(): Awaitable<string> {
        $parameters = $this->getRequestParameters();
        $json = \json_decode(\file_get_contents('php://input'));
        invariant($json->username != null, 'JSON is not properly formatted.');
        invariant($json->password != null, 'JSON is not properly formatted.');
        return Models\User::createUser(
            $json->username,
            $json->password,
        );
    }
}
