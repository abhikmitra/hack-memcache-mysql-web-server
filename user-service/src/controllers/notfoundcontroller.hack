namespace HackFacebook\UserService\Controllers;
use Facebook\HackRouter\UriPattern;
use type Facebook\HackRouter\{SupportsGetRequests, SupportsPostRequests};
final class NotFoundController
    extends WebController
    implements SupportsGetRequests {

    <<__Override>>
    public static function getUriPattern(): UriPattern {
        return (new UriPattern())
            ->literal('/notfound');
    }

    <<__Override>>
    public async function getResponse(): Awaitable<string> {
        return 'Not found';
    }
}
