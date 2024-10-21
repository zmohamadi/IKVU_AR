<?php
namespace Admin\Controllers\Person;

use Admin\Controllers\Person\UserController;
use Models\Person\User;
use Models\Edu\Register;
use Models\Edu\CoursePresented;

class TeacherController extends UserController
{
    protected $model = "Models\Person\Teacher";
    protected $increment = "teachers";
    protected $decrement = "teachers";

    public function myTeachers() {
        $user = $this->user_id;
    
        $collection = $this->model::with('registers')
        ->whereHas('registers', function ($query) use ($user) {
            // $query->where('user_id', $user);
            // $query->where('role_id', $this->model::ROLE_STUDENT);
        });
    
        return $this->grid($collection, $this->searchFilter);

    }
    
    
    
}
