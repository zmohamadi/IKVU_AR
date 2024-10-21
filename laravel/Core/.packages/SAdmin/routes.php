<?php

Route::get('/user',"Auth\UserInfo@getInfo");
Route::get('/langs',function(){
    App::setLocale("fa");
    // dd(Lang::get("AdminLang::public"));
    return response()->json(["public"=>\Lang::get("SAdminLang::public")]);
});
Route::post('/upload/{dir}', "PublicCLR\Upload@uploadFile");
Route::get('/deleteFile/{dir}/{file}', "PublicCLR\Upload@deleteFile");


Route::group(['middleware'=>[]], function(){
    Route::resource('/menus',"System\MenuController");
    Route::resource('/systems-sadmin',"System\SystemController");
    // Route::get("/blogs/get-needles", "Content\BlogController@getNeedles");
});


