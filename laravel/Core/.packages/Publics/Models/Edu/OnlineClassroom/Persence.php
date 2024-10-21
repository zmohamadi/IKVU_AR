<?php
namespace Models\Edu\OnlineClassroom;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Edu\OnlineClassroomUserFactory;

class Persence extends Model
{
    
    protected $table   = 'online_classroom_user';
    public static function factory()
    {
        return OnlineClassroomUserFactory::new();
    }

}
