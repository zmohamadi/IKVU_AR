<?php
namespace Models\Traits;

// use Fico7489\Laravel\EloquentJoin\Traits\EloquentJoin;
use Illuminate\Database\Eloquent\SoftDeletes;


trait Base
{
    use SoftDeletes;
    // use EloquentJoin;

    // public function getGuard(){
    //     dd($request->route()->uri);
    //     return strpos($request->route()->uri, "mastership") > -1 ? "admin": "web";
    // }
    /**
     *  relations
     */
    public function activeStatus()
    {
        return $this->belongsTo(\Models\Base\Status::class, 'status_id', 'code')->where('group_id', '1');
    }
    public function confirmStatus()
    {
        return $this->belongsTo(\Models\Base\Status::class, 'confirm_status_id', 'code')->where('group_id', '2');
    }
    public function displayStatus()
    {
        return $this->belongsTo(\Models\Base\Status::class, 'display_status_id', 'code')->where('group_id', '12');
    }
    /**
     * Scopes
     */
    public function scopeActive($query)
    {
        return $query->where('status_id', 1);
    }
    public function scopeConfirm($query)
    {
        return $query->where('confirm_status_id', 1);
    }
    public function scopeDisplay($query)
    {
        return $query->where('display_status_id', 1);
    }
}

