namespace HackFacebook\UiServer\Controllers;
use type Facebook\HackRouter\SupportsGetRequests;
use HackFacebook\UiServer\Controllers;
interface RoutableGetController
    extends RoutableController, SupportsGetRequests {
}
