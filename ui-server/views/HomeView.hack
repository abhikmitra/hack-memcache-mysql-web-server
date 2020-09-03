class HomeView extends AbstractView {
    protected async function getBodyAsync(): Awaitable<\XHPRoot> {
        return <div>Congratulations! You Are logged In</div>;
    }
    public function getCSS(): Set<string> {
        return Set {"css/homepage.css"};
    }
    public function getJS(): Set<string> {
        return Set {"js/homepage.js"};
    }
    protected function getTitle(): string {
        return "Login";
    }
    protected async function getTitleAsync(): Awaitable<string> {
        return "HomePage";
    }
    public function __construct() {
        parent::__construct();
    }
}
