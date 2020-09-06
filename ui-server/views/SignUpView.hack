use Facebook\HackRouter\UriPattern;
final class SignUpView extends AbstractView {
    protected async function getBodyAsync(): Awaitable<\XHPRoot> {
        return <div class="content">
            <div class="signup">
                <h3>Sign Up with Username and Password</h3>
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
        return "Sign Up";
    }
    public function __construct() {
        parent::__construct();
    }
}
