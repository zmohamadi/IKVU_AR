<?php
namespace Models\Person;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Person\UserFactory;
use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Contracts\Auth\CanResetPassword;
use Laravel\Sanctum\HasApiTokens;
use Models\Traits\Base;

class User extends Authenticatable implements MustVerifyEmail
{
    use Base;
    use Notifiable, HasApiTokens;

    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at','password'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'users';
    const ROLE_TEACHER = 1;
    const ROLE_STUDENT = 2;
    const ROLE_ASSISTANT = 3;
    
    public static function factory()
    {
        return UserFactory::new();
    }

    protected static function booted(): void
    {
        static::deleting(function(User $user) { // before delete() method call this        
            // $user->files->each(function($file) {
            //     $file->delete();
            // });
        });
    }

    function role()
    {
        return $this->belongsTo(\Models\Person\Role::class);
    }
    function gender()
    {
        return $this->belongsTo(\Models\Base\Gender::class);
    }
    public function creator()
    {
        return $this->belongsTo(\Models\Person\User::class, "creator_id");
    }
    public function editor()
    {
        return $this->belongsTo(\Models\Person\User::class, "editor_id");
    }
    /**
     * Relations Course
     */
    function courseUsers()
    {
        return $this->belongsToMany(\Models\Edu\Course::class, 'course_users', 'user_id', 'code')->withpivot('start_date','end_date');
    }
    function registers()
    {
        return $this->hasMany(\Models\Edu\Register::class, 'user_id');
    }
    function coursePresents()
    {
        return $this->belongsToMany(\Models\Edu\Course::class, 'course_presented', 'user_id', 'code');
    }
    function presents()
    {
        return $this->hasMany(\Models\Edu\CoursePresented::class, 'user_id');
    }


    
    function onlineClassrooms()
    {
        // return $this->belongsToMany(\Models\Edu\OnlineClassroom\OnlineClassroom::class, 'online_classroom_user', 'user_id', 'onlineClassroom_id')->withPivot('created_at');
        return $this->belongsToMany(\Models\Edu\OnlineClassroom\OnlineClassroom::class, 'online_classroom_user', 'user_id', 'onlineClassroom_id')->using(\Models\Edu\OnlineClassroom\OnlineClassroomUser::class)->withPivot('created_at');    
    }   
    function presenceOnlineClassrooms()
    {
        return $this->hasMany(\Models\Edu\OnlineClassroom\OnlineClassroomUser::class, 'user_id');
    }   
   
    /**
     * Relations M to N For Quiz
     */
    function quizAttemps()
    {
        return $this->belongsToMany(\Models\Edu\Quiz\Quiz::class, "edu_quiz_attemp","user_id",'quiz_id');
    }
    function questionsAnswers()
    {
        return $this->belongsToMany(\Models\Edu\Quiz\Question::class, "edu_quiz_answer","user_id",'question_id');
    }
    /**
     * Relations HasMany For Quiz
     */
    function attemps()
    {
        return $this->hasMany(\Models\Edu\Quiz\Attemp::class, 'user_id');
    }
    function answers()
    {
        return $this->hasMany(\Models\Edu\Quiz\Answer::class, 'user_id');
    }
    /**
     * Relations HasMany For assignment
     */
   
    function assignmentAnswers()
    {
        return $this->hasMany(\Models\Edu\Assignment\Answer::class, 'user_id');
    }


    function visits()
    {
        return $this->belongsToMany(\Models\Edu\LearnPath\LearnPath::class,'learnpath_view_user', 'user_id', 'learnPath_id')->withPivot('view_count');

    }
    /**
     * Relations For Forum
     */
    public function likes()
    {
        return $this->hasMany(\Models\Edu\Forum\Like::class, 'user_id');
    }
    public function posts()
    {
        return $this->belongsToMany(\Models\Edu\Forum\Post::class, 'forum_likes', 'user_id', 'post_id');
    }
    // public function likeTypes() // فعلا لازم نیست!!!
    // {
    //     return $this->belongsToMany(\Models\Base\Status::class, 'forum_likes', 'user_id', 'like_type_id');
    // }

    // inbox
    function sendMessage()
    {
        return $this->belongsToMany(User::class, 'inbox', 'sender', 'receiver')->withpivot('title','text',"created_at");
    }
    function receiveMessage()
    {
        return $this->belongsToMany(User::class, 'inbox', 'receiver', 'sender')->withpivot('title','text',"created_at");
    }
    /**
     * Relations create && edit by User
     */
    public function creatorUser()
    {
        return $this->hasMany(User::class, "creator_id");
    }
    public function editorUser()
    {
        return $this->hasMany(User::class, "editor_id");
    }
    public function creatorForum()
    {
        return $this->hasMany(\Models\Edu\Forum\Forum::class, "creator_id");
    }
    public function editorForum()
    {
        return $this->hasMany(\Models\Edu\Forum\Forum::class, "editor_id");
    }
    public function creatorSurvey()
    {
        return $this->hasMany(\Models\Edu\Survey\Survey::class, "creator_id");
    }
    public function editorSurvey()
    {
        return $this->hasMany(\Models\Edu\Survey\Survey::class, "editor_id");
    }
}
