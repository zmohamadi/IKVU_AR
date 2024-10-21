<?php

namespace Admin\Controllers\Person;

use Admin\Controllers\Person\UserController;
use Models\Person\Role;

class PersonnelController extends UserController
{
    protected $model = "Models\Person\Personnel";
    protected $increment = "personnels";
    protected $decrement = "personnels";

    public function init()
    {
        Parent::init();
        
        $this->indexQuery = function ($query)
        {
            // $query->whereIn('role_id', Role::ISPERSONNEL)->whereNot("id", 1);
            $query->where('role_id', '>', 3)->whereNot("id", 1);
        };
    }
}

