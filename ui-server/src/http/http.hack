namespace HackFacebook\UiServer\Http;
use namespace HH\Lib\{C, Vec};
class HttpService {

    public static async function post(
        string $url,
        dict<string, string> $body
    ): Awaitable<string> {
        $post = darray($body);
        $curl = \curl_init($url);
        \curl_setopt($curl, \CURLOPT_POST, 1);
        \curl_setopt($curl, \CURLOPT_POSTFIELDS, $post);
        \curl_setopt($curl, \CURLOPT_RETURNTRANSFER, 1);

        $response = await \HH\Asio\curl_exec($curl);
        $httpcode = \curl_getinfo($curl, \CURLINFO_HTTP_CODE);
        if ($httpcode == 200) {
            \printf("Request is successful with %s", $response);
            return $response;
        }
        throw new \Exception("Request to ".$url." failed with".$httpcode);
    }
}
