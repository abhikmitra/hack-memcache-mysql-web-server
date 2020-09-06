namespace HackFacebook\UiServer\MySQL;

use HackFacebook\UiServer\Constants;
function get_pool(): \AsyncMysqlConnectionPool {
    return new \AsyncMysqlConnectionPool(
        darray['pool_connection_limit' => 5],
    ); // See API for more pool options
}

async function get_connection(): Awaitable<\AsyncMysqlConnection> {
    $pool = get_pool();
    $conn = await $pool->connect(
        Constants::MYSQL_CONNECTION_HOST,
        Constants::MYSQL_CONNECTION_PORT,
        Constants::MYSQL_CONNECTION_DATABASE,
        Constants::MYSQL_CONNECTION_USER,
        Constants::MYSQL_CONNECTION_PASSWORD,
        10000000
    );
    return $conn;
}
