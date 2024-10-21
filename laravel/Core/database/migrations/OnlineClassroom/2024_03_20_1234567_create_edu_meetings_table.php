<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{

    public function up()
    {
        Schema::create('online_classrooms', function (Blueprint $table) {
            
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->string('title')->nullable();
            $table->integer('creator_id')->nullable()->comment('شناسه کاربر ثبت کننده');
            $table->integer('editor_id')->nullable()->comment('شناسه کاربر ویرایش کننده');
            $table->string('start_hour')->nullable();
            $table->string('duration')->nullable();
            $table->string('group')->nullable();
            $table->integer('course_id')->nullable();
            $table->string('meet_link')->nullable();
            $table->integer('presence_count')->default(0);
            $table->integer('status_id')->default(1);
            $table->string('date')->nullable();
            $table->softDeletes();
            $table->timestamps();
        });
    }
    public function down()
    {
        Schema::dropIfExists('online_classrooms');
    }
};
