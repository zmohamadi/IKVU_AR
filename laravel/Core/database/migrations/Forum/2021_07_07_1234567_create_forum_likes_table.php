<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{

    public function up()
    {
        Schema::create('forum_likes', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->integer('user_id')->nullable()->comment('شناسه کاربر');
            $table->integer('post_id')->nullable()->comment('شناسه پست تالار');
            $table->integer('like_type_id')->nullable()->comment('شناسه ثبت کننده');      
            $table->softDeletes();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('forum_likes');
    }
};
