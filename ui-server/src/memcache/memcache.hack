namespace HackFacebook\UiServer\Memcache;

final class MemcacheConnector {
    private static ?\MCRouter $mcRouter = null;
    private static ?\Memcached $memcacheD = null;
    private static function createMemcacheConnection(): void {
        $servers = Vector {"127.0.0.1:11211"};
        MemcacheConnector::$memcacheD = new \Memcached();
        MemcacheConnector::$memcacheD->addServers($servers->toVArray());
    }

    public static async function addSessionId(string $userId): Awaitable<string> {
        $dateTime = new \DateTime();
        $key = 'sessionId:'.$dateTime->getTimestamp();
        if (MemcacheConnector::$memcacheD == null) {
            MemcacheConnector::createMemcacheConnection();
        }
        invariant(
            MemcacheConnector::$memcacheD != null,
            'Memcache connection failed',
        );
        MemcacheConnector::$memcacheD->set($key, $userId);
        return $key;
    }
}
