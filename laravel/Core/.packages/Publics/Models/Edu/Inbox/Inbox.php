<?php
namespace Models\Edu\Inbox;

use Illuminate\Database\Eloquent\Model;
use Models\Traits\Base;

class Inbox extends Model
{
    use Base;

    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'inbox';

    
    function course()
    {
        return $this->belongsTo(\Models\Edu\Course::class, 'course_id');
    }
    function sender()
    {
        return $this->hasMany(\Models\Person\User::class, 'id',"sender");
    }
    function receiver()
    {
        return $this->hasMany(\Models\Person\User::class, 'id','receiver');
    }
    public function files()
    {
        return $this->hasMany(InboxFile::class,"inbox_id");
    }
    public function creator()
    {
        return $this->belongsTo(\Models\Person\User::class, 'creator_id');
    }
    public function editor()
    {
        return $this->belongsTo(\Models\Person\User::class, 'editor_id');
    }
}
