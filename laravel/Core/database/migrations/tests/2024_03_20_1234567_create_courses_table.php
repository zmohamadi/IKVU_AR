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
            
            $table->increments('id');
            $table->string('code')->unique();
            $table->string('title');
            $table->text('description')->nullable();
            $table->integer('category_id')->nullable();
            $table->string('thumbnail')->nullable();
            $table->integer('learnpath')->default(1)->nullable();
            $table->integer('online_classroom')->default(1)->nullable();
            $table->integer('online_archives')->default(1)->nullable();
            $table->integer('online_past_archives')->default(1)->nullable();
            $table->integer('quiz')->default(1)->nullable();
            $table->integer('assignments')->default(1)->nullable();
            $table->integer('forum')->default(1)->nullable();
            $table->integer('inbox')->default(1)->nullable();
            $table->integer('survey')->default(1)->nullable();
            $table->integer('system_id')->default(1);
            $table->integer('status_id')->default(1);
            $table->string('lang', 2)->default('fa');
            $table->softDeletes();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('courses');
    }
};
