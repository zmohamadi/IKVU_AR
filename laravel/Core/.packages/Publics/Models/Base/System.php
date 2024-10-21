<?php
namespace Models\Base;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Base\KeywordFactory;
use Models\Traits\Base;

class System extends Model
{
    use Base;
    
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'base_systems';

    function courses()
    {
        return $this->hasMany(\Models\Edu\Course::class,"system_id");
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
