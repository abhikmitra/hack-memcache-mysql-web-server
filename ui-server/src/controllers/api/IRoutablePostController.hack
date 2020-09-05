namespace HackFacebook\UiServer\Controllers\API;
use type Facebook\HackRouter\SupportsPostRequests;
use HackFacebook\UiServer\Controllers\IRoutableController;
interface IRoutablePostController
    extends IRoutableController, SupportsPostRequests {
}
