<?php

namespace Admin\Listeners;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

use Admin\Events\StudentScore;
use Admin\Controllers\Person\StudentController;

class StudentScoreListener
{

    public function handle(StudentScore $event)
    {
        $new = new StudentController;
        $new->updateTotalScore($event);
    }
   
}
