<?php
namespace SAdmin\Models;

use Illuminate\Database\Eloquent\Model;

class System extends Model
{
    protected $guarded = ['created_at', 'updated_at', 'id'];
    protected $hidden  = [];
    protected $dates   = [];
    protected $table   = 'core_systems';
    
    function menus()
    {
        return $this->hasMany(Menu::class, 'system_id');
    }

    public function permissions()
    {
        return $this->hasMany(Permission::class, "system_id");
    }
}
