<?php
namespace Models\Edu;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Register extends Model
{
    protected $table   = 'course_users';
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    public $timestamps = true;
    
    const ROLE_TEACHER = 1;
    const ROLE_STUDENT = 2;
    const ROLE_ASSISTANT = 3;
    /**
     * Relations User
     */
    public function coursePresented() {
        return $this->belongsTo(CoursePresented::class, 'course_presented');
    }
    
    function student()
    {
        return $this->belongsTo(\Models\Person\User::class, 'user_id')->where("role_id", self::ROLE_STUDENT);
    }
    function assistant()
    {
        return $this->belongsTo(\Models\Person\User::class, 'user_id')->where("role_id", self::ROLE_ASSISTANT);
    }
    function teacher()
    {
        return $this->belongsTo(\Models\Person\User::class, 'user_id')->where("role_id", self::ROLE_TEACHER);
    }
    function course()
    {
        return $this->belongsTo(Course::class, 'code');
    }
    function role()
    {
        return $this->belongsTo(\Models\Person\Role::class, 'role_id');
    }
}
