namespace HackFacebook\UiServer\Controllers;
use type Facebook\HackRouter\{RequestParameter, RequestParameters};
use type Facebook\TypeAssert\IncorrectTypeException;
use type Facebook\Experimental\Http\Message\{
    ResponseInterface,
    ServerRequestInterface,
};
use namespace Facebook\TypeAssert;
use namespace HH\Lib\{C, Str, Vec};
use HackFacebook\UiServer\GlobalValues;
<<__ConsistentConstruct>>
abstract class AbstractWebController {

    const type TParameterDefinitions = shape(
        'required' => ImmVector<RequestParameter>,
        'optional' => ImmVector<RequestParameter>,
    );

    private RequestParameters $parameters;
    private ImmMap<string, string> $rawParameters;
    public function __construct(
        ImmMap<string, string> $parameters,
        private ServerRequestInterface $request,
    ) {
        $combined_params = $parameters->toDArray();
        foreach ($request->getQueryParams() as $key => $value) {
            if (\is_array($value)) {
                continue;
            }
            $combined_params[(string)$key] = (string)$value;
        }
        $spec = self::getParametersSpec();
        $this->parameters = new RequestParameters(
            $spec['required'],
            $spec['optional'],
            new ImmMap($combined_params),
        );
        $this->rawParameters = new ImmMap($combined_params);
    }

    final public static function getParametersSpec(
    ): self::TParameterDefinitions {
        $uri = self::getUriParametersSpec();
        $extra = static::getExtraParametersSpec();
        return shape(
            'required' => $uri['required']->concat($extra['required']),
            'optional' => $uri['optional']->concat($extra['optional']),
        );
    }

    final private static function getUriParametersSpec(
    ): self::TParameterDefinitions {
        try {
            $class = TypeAssert\classname_of(
                IRoutableController::class,
                static::class,
            );
        } catch (IncorrectTypeException $e) {
            return shape(
                'required' => ImmVector {},
                'optional' => ImmVector {},
            );
        }
        return shape(
            'required' => $class::getUriPattern()->getParameters(),
            'optional' => ImmVector {},
        );
    }

    protected static function getExtraParametersSpec(
    ): self::TParameterDefinitions {
        return shape('required' => ImmVector {}, 'optional' => ImmVector {});
    }
    abstract public function getResponseAsync(
        ResponseInterface $response,
    ): Awaitable<ResponseInterface>;

    final protected function getRawParameter_UNSAFE(string $name): ?string {
        $params = $this->rawParameters;
        if (!$params->containsKey($name)) {
            return null;
        }
        return $params->at($name);
    }

    final protected function getRawBody_UNSAFE(string $name): ?string {
        return GlobalValues\getPostParams($name);
    }

    final protected function getRawCookie_UNSAFE(string $name): ?string {
        return idx($this->request->getCookieParams(),$name, null);
    }
}
