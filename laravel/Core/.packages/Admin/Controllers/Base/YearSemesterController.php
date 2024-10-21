<?php

namespace Admin\Controllers\Base;

use Admin\Controllers\Public\BaseAbstract;

class YearSemesterController extends BaseAbstract
{
    protected $model = 'Models\Base\YearSemester';
    protected $request = 'Publics\Requests\Base\YearSemesterRequest';
    protected $searchFilter = ['year'];
    protected $with = ["activeStatus","creator","editor"];
    public function init()
    {
        $this->storeQuery = function ($query) {
            if ($query->current == 1) {
                $this->model::query()
                ->where('id', '!=', $query->id)
                ->update(['current' => 0]);
            }
            $query = $this->setOperator($query);
        };
    }
    public function getCurrentSemester() {
        return $this->model::where('current',1)->first();
    }
}
