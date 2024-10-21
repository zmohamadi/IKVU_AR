<?php

namespace Admin\Controllers\Base;

use Admin\Controllers\Public\BaseAbstract;

class SystemController extends BaseAbstract
{
    protected $model = 'Models\Base\System';
    protected $request = 'Publics\Requests\Base\SystemRequest';
    protected $searchFilter = ['title'];
    protected $with = ["activeStatus","creator","editor"];
    protected $files = ["photo"];

    public function init()
    {
        $this->storeQuery = function ($query) {
            $query = $this->setOperator($query);
        };
    }
}
