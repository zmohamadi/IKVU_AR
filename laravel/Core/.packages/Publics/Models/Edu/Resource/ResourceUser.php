<?php
namespace Models\Edu\Resource;

use Illuminate\Database\Eloquent\Model;
use Models\Traits\Base;

class ResourceUser extends Model
{
    use Base;

    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'resource_user';

    function resource()
    {
        return $this->belongsTo(\Models\Edu\Resource\Resource::class, 'resource_id');
    }
    function user()
    {
        return $this->belongsTo(\Models\Person\User::class, 'user_id');
    }
}
