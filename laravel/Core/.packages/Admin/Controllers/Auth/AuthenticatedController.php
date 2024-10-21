<?php

namespace Admin\Controllers\Auth;

use App\Http\Controllers\Controller;
use Admin\Controllers\Auth\LoginRequest;
use App\Providers\RouteServiceProvider;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AuthenticatedController extends Controller
{
    /**
     * Handle an incoming authentication request.
     *
     * @param  \App\Http\Requests\Auth\LoginRequest  $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(LoginRequest $request)
    {
        $request->authenticate();
        $request->session()->regenerate();
        return response()->noContent();
    }

    public function store1(Request $request)
    {
        // Validate user credentials
        if (!Auth::attempt($request->only(['email', 'password']))) {
            // return $this->failedRequest('', 'Invalid email address or password', 400);
            return response()->json(['message'=>'Invalid email address or password'], 400);
        }

        // Regenerate the user's session to prevent session fixation
        $request->session()->regenerate();

        // Sign in user
        Auth::login(Auth::user());

        // Return data
        return $this->successfullRequest(Auth::user(), 'User successfully logged in', 200);
    }

    /**
     * Destroy an authenticated session.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy(Request $request)
    {
        Auth::guard('admin')->logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return response()->noContent();
    }
}