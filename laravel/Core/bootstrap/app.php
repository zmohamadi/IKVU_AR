<?php

use Illuminate\Foundation\Application;
use Publics\Providers\RouteServiceProviderChild;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        // api: __DIR__.'/../routes/api.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
        using: function(){
            RouteServiceProviderChild::map();
        }
    )
    ->withMiddleware(function (Middleware $middleware) {
        $middleware->statefulApi();
        $middleware->validateCsrfTokens(except: [
            'mastership/*',
            'api/*',
        ]);
        // $middleware->web(prepend: [
        //     Laravel\Sanctum\Http\Middleware\EnsureFrontendRequestsAreStateful::class, 
        // ]);
    })
    ->withExceptions(function (Exceptions $exceptions) {
        //
    })->create()
      ->usePublicPath('../public_html');
