<?php
namespace Admin\Controllers\Base;

use Admin\Controllers\Public\BaseAbstract;

class ToolsController extends BaseAbstract
{
    protected $model = "Models\Base\Tools";
    // protected $request = "Publics\Requests\Base\ToolsRequest";
    // protected $searchFilter = ["title_fa"];
    // protected $files = ["img"];
    // protected $with = ["activeStatus"];

    public function list()
    {
        $collection = $this->model::get();

        return response()->json($collection);

    }
}
