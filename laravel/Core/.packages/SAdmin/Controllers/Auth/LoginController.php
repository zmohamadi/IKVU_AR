<?php

namespace SAdmin\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Http\Request;
use \Models\Base\Language;
use \Auth;

class LoginController extends Controller
{

    use AuthenticatesUsers {
        logout as performLogout;
    }

    public function guard(){
        return Auth::guard('admin');
    }

    public function username(){
        return "mobile";
    }

    public function showLoginForm()
    {
        $activeLangs = \Models\Base\Language::active()->get();
        return view('admin::auth.login')->with(compact('activeLangs'));
    }

    public function attemptLogin(Request $request)
    {
        if (Auth::guard('admin')->attempt(['mobile' => $request->mobile, 'password' => $request->password, 'is_admin' => 1])) {
            return redirect()->intended($this->redirectTo());
        }
    }

    public function authenticated(Request $request)
    {
        $lang = \App::getLocale();
        $user = \Auth::guard('admin')->user();
        $user_role_id = $user->role_id;

        $currency = ($lang == "fa")? "Toman" : "Dollar" ;
        $activeLangs = \Models\Base\Language::active()->select('id','symbol')->get();
        $activeLangsArray = [];
        foreach($activeLangs as $lang)
        {
            $activeLangsArray[] = $lang->symbol;
        }

        \Session::put("is_admin", 1);
        \Session::put("role_id", $user_role_id);
        \Session::put("currency", $currency);
        \Session::put("adminLang", $lang);
        \Session::put('activeLangs', $activeLangsArray);
    }

    public function redirectTo()
    {
        $hash = request()->hash;
        if($hash == "") $hash = "mastership#/manage";
        return '/mastership#/manage';

    }

    public function logout(Request $request)
    {
        $this->performLogout($request);
        return redirect("/");
    }

   protected function validateLoginCustom(Request $request)
    {
        $this->validate($request, [
            'mobile' => 'exists:person_users,mobile|digits:11|required',
            'password' => 'required',
        ]);
    }
}
