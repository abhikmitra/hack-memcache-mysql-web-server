use Facebook\HackRouter\UriPattern;
final class LoginView extends AbstractView {
    public function getBody(): \XHPRoot {
        return <div class="content">
            <div class="login">
                <h3>Login</h3>
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
    protected function getTitle(): string {
        return "Login";
    }
}
