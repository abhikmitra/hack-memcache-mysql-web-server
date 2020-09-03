namespace HackFacebook\UserService\Controllers;
use Facebook\HackRouter\UriPattern;
use type Facebook\HackRouter\{
    SupportsGetRequests,
    SupportsPostRequests,
};
use \HackFacebook\UserService\GlobalValues;
use HackFacebook\UserService\MySQL;
use HackFacebook\UserService\Models;

final class UserLoginPostController
    extends WebController
    implements SupportsPostRequests {
    <<__Override>>
    public static function getUriPattern(): UriPattern {
        return (new UriPattern())->literal('/login');
    }

    <<__Override>>
    public function getResponse(): Awaitable<string> {
        return Models\User::getUserByNameAndPassword(
            GlobalValues\getPostParams("username"),
            GlobalValues\getPostParams("password"),
        );
    }
}
