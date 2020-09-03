<?hh // strict
namespace HackFacebook\UiServer;
use HackFacebook\UiServer\RequestRouter\FBRouter;
use HackFacebook\UiServer\GlobalValues;
use type Facebook\Experimental\Http\Message\{
    ResponseInterface,
    ServerRequestInterface,
};
use namespace HH\Lib\{File, IO, Math};
use HackFacebook\UiServer\Http\Exceptions\{
  HTTPNotFoundException,
  RedirectException,
  HTTPException,
  HTTPMethodNotAllowedException
};
use Facebook\HackRouter\{
  HttpMethod,
  NotFoundException,
  MethodNotAllowedException
};
use HackFacebook\UiServer\Controllers;
use HackFacebook\UiServer\RequestRouter;
require_once(__DIR__.'/../vendor/autoload.hack');


<<__EntryPoint>>
async function main(): Awaitable<void> {
    \Facebook\AutoloadMap\initialize();
    $request = \Usox\HackTTP\create_server_request_from_globals();
    $server = GlobalValues\server_variables();
    $dummy_uri = 'http://'.$server['HTTP_HOST'].'/';
    $host = \parse_url($dummy_uri, \PHP_URL_HOST);
    $port = \parse_url($dummy_uri, \PHP_URL_PORT);
    $request = $request->withUri(
        $request->getUri()
            ->withHost($host)
            ->withPort($port)
            ->withScheme('http'),
    );

    $buffer_path = \sys_get_temp_dir().'/'.\bin2hex(\random_bytes(16));
    $write_handle = File\open_write_only(
        $buffer_path,
        File\WriteMode::MUST_CREATE,
    );
    $response = (new \Usox\HackTTP\Response($write_handle));
    $response = await getResponseForRequestAsync($request, $response);
    \http_response_code($response->getStatusCode());
    foreach ($response->getHeaders() as $key => $values) {
        foreach ($values as $value) {
            \header($key.': '.$value, /* replace = */ false);
        }
    }
    $write_handle->close();
    $read_handle = File\open_read_only($buffer_path);
    using ($read_handle->closeWhenDisposed()) {
        $out = IO\request_output();
        $content = await $read_handle->readAsync(Math\INT64_MAX);
        await $out->writeAllAsync($content);
    }
    \unlink($buffer_path);
}

async function getResponseForRequestAsync(
    ServerRequestInterface $request,
    ResponseInterface $response,
  ): Awaitable<ResponseInterface> {
    try {
      try {
        list($controller, $vars) = routeRequest($request);
      } catch (HTTPNotFoundException $e) {
        // Try to add trailing if we couldn't find a controller
        $orig_uri = $request->getUri();
        $with_trailing_slash = $request
          ->withUri($orig_uri->withPath($orig_uri->getPath().'/'));

        try {
          list($controller, $vars) = routeRequest($with_trailing_slash);
          // If we're here, it's routable with a trailing /
          return await (
            new RedirectException($with_trailing_slash->getUri()->getPath())
          )->getResponseAsync($request, $response);
        } catch (HTTPException $f) {
          throw $e; // original exception, not the new one
        }
      }

      // This is outside of the try so that we don't try adding a trailing
      // slash if the controller itself throws a 404
      return await (new $controller($vars, $request))->getResponseAsync(
        $response,
      );
    } catch (HTTPException $e) {
      return await $e->getResponseAsync($request, $response);
    }
  }

function routeRequest(
    ServerRequestInterface $request,
): (classname<Controllers\RoutableController>, ImmMap<string, string>) {
    try {
    return (new RequestRouter\FBRouter())->routeRequest($request);
    } catch (NotFoundException $e) {
      throw new HTTPNotFoundException('', 0, $e);
    } catch (MethodNotAllowedException $e) {
      throw new HTTPMethodNotAllowedException('', 0, $e);
    }
  }
  