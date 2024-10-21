<?php

namespace Admin\Listeners\Quiz;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

use Admin\Events\Quiz\AnswerCount;
use Admin\Controllers\Quiz\QuizController;

class AnswerListener
{

    public function handle(AnswerCount $record)
    {
        $new = new QuizController;
        $new->updateAnswerCount($record);
    }
   
}
