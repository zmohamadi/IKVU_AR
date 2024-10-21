<?php
namespace SAdmin\Models;

use Illuminate\Database\Eloquent\Model;

class Menu extends Model
{
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'core_menus';
    
    function permissions()
    {
        return $this->hasMany(Permission::class, 'menu_id');
    }

    public function system()
    {
        return $this->belongsTo(System::class, "system_id");
    }
}
