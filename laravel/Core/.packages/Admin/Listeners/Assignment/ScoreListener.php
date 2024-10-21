<?php

namespace Admin\Listeners\Assignment;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

use Admin\Events\Assignment\Score;
use Admin\Controllers\Edu\AssignmentController;

class ScoreListener
{

    public function handle(Score $record)
    {
        $new = new AssignmentController;
        $new->updateTotalUserScore($record);
    }
   
}
