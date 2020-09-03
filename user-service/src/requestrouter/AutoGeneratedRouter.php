<?hh // strict
/**
 * This file is generated. Do not modify it manually!
 *
 * To re-generate this file run
 * /Users/abhikmitra/personalProjects/facebook-hack/user-service/scripts/build_router.hack
 *
 *
 * @generated SignedSource<<968ed6de0888dd9b4c2407c3df7631e7>>
 */

final class Router
  extends \Facebook\HackRouter\BaseRouter<classname<\HackFacebook\UserService\Controllers\WebController>> {

  <<__Override>>
  public function getRoutes(
  ): ImmMap<\Facebook\HackRouter\HttpMethod, ImmMap<string, classname<\HackFacebook\UserService\Controllers\WebController>>> {
    $map = ImmMap {
      \Facebook\HackRouter\HttpMethod::GET => ImmMap {
        '/notfound' =>
          \HackFacebook\UserService\Controllers\NotFoundController::class,
      },
      \Facebook\HackRouter\HttpMethod::POST => ImmMap {
        '/user' =>
          \HackFacebook\UserService\Controllers\RegistrationPostController::class,
        '/login' =>
          \HackFacebook\UserService\Controllers\UserLoginPostController::class,
      },
    };
    return $map;
  }
}
