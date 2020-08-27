namespace HackFacebook\UiServer\RequestRouter;

use \HackFacebook\UiServer\GlobalValues;
use \HackFacebook\UiServer\Controllers\{WebController, NotFoundController};
use Facebook\HackRouter\{HttpMethod, NotFoundException};

class FBRouter {

    public function __construct(public WebController $controller) {
    }

    public function getController(): string {
        return \get_class($this->controller);
    }

    public static function get(
    ): FBRouter {
        $router = new \Router();
        $path = GlobalValues\getFromServerGlobal('REQUEST_URI');
        $method = GlobalValues\getReqMethodFromServerGlobal('REQUEST_METHOD');
        try {
            // Attmept to match the path with the autogenerated router
            list($controller_name, $values) = $router->routeMethodAndPath(
                $method,
                $path,
            );
            $controller = new $controller_name($values);
        } catch (NotFoundException $e) {
            $controller = new NotFoundController(new ImmMap(null));
        }
        return new FBRouter($controller);
    }
}