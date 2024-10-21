<?php

namespace Admin\Middlewares;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class Origin
{
    public function handle(Request $request, Closure $next): Response
    {                
        $request->header('Access-Control-Allow-Origin: *');
        $request->header('Access-Control-Allow-Methods: POST, GET, DELETE, PUT, PATCH, OPTIONS');
        $request->header('Access-Control-Allow-Headers: token, Content-Type, X-Requested-With');
        return $next($request);
    }
}
