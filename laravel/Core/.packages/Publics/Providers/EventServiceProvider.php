<?php

namespace Publics\Providers;

use Illuminate\Auth\Events\Registered;
use Illuminate\Auth\Listeners\SendEmailVerificationNotification;
use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Event;

// use Admin\Events\Assignment\CorrectedCount as AssignmentCorrect;
// use Admin\Listeners\Assignment\CorrectedListener as AssignmentCorrectedListener;

// use Admin\Events\Assignment\Score as AssignmentScore;
// use Admin\Listeners\Assignment\ScoreListener as AssignmentScoreListener;

use Admin\Events\Quiz\CorrectedCount as QuizCorrect;
use Admin\Listeners\Quiz\CorrectedListener as QuizCorrectedListener;

use Admin\Events\Quiz\AnswerCount as QuizAnswer;
use Admin\Listeners\Quiz\AnswerListener as QuizAnswerdListener;

use Admin\Events\Quiz\Score as QuizScore;
use Admin\Listeners\Quiz\ScoreListener as QuizScoreListener;

// use Admin\Events\StudentScore;
// use Admin\Listeners\StudentScoreListener;

// use Admin\Events\CourseScore;
// use Admin\Listeners\CourseScoreListener;

class EventServiceProvider extends ServiceProvider
{
    
    protected $listen = [
        QuizScore::class => [
            [QuizScoreListener::class, 'handle'],
        ],
        QuizAnswer::class => [
            [QuizAnswerdListener::class, 'handle'],
        ],
        QuizCorrect::class => [
            [QuizCorrectedListener::class, 'handle'],
        ],
        // AssignmentCorrect::class => [
        //     [AssignmentCorrectedListener::class, 'handle'],
        // ],
        // AssignmentScore::class => [
        //     [AssignmentScoreListener::class, 'handle'],
        // ],
        // StudentScore::class => [
        //     [StudentScoreListener::class, 'handle'],
        // ],
        // CourseScore::class => [
        //     [CourseScoreListener::class, 'handle'],
        // ],
    ];
}
