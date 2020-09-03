namespace HackFacebook\UiServer\Controllers;
use type HHVM\UserDocumentation\LocalConfig;
use type HHVM\UserDocumentation\UIGlyphIcon;
use type Facebook\Experimental\Http\Message\{
  ResponseInterface,
  ServerRequestInterface,
};

use namespace HH\Lib\C;
use HackFacebook\UiServer\Http\Exceptions\RedirectException;
use HackFacebook\UiServer\Controllers\WebController;
use namespace HackFacebook\UiServer\Http;
abstract class NonRoutableWebPageController extends WebController {

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

  protected function getStatusCode(): int {
    return 200;
  }

  /* If you're reading this, you probably want to remove 'final' so that you
   * can pull stuff out of $request or $parameters. Instead:
   *
   * - use getRequiredStringParam() and friends to get the data you need in a
   *   safe and abstracted way
   * - if there isn't an existing abstraction that fits your needs, add one
   */
  final public function __construct(
    ImmMap<string, string> $parameters,
    private ServerRequestInterface $request,
  ) {
    parent::__construct($parameters, $request);
  }

}
