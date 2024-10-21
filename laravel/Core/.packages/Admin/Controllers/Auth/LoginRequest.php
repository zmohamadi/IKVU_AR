<?php

namespace Admin\Controllers\Auth;

use Illuminate\Auth\Events\Lockout;
use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Str;
use Illuminate\Validation\ValidationException;

class LoginRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }
    
    public function rules()
    {
        return [
            // 'email' => 'required|string|email',
            // 'mobile' => ['required', 'regex:/(09)[0-9]{9}/', 'exists:users,mobile'],
            'username' => ['required', 'exists:users,username'],
            'password' => 'required|string',
        ];
    }
    
    public function authenticate()
    {
        $this->ensureIsNotRateLimited();
        // dd($this->only('email', 'password'));

        if (! Auth::guard('admin')->attempt($this->only('username', 'password', 'admin_role_id'), $this->filled('remember'))) {
            RateLimiter::hit($this->throttleKey());

            throw ValidationException::withMessages([
                'username' => __('auth.failed'),
            ]);
        }

        RateLimiter::clear($this->throttleKey());
    }
    
    public function ensureIsNotRateLimited()
    {
        if (! RateLimiter::tooManyAttempts($this->throttleKey(), 5)) {
            return;
        }

        event(new Lockout($this));
        $seconds = RateLimiter::availableIn($this->throttleKey());

        throw ValidationException::withMessages([
            'email' => trans('auth.throttle', [
                'seconds' => $seconds,
                'minutes' => ceil($seconds / 60),
            ]),
        ]);
    }
    
    public function throttleKey()
    {
        return Str::lower($this->input('email')).'|'.$this->ip();
    }
}