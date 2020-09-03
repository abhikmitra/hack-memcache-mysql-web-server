require_once(__DIR__.'/../vendor/hh_autoload.php');

use \Facebook\HackRouter\Codegen;
use \HackFacebook\UserService\Controllers\WebController;

final class UpdateCodegen {
    public function main(): void {
        Codegen::forTree(
            __DIR__.'/../src/controllers/',
            shape(
                'controllerBase' => WebController::class,
                'router' => shape(
                    'abstract' => false,
                    'file' => __DIR__.'/../src/RequestRouter/AutoGeneratedRouter.php',
                    'class' => 'Router',
                ),
            ),
        )->build();
    }
}


<<__EntryPoint>>
async function main(): Awaitable<noreturn> {
    $codegen = new UpdateCodegen();
    $codegen->main();
    exit(0);
}
