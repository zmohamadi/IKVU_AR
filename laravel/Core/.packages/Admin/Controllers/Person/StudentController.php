<?php
namespace Admin\Controllers\Person;

use Admin\Controllers\Person\UserController;
use Models\Edu\Enroll;

class StudentController extends UserController
{
    protected $model = "Models\Person\Student";
    protected $increment = "students";
    protected $decrement = "students";
}
