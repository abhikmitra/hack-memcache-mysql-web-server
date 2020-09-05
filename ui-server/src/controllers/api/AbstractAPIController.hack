namespace HackFacebook\UiServer\Controllers\API;
use HackFacebook\UiServer\Controllers\AbstractWebController;
use type Facebook\Experimental\Http\Message\{
    ResponseInterface,
    ServerRequestInterface,
};
use namespace HH\Lib\{C, Dict, Math, Str, Vec};

abstract class AbstractAPIController<TResponseData>
    extends AbstractWebController {
    abstract const type PostRequestParams;
    /** Extend this if you want custom logic (e.g. redirects) before anything
     * else happens. */
    protected async function beforeResponseAsync(): Awaitable<void> {}
    protected abstract function getAPIResponseAsync(
    ): Awaitable<shape(
        'statusCode' => int,
        'data' => TResponseData,
        ?'headers' => dict<string, vec<string>>,
    )>;

    <<__Override>>
    final public async function getResponseAsync(
        ResponseInterface $response,
    ): Awaitable<ResponseInterface> {
        $this->validateRequest();
        await $this->beforeResponseAsync();
        $apiResponse = await $this->getAPIResponseAsync();
        $error = tuple(1, "");
        await $response->getBody()
            ->writeAllAsync(
                \json_encode($apiResponse["data"])
            );
        $response = $response
            ->withStatus($apiResponse["statusCode"])
            ->withHeader(
                'Content-type',
                vec['application/json', 'charset=utf-8'],
            );
        $headers = Shapes::idx($apiResponse, 'headers', null);
        if ($headers != null && C\count($headers) != 0) {
            foreach ($headers as $key => $values) {
                $response = $response->withAddedHeader($key, $values);
            }
        }
        return $response;
    }

    public function validateRequest(): void {
        $x = new \ReflectionClass($this);
        $typeConstants = vec($x->getTypeConstants());
        $postRequestParam = C\find(
            $typeConstants,
            ($t) ==> $t->getName() == "PostRequestParams",
        );
        if ($postRequestParam == null){
            \printf("test");
            return;
        }
        /* HH_IGNORE_ERROR[4053] getTypeStructure is availabnle as per the doc */
        $fields = $postRequestParam->getTypeStructure()["fields"];
        foreach ($fields as $field => $_) {
            $val = $this->getRawBody_UNSAFE($field);
            invariant($val != null, "Required Parameter");
        }
    }
    final public function __construct(
        ImmMap<string, string> $parameters,
        private ServerRequestInterface $request,
    ) {
        parent::__construct($parameters, $request);
    }
}
