namespace HackFacebook\UiServer\Controllers;
use type Facebook\HackRouter\IncludeInUriMap;

interface IRoutableController extends IncludeInUriMap {
    require extends AbstractWebController;
}
