<?php

namespace Admin\Listeners\Quiz;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

use Admin\Events\Quiz\CorrectedCount;
use Admin\Controllers\Quiz\QuizController;

class CorrectedListener
{

    public function handle(CorrectedCount $record)
    {
        $new = new QuizController;
        $new->updateCorrectedCount($record);
    }
   
}
