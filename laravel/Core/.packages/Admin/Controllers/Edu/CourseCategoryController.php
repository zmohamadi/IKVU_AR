<?php
namespace Admin\Controllers\Edu;

use Admin\Controllers\Public\BaseAbstract;
use Illuminate\Http\Request;

class CourseCategoryController extends BaseAbstract{

    protected $model = "Models\Edu\CourseCategory";
    protected $request = "Publics\Requests\Edu\CourseCategoryRequest";
    protected $with = ["activeStatus","creator","editor"];
    protected $showWith = ["activeStatus","creator","editor"];
    protected $searchFilter = ["title_fa"];
    // protected $increment = ["course-categories"];
    // protected $decrement = ["course-categories"];
    // protected $files = ["pic"];

    public function init()
    {
        $this->storeQuery = function ($query)
        {
            $query = $this->setOperator($query);        
        };
        
    }
}
