<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('assignment_answers_detail', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->increments('id');
            $table->integer('answer_id')->nullable()->comment('شناسه پاسخ اصلی');
            $table->integer('user_id')->nullable()->comment('شناسه دانشجو | شناسه استاد');
            // $table->integer('assignment_id')->nullable()->comment('شناسه تکلیف');
            // $table->integer('course_id')->nullable()->comment('شناسه درس');
            $table->text('answer_text')->nullable()->comment('پاسخ دانشجو | پیام استاد در پاسخ');
            $table->integer('answer_option_id')->nullable()->comment('شناسه گزینه انتخاب شده در پاسخ');
            $table->string('files')->nullable()->comment('بارگزاری ها');
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('assignment_answers_detail');
    }
};
