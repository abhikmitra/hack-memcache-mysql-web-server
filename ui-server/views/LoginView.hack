use Facebook\HackRouter\UriPattern;
final class LoginView extends AbstractView {
    protected async function getBodyAsync(): Awaitable<\XHPRoot> {
        return <div class="content">
            <div class="login">
                <form action="/login" method="post">
                    <input name="username" type="text" placeholder="Username"/><br/>
                    <input name="password" type="password" placeholder="Username" />
                    <br />
                    <input type="submit" />
                </form>
            </div>

        </div>;
    }
    public function getCSS(): Set<string> {
        return Set {"css/login.css"};
    }
    public function getJS(): Set<string> {
        return Set {"js/login.js"};
    }
    protected async function getTitleAsync(): Awaitable<string> {
        return "Login";
    }
    public function __construct() {
        parent::__construct();
    }
}
