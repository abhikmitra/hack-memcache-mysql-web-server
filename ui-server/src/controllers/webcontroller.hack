namespace HackFacebook\UiServer\Controllers;
use type Facebook\HackRouter\{
    BaseRouter,
    GetFastRoutePatternFromUriPattern,
    GetUriBuilderFromUriPattern,
    HasUriPattern,
    HttpMethod,
    RequestParameters,
    UriPattern,
    IncludeInUriMap,
    SupportsGetRequests
};

<<__ConsistentConstruct>>
abstract class WebController
    implements IncludeInUriMap, HasUriPattern, SupportsGetRequests {
    use GetFastRoutePatternFromUriPattern;
    use GetUriBuilderFromUriPattern;

    abstract public function getResponse(): string;

    private RequestParameters $uriParameters;
    final protected function getRequestParameters(): RequestParameters {
        return $this->uriParameters;
    }

    public function __construct(ImmMap<string, string> $uri_parameter_values) {
        $this->uriParameters = new RequestParameters(
            static::getUriPattern()->getParameters(),
            ImmVector {},
            $uri_parameter_values,
        );
    }
}
