namespace HackFacebook\UiServer;
require_once(__DIR__.'/../vendor/autoload.hack');
<<__EntryPoint>>
async function main(): Awaitable<noreturn> {
    \Facebook\AutoloadMap\initialize();
    \printf("Hello World");
    exit(0);
}
