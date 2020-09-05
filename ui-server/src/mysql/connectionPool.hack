namespace HackFacebook\UiServer\MySQL;

function get_pool(): \AsyncMysqlConnectionPool {
    return new \AsyncMysqlConnectionPool(
        darray['pool_connection_limit' => 5],
    ); // See API for more pool options
}

async function get_connection(): Awaitable<\AsyncMysqlConnection> {
    $pool = get_pool();
    $conn = await $pool->connect(
        "qn0cquuabmqczee2.cbetxkdyhwsb.us-east-1.rds.amazonaws.com",
        3306,
        "wvuw43bc4oyh0d8w",
        "ii0fuav2snkd9x7o",
        "are5ro6siqeldz0f",
        10000000
    );
    return $conn;
}
