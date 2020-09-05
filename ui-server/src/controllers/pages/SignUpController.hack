namespace HackFacebook\UiServer\Controllers\Pages;

use Facebook\HackRouter\UriPattern;
use HackFacebook\UiServer\Memcache;
use type Facebook\HackRouter\{SupportsGetRequests};
use type HHVM\UserDocumentation\{GuidesIndex, GuidesProduct};
final class SignUpPageController extends AbstractWebPageController {
    <<__Override>>
    public static function getUriPattern(): UriPattern {
        return (new UriPattern())->literal('/signUp');
    }

    protected function getView(): \AbstractView {
        return new \SignUpView();
    }
}
