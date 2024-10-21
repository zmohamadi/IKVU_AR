<?php

namespace Api\Controllers\Auth;

use App\Http\Controllers\Controller;

class UserInfo extends Controller
{
    public function getInfo(){
        // return response()->json(["user"=>\Auth::guard('Api')->user()]);
        if(\Auth::guard('Api')->user())
            return response()->json(\Auth::guard('Api')->user());
        else
        return response("");
    }
}
