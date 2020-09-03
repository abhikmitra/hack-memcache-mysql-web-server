namespace HackFacebook\UiServer\Controllers;

use Facebook\HackRouter\UriPattern;
use HackFacebook\UiServer\Memcache;
use type Facebook\HackRouter\{SupportsGetRequests};
use type HHVM\UserDocumentation\{GuidesIndex, GuidesProduct};
use HackFacebook\UiServer\Controllers\WebPageController;
final class HomeController extends WebPageController {
  <<__Override>>
  public static function getUriPattern(): UriPattern {
    return (new UriPattern())->literal('/');
  }

  protected function getView(): \AbstractView {
    return new \HomeView();
  }
}
