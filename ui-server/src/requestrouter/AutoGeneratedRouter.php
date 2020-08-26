<?hh // strict
/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run
 * /Users/abhikmitra/personalProjects/facebook-hack/ui-server/scripts/build_router.hack
 *
 *
 * @generated SignedSource<<b9ca6e790a97e2faada5fa3d386caf89>>
 */

final class Router
  extends \Facebook\HackRouter\BaseRouter<classname<\HackFacebook\UiServer\Controllers\WebController>> {

  <<__Override>>
  public function getRoutes(
  ): ImmMap<\Facebook\HackRouter\HttpMethod, ImmMap<string, classname<\HackFacebook\UiServer\Controllers\WebController>>> {
    $map = ImmMap {
      \Facebook\HackRouter\HttpMethod::GET => ImmMap {
        '/' => \HackFacebook\UiServer\Controllers\DemoController::class,
        '/notfound' => \HackFacebook\UiServer\Controllers\NotFoundController::class,
      },
    };
    return $map;
  }
}
