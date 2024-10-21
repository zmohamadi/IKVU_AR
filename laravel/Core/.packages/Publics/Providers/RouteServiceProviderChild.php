<?php

namespace Publics\Providers;

use Illuminate\Support\Facades\Route;

class RouteServiceProviderChild
{
    public static $namespace = "";

    public static function map()
    {
        self::mapAdminRoutes();
        self::mapApiRoutes();
        self::mapSAdminRoutes();
    }

    protected static function mapAdminRoutes()
    {
        Route::prefix('mastership')
            ->middleware('web')
            ->namespace(self::$namespace."Admin\Controllers")
            ->group(__DIR__ . '/../../Admin/routes.php');
    }
    protected static function mapApiRoutes()
    {
        Route::prefix('api')
            // ->middleware('admin')
            ->namespace(self::$namespace."Api\Controllers")
            ->group(__DIR__ . '/../../Api/routes.php');
    }

    protected static function mapSAdminRoutes()
    {
        Route::prefix('SAdmin')
            // ->middleware('admin')
            ->namespace(self::$namespace."SAdmin\Controllers")
            ->group(__DIR__ . '/../../SAdmin/routes.php');
    }

}
