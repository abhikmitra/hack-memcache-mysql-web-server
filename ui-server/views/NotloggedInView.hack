class NotLoggedinView extends AbstractView {
    protected async function getBodyAsync(): Awaitable<\XHPRoot> {
        return <div>Please <a href="/login">login</a> too see this view.</div>;
    }
    public function getCSS(): Set<string> {
        return Set {};
    }
    public function getJS(): Set<string> {
        return Set {};
    }
    protected function getTitle(): string {
        return "Not logged in";
    }
    protected async function getTitleAsync(): Awaitable<string> {
        return "Error";
    }
    public function __construct() {
        parent::__construct();
    }
}
