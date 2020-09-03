class Http404View extends AbstractView {
    protected async function getBodyAsync(): Awaitable<\XHPRoot> {
        return <div>Page Not Found!</div>;
    }
    public function getCSS(): Set<string> {
        return Set {};
    }
    public function getJS(): Set<string> {
        return Set {};
    }
    protected function getTitle(): string {
        return "Not Found";
    }
    protected async function getTitleAsync(): Awaitable<string> {
        return "Http 404 Page";
    }
    public function __construct() {
        parent::__construct();
    }
}