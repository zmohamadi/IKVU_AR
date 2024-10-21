<?php
namespace Models\Base;

use Illuminate\Database\Eloquent\Model;
use Models\Traits\Base;

class Status extends Model
{
    use Base;

    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'base_statuses';

    function parent()
    {
        return $this->belongsTo(\Models\Base\Status::class, 'group_id');
    }

    function childs()
    {
        return $this->hasMany(\Models\Base\Status::class, 'group_id');
    }
    /**
     * Scope Relations
     */
    public function scopeFilterGroup($query, $group_id) // عمومی
    {
        return $query->where('group_id', $group_id);
    }
    
    // public function scopeConfirmGroup($query)
    public function scopePostGroup($query)
    {
        return $query->where('group_id', 4);
    }
}
