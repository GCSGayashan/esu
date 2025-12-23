<?php
declare(strict_types=1);

namespace App\Infrastructure\Bootstrap;

use DI\Container;
use Dotenv\Dotenv;
use PDO;

final class Bootstrap
{
    public static function initEnv(string $rootPath): void
    {
        if (is_file($rootPath.'/.env')) {
            Dotenv::createImmutable($rootPath)->load();
        }
    }

    public static function container(): Container
    {
        $c = new Container();
        $c->set(PDO::class, function () {
            $dsn  = $_ENV['DB_DSN']  ?? '';
            $user = $_ENV['DB_USER'] ?? '';
            $pass = $_ENV['DB_PASS'] ?? '';
            return new PDO($dsn, $user, $pass, [
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES => false,
            ]);
        });
        return $c;
    }
}
