namespace HackFacebook\UiServer\Controllers;
use type Facebook\HackRouter\IncludeInUriMap;

interface RoutableController extends IncludeInUriMap {
    require extends WebController;
}
