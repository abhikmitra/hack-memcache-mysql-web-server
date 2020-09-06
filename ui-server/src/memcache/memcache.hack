namespace HackFacebook\UiServer\Memcache;
use HackFacebook\UiServer\Constants;
final class MemcacheConnector {
    private static ?\MCRouter $mcRouter = null;
    private static ?\Memcached $memcacheD = null;
    private static function createMemcacheConnection(): void {
        $servers = Vector {Constants::MEMCACHE_CONNECTION};
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

    public static function getUserIdBySessionId(
        string $userId,
    ): string {
        $dateTime = new \DateTime();
        $key = 'sessionId:'.$dateTime->getTimestamp();
        if (MemcacheConnector::$memcacheD == null) {
            MemcacheConnector::createMemcacheConnection();
        }
        invariant(
            MemcacheConnector::$memcacheD != null,
            'Memcache connection failed',
        );
        MemcacheConnector::$memcacheD->get($key);
        return $key;
    }
}
