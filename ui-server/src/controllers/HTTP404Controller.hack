namespace HackFacebook\UiServer\Controllers;
use namespace HH\Lib\C;

final class HTTP404Controller extends NonRoutableWebPageController {

    protected function getView(): \AbstractView {
        return new \Http404View();
    }

    <<__Override>>
    protected function getStatusCode(): int {
        return 404;
    }
}
