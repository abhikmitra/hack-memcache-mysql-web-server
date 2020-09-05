namespace HackFacebook\UiServer\Controllers;
use type Facebook\HackRouter\SupportsGetRequests;
use HackFacebook\UiServer\Controllers;
interface IRoutableGetController
    extends IRoutableController, SupportsGetRequests {
}
