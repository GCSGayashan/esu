<?php
declare(strict_types=1);

use Slim\Factory\AppFactory;
use App\Infrastructure\Bootstrap\Bootstrap;

require __DIR__ . '/../vendor/autoload.php';

Bootstrap::initEnv(__DIR__ . '/../');
$container = Bootstrap::container();
AppFactory::setContainer($container);

$app = AppFactory::create();
$app->addBodyParsingMiddleware();

(require __DIR__ . '/../src/Presentation/routes.php')($app);

$app->run();
