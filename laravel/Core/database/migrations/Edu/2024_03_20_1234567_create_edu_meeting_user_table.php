<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up()
    {
        Schema::create('online_classroom_user', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            
            $table->integer('student_id');
            $table->integer('onlineClassroom_id');
            $table->timestamps();
        });
    }
    public function down()
    {
        Schema::dropIfExists('online_classroom_user');
    }
};
