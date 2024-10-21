<?php

namespace Admin\Controllers\Base;

use Admin\Controllers\Public\BaseAbstract;

class QuestionTypeController extends BaseAbstract
{
    protected $model = 'Models\Base\QuestionType';
    protected $request = 'Publics\Requests\Base\QuestionTypeRequest';
    protected $searchFilter = ['title_en'];
    // protected $with = ["activeStatus"];

}
