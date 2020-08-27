namespace HackFacebook\UiServer;
use HackFacebook\UiServer\RequestRouter\FBRouter;

require_once(__DIR__.'/../vendor/autoload.hack');


<<__EntryPoint>>
async function main(): Awaitable<void> {
    \Facebook\AutoloadMap\initialize();
    echo(FBRouter::get()->controller->getResponse());
}
