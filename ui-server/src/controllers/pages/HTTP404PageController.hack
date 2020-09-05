namespace HackFacebook\UiServer\Controllers\Pages;
use namespace HH\Lib\C;
use HackFacebook\UiServer\Controllers;
final class HTTP404Controller extends AbstractNonRoutableWebPageController {

    protected function getView(): \AbstractView {
        return new \Http404View();
    }

    <<__Override>>
    protected function getStatusCode(): int {
        return 404;
    }
}
