<?php
declare(strict_types=1);

namespace App\Presentation\Http\Controller;

use PDO;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;

final class VerifyController
{
    public function __construct(private PDO $pdo) {}

    public function __invoke(Request $req, Response $res): Response
    {
        try {
            $this->pdo->query('SELECT 1');
            $tables = $this->pdo->query('SHOW TABLES FROM agrarian_db')->fetchAll(\PDO::FETCH_COLUMN) ?: [];
            $expected = ['users','user_types','user_levels','subjects','user_user_types','user_user_levels','user_subjects'];
            $missing = array_values(array_diff($expected, $tables));

            $res->getBody()->write(json_encode([
                'db' => 'agrarian_db',
                'connected' => true,
                'tables_found' => $tables,
                'missing_tables' => $missing
            ], JSON_UNESCAPED_UNICODE));
            return $res->withHeader('Content-Type','application/json');
        } catch (\Throwable $e) {
            $res->getBody()->write(json_encode(['connected'=>false,'error'=>$e->getMessage()]));
            return $res->withStatus(500)->withHeader('Content-Type','application/json');
        }
    }
}
