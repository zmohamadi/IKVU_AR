<?php

namespace Publics\Middlewares;

use Closure;

class Corss
{
    public function handle($request, Closure $next)
    {
        // header("Access-Control-Allow-Origin: *");
        // header("Access-Control-Allow-Headers: X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method, Authorization, X-API-KEY, Origin, X-Requested-With, Content-Type, Accept, Access-Control-Request-Method, Authorization");
        // header("Access-Control-Allow-Methods: PUT, POST, GET, OPTIONS, DELETE");
        // header("Access-Control-Allow-Credentials: true");
        // header("Access-Control-Max-Age: 1000");

        // header('Access-Control-Allow-Origin: *');
        // header("Access-Control-Allow-Credentials: true");
        // header('Access-Control-Allow-Methods: POST,GET,DELETE,PUT,PATCH,OPTIONS');
        // header('Access-Control-Allow-Headers: Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token');
        // header('Access-Control-Max-Age: 1728000');
        // header('Content-Type: application/json');

        // header('Access-Control-Allow-Origin: 127.0.0.1:3000');
        // header('Access-Control-Allow-Headers: *');
        // header('Access-Control-Allow-Headers: Origin, Content-Type, X-Auth-Token , Authorization');
        // header('Access-Control-Allow-Headers: *');
        // header('Content-Length: 0');
        
        // header("Access-Control-Allow-Origin: *");
        // header("Access-Control-Allow-Credentials: true");
        // header("Access-Control-Max-Age: 1000");
        // header("Access-Control-Allow-Headers: X-Requested-With, Content-Type, Origin, Cache-Control, Pragma, Authorization, Accept, Accept-Encoding");
        // header("Access-Control-Allow-Methods: PUT, POST, GET, OPTIONS, DELETE");
        
        header('Access-Control-Allow-Origin: *');
        header('Access-Control-Allow-Methods: GET, PUT, POST, DELETE, OPTIONS, forum, get');
        header('Access-Control-Max-Age: 3600');
        header('Access-Control-Allow-Headers: Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token');
        header('Access-Control-Allow-Credentials: true');

        return $next($request);           
    }
}
