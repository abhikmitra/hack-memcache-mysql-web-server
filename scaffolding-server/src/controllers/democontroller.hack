namespace HackFacebook\UiServer\Controllers;
use Facebook\HackRouter\UriPattern;
final class DemoController extends WebController {
    <<__Override>>
    public static function getUriPattern(): UriPattern {
        return (new UriPattern())->literal('/');
    }

    <<__Override>>
    public function getResponse(): string {
        return 'Hello, world';
    }
}
