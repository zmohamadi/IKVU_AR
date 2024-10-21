<?php
namespace Models\Person;

use Models\Person\User;
use Database\Factories\Person\TeacherFactory;

class Assistant extends User
{
    protected $attributes = ['role_id' => 3];
    
    public function newQuery($excludeDeleted = true)
    {
        $c =  parent::newQuery($excludeDeleted);
        return $c->where(function($q){
                $q->where($this->table.'.role_id',3);
            });
    }
}
