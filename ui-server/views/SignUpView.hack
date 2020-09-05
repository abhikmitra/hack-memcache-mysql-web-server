use Facebook\HackRouter\UriPattern;
final class SignUpView extends AbstractView {
    protected async function getBodyAsync(): Awaitable<\XHPRoot> {
        return <div class="content">
            <div class="login">
                <h3>Login</h3>
                <form action="/signUp" method="post">
                    <input name="username" type="text" placeholder="Username"/><br/>
                    <input name="password" type="password" placeholder="Username" />
                    <br />
                    <input type="submit" title="Register" />
                </form>
            </div>

        </div>;
    }
    public function getCSS(): Set<string> {
        return Set {"css/signup.css"};
    }
    public function getJS(): Set<string> {
        return Set {"js/signup.js"};
    }
    protected async function getTitleAsync(): Awaitable<string> {
        return "Login";
    }
    public function __construct() {
        parent::__construct();
    }
}
