<?php
declare(strict_types=1);

use App\Presentation\Http\Controller\VerifyController;
use Slim\App;
// REMOVE this line ↓
// use PDO;

return function (App $app): void {
    $c = $app->getContainer();

    // change PDO::class → \PDO::class to be explicit
    $c->set(VerifyController::class, fn($c)=> new VerifyController($c->get(\PDO::class)));

    $app->get('/health', function($req,$res){
        $res->getBody()->write(json_encode(['status'=>'ok']));
        return $res->withHeader('Content-Type','application/json');
    });

    $app->get('/verify-db', VerifyController::class);
};
