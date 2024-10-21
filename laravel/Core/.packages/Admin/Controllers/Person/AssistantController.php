<?php
namespace Admin\Controllers\Person;

use Admin\Controllers\Person\UserController;

class AssistantController extends UserController
{
    protected $model = "Models\Person\Assistant";
    protected $increment = "assistants";
    protected $decrement = "assistants";
}
