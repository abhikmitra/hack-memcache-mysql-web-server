namespace HackFacebook\UiServer\Models;
use HackFacebook\UiServer\MySQL;
type UserLoginDetails = shape('id' => string, 'userName' => string, 'password' => string);
final class User {

    public static async function getUserByNameAndPassword(
        string $userName,
        string $password
    ): Awaitable<string> {
        $conn = await MySQL\get_connection();
        $result = await $conn->queryf(
            'SELECT id from User WHERE username = %s and password = %s',
            $userName,
            $password,
        );
        
        invariant($result->numRows() === 1, 'User is not found');
        $val = $result->vectorRows()[0][0];
        invariant($val != null, 'User is found');
        return $val;
    }

    public static async function createUser(
        string $userName,
        string $password,
    ): Awaitable<string> {
        $conn = await MySQL\get_connection();
        $result = await $conn->queryf(
            'INSERT INTO User(username,password) VALUES (%s, %s)',
            $userName,
            $password,
        );

        invariant($result->numRowsAffected() === 1, 'User registration successful');
        return $userName;
    }
}
