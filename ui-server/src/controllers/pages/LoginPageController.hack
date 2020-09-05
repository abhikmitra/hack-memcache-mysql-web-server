namespace HackFacebook\UiServer\Controllers\Pages;

use Facebook\HackRouter\UriPattern;
use HackFacebook\UiServer\Memcache;
use type Facebook\HackRouter\{SupportsGetRequests};
use type HHVM\UserDocumentation\{GuidesIndex, GuidesProduct};
final class LoginPageController extends AbstractWebPageController {
    <<__Override>>
    public static function getUriPattern(): UriPattern {
        return (new UriPattern())->literal('/login');
    }

    protected function getView(): \AbstractView {
        return new \LoginView();
    }
}
