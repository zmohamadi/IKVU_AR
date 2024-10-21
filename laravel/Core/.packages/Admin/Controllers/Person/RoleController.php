<?php
namespace Admin\Controllers\Person;

use Admin\Controllers\Public\BaseAbstract;

class RoleController extends BaseAbstract
{
    protected $model = "Models\Person\Role";
    protected $request = "Publics\Requests\Person\RoleRequest";
    protected $with = ["activeStatus"];
    // protected $showWith = ['users'];
    // protected $needles = [];
    protected $searchFilter = ["title_fa","title_en"];
}
