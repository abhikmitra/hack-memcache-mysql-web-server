namespace HackFacebook\UserService;
use HackFacebook\UserService\RequestRouter\FBRouter;

require_once(__DIR__.'/../vendor/autoload.hack');


<<__EntryPoint>>
async function main(): Awaitable<void> {
    \Facebook\AutoloadMap\initialize();
    $response = await FBRouter::get()->controller->getResponse();
    echo($response);
}
