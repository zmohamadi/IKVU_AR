<?php

namespace SAdmin\Controllers\Auth;

use App\Http\Controllers\Controller;

class UserInfo extends Controller
{
    public function getInfo(){
        return response()->json(["user"=>\Auth::guard('web')->user()]);
    }
}
