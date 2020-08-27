namespace HackFacebook\UiServer\Controllers;
use Facebook\HackRouter\UriPattern;

final class NotFoundController extends WebController {

    <<__Override>>
    public static function getUriPattern(): UriPattern {
        return (new UriPattern())
            ->literal('/notfound');
    }

    <<__Override>>
    public function getResponse(): string {
        return 'Not found';
    }
}
