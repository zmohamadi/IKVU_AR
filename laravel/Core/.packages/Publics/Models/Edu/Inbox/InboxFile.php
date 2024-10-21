<?php
namespace Models\Edu\Inbox;

use Illuminate\Database\Eloquent\Model;
use Database\Factories\Assignment\OptionFactory;
use Models\Traits\Base;

class InboxFile extends Model
{
    use Base;
    
    protected $guarded = ['created_at', 'updated_at', 'deleted_at', 'id'];
    protected $hidden  = ['created_at', 'updated_at', 'deleted_at'];
    protected $dates   = ['deleted_at'];
    protected $table   = 'inbox_files';
    
    
    public function inbox()
    {
        return $this->belongsTo(Inbox::class, "inbox_id");
    }

}
