<?php

namespace Admin;

use Illuminate\Support\ServiceProvider;

class AdminServiceProvider extends ServiceProvider
{
    public function boot()
    {
        $path = __DIR__."/../Publics/lang";
        str_replace('/', DIRECTORY_SEPARATOR, $path);
        $this->loadTranslationsFrom($path , "AdminLang");
    }
}
