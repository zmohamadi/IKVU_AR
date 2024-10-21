<?php

namespace Publics\Middlewares;

use Closure;

class Lang
{
    public function handle($request, Closure $next)
    {
        header("Access-Control-Allow-Origin: *");
        header("Access-Control-Allow-Headers: X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method, Authorization");
        header("Access-Control-Allow-Methods: PUT, POST, GET, OPTIONS, DELETE");
        header("Access-Control-Allow-Credentials: true");
        header("Access-Control-Max-Age: 1000");

        $lang = $request->input('lang');
        if($lang=="") $lang ="fa";
        \App::setLocale($lang);
        
        $routes = $request->route();        
        $routes->forgetParameter('lang');

        return $next($request);           
    }
}
