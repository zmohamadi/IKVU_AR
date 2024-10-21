<?php
namespace Models\Edu;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Edu\EnrollFactory;

class CoursePresented extends Model
{   
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['updated_at', 'deleted_at','status_id'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'course_presented';
    public $timestamps = true;
    const ROLE_TEACHER = 1;
    const ROLE_STUDENT = 2;
    const ROLE_ASSISTANT = 3;

    function course()
    {
        return $this->belongsTo(\Models\Edu\Course::class,'code');
    }
    public function teacher() {
        return $this->belongsTo(\Models\Person\Teacher::class, 'teacher_person_id');
    }    
    function assistants()
    {
        // return $this->hasMany(Register::class,"course_presented")->where("role_id", self::ROLE_ASSISTANT)->with('assistant');
        return $this->hasMany(Register::class,"course_presented")->select('user_id','role_id',"course_presented")->where("role_id", self::ROLE_ASSISTANT);
    }
    function userAssistants()
    {
        return $this->belongsToMany(\Models\Person\User::class, 'course_users', 'course_presented', 'user_id')->wherePivot("role_id", self::ROLE_ASSISTANT);
    }
    function yearSemester()
    {
        return $this->belongsTo(\Models\Base\YearSemester::class);
    }
    function registers()
    {
        return $this->hasMany(\Models\Person\User::class);
    }
    public function creator()
    {
        return $this->belongsTo(\Models\Person\User::class, 'creator_id');
    }
    public function editor()
    {
        return $this->belongsTo(\Models\Person\User::class, 'editor_id');
    }

    public function activeStatus()
    {
        return $this->belongsTo(\Models\Base\Status::class, 'status_id', 'code')->where('group_id', '1');
    }
}
