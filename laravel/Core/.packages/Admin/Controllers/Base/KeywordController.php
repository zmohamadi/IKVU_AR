<?php

namespace Admin\Controllers\Base;

use Admin\Controllers\Public\BaseAbstract;

class KeywordController extends BaseAbstract
{
    protected $model = 'Models\Base\Keyword';
    protected $request = 'Publics\Requests\Base\KeywordRequest';
    protected $searchFilter = ['title'];
    protected $with = ["activeStatus"];

}
