<?php
use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{

    public function up()
    {
        Schema::create('courses', function (Blueprint $table) {
            
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->string('code')->primary();
            $table->increments('id');
            $table->string('title');
            $table->text('description')->nullable();
            $table->integer('category_id')->nullable();
            $table->integer('creator_id')->nullable()->comment('شناسه کاربر ثبت کننده');
            $table->integer('editor_id')->nullable()->comment('شناسه کاربر ویرایش کننده');
            $table->string('thumbnail')->nullable();
            $table->integer('learnpath',1)->default(1)->nullable();
            $table->integer('online_classroom',1)->default(1)->nullable();
            $table->integer('online_archives',1)->default(1)->nullable();
            $table->integer('online_past_archives',1)->default(1)->nullable();
            $table->integer('quiz',1)->default(1)->nullable();
            $table->integer('assignments',1)->default(1)->nullable();
            $table->integer('forum',1)->default(1)->nullable();
            $table->integer('inbox',1)->default(1)->nullable();
            $table->integer('survey',1)->default(1)->nullable();
            $table->integer('system_id',2)->default(1);
            $table->integer('status_id',1)->default(1);
            $table->string('lang',2)->default("fa");
            $table->softDeletes();
            $table->timestamps();
        });
    }
    public function down()
    {
        Schema::dropIfExists('courses');
    }
};
