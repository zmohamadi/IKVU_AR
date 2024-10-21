<?php

namespace Admin\Listeners;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

use Admin\Events\CourseScore;
use Admin\Controllers\Edu\CourseController;

class CourseScoreListener
{

    public function handle(CourseScore $event)
    {
        $new = new CourseController;
        $new->updateScore($event);
    }
   
}
