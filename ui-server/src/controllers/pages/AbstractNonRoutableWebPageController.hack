namespace HackFacebook\UiServer\Controllers\Pages;
use type HHVM\UserDocumentation\LocalConfig;
use type HHVM\UserDocumentation\UIGlyphIcon;
use type Facebook\Experimental\Http\Message\{
  ResponseInterface,
  ServerRequestInterface,
};

use namespace HH\Lib\C;
use HackFacebook\UiServer\Http\Exceptions\RedirectException;
use HackFacebook\UiServer\Controllers\AbstractWebController;
use namespace HackFacebook\UiServer\Http;
use HackFacebook\UiServer\Constants;
abstract class AbstractNonRoutableWebPageController extends AbstractWebController {

  protected abstract function getView(): \AbstractView;
  /** Extend this if you want custom logic (e.g. redirects) before anything
   * else happens. */
  protected async function beforeResponseAsync(): Awaitable<void> {}

  <<__Override>>
  final public async function getResponseAsync(
    ResponseInterface $response,
  ): Awaitable<ResponseInterface> {
    await $this->beforeResponseAsync();
    $xhp = await $this->getView()->render();
    $xhp->setContext('ServerRequestInterface', $this->request);
    $html = $xhp->toString();
    await $response->getBody()->writeAllAsync($html);
    $response = $response
      ->withStatus($this->getStatusCode())
      ->withHeader(
        'Cache-Control',
        vec['max-age=60'],
      ); // enough for pre-fetching :)

    return $response;
  }

  final protected function getSessionId(): ?string {
    return $this->getRawCookie_UNSAFE(Constants::SESSION_ID_COOKIE);
  }

  protected function getStatusCode(): int {
    return 200;
  }

  final public function __construct(
    ImmMap<string, string> $parameters,
    private ServerRequestInterface $request,
  ) {
    parent::__construct($parameters, $request);
  }

}
