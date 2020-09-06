namespace HackFacebook\UiServer\Controllers\Pages;

use Facebook\HackRouter\UriPattern;
use HackFacebook\UiServer\Memcache;
use type Facebook\HackRouter\{SupportsGetRequests};
use type HHVM\UserDocumentation\{GuidesIndex, GuidesProduct};
use HackFacebook\UiServer\Memcache\MemcacheConnector;
final class HomePageController extends AbstractWebPageController {
  <<__Override>>
  public static function getUriPattern(): UriPattern {
    return (new UriPattern())->literal('/');
  }

  protected function getView(): \AbstractView {
    $sessionId = $this->getSessionId();
    if($sessionId == null) {
      return new \NotLoggedinView();
    }
    $userId = MemcacheConnector::getUserIdBySessionId($sessionId);
    if ($userId == null) {
      return new \NotLoggedinView();
    }
    return new \HomeView();
  }
}
