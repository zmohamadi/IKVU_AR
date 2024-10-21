<?php

namespace Api\Middlewares;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;
use Models\Base\System;

class TokenCheck
{
    public function handle(Request $request, Closure $next): Response
    {                
        $token = $request->token;
        $ip = $request->ip();
        $system = System::where('api_key', $token)->where('ip', $ip)->first();
        if(!$system){
            return response()->json(["message"=>"your api key for this $ip is not valid!!"], 401);
        }
        $request->request->add(['system_id' => $system->id]);        
        
        return $next($request);
    }
}
