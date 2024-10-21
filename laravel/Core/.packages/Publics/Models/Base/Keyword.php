<?php
namespace Models\Base;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Base\KeywordFactory;
use Models\Traits\Base;

class Keyword extends Model
{
    use Base;
    
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'base_keywords';
    public static function factory()
    {
        return KeywordFactory::new();
    }

    // public function newQuery($excludeDeleted = true)
    // {
    //     return parent::newQuery($excludeDeleted)->where($this->table.'.lang', \App::getLocale());
    // }
}
