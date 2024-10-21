<?php

namespace Admin\Listeners\Assignment;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

use Admin\Events\Assignment\CorrectedCount;
use Admin\Controllers\Edu\AssignmentController;

class CorrectedListener
{

    public function handle(CorrectedCount $record)
    {
        $new = new AssignmentController;
        $new->updateCorrectedCount($record);
    }
   
}
