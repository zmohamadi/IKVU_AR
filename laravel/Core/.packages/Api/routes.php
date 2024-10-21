<?php

use Illuminate\Support\Facades\Route;
use Api\Middlewares\TokenCheck;

Route::get('hello', function(){
    return view("vendor.l5-swagger.index");
});

Route::get('home', function(){
    return response()->json(['name'=>'laravel']);
});

Route::get('users-index', 'Person\UserController@index')->middleware(TokenCheck::class);
Route::post('users', 'Person\UserController@storeOrUpdate')->middleware(TokenCheck::class);
Route::post('class-users', 'Person\ClassUserController@storeOrUpdate')->middleware(TokenCheck::class);

Route::get('courses-index', 'Edu\CourseController@index')->middleware(TokenCheck::class);
Route::get('classes-index', 'Edu\ClassController@index')->middleware(TokenCheck::class);
Route::post('courses', 'Edu\CourseController@storeOrUpdate')->middleware(TokenCheck::class);
Route::post('classes', 'Edu\ClassController@storeOrUpdate')->middleware(TokenCheck::class);

?>