<?php

namespace SAdmin;

use Illuminate\Support\ServiceProvider;

class SAdminServiceProvider extends ServiceProvider
{
    public function boot()
    {
        $path = __DIR__."/langs";
        str_replace('/', DIRECTORY_SEPARATOR, $path);
        $this->loadTranslationsFrom($path , "SAdminLang");
        
        // $this->app['router']->aliasMiddleware('InertiaShare', \Admin\Middlewares\InertiaShare::class);
    }

    public function register(){}

}
