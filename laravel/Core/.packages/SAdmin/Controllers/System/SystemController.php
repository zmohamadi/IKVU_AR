<?php

namespace SAdmin\Controllers\System;

use SAdmin\Controllers\PublicCLR\BaseAbstract;

class SystemController extends BaseAbstract
{
    protected $model = "SAdmin\Models\System";
    protected $request = "SAdmin\Requests\SystemRequest";
    protected $with = ["menus","permissions"];
    protected $searchFilter = ["name","title_fa", ""];
    // protected $needles = ["Content\BlogSubject"];
    // protected $showWith = ["imageFiles","videoFiles","keywords"];
    // protected $except = ["images","videos"];
    // protected $destroy = ["keywords","Content\BlogFile","Content\BlogComment"];
    // protected $files = [
    //     "image","thumb",
    //     "images"=>[ "model"=>"Models\Content\BlogFile", "url"=>"/../public_html/media/blogs/galleries", "file_category_id"=>"7", "fk"=>"blog_id"],
    //     "videos"=>[ "model"=>"Models\Content\BlogFile", "url"=>"/../public_html/media/blogs/galleries", "file_category_id"=>"6", "fk"=>"blog_id"]
    // ];
    
    // public function index()
    // {
    //     $cities = parent::index()->getData();
    //     $needles = parent::getNeedles()->getData();
    //     // dd($cities);
    //     return Inertia::render('Content/Blogs/List', compact('cities', 'needles'));
    // }
}
