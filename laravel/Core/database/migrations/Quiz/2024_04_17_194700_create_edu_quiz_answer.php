<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('quiz_answer', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->increments('id');
            $table->integer('user_id')->nullable()->comment('شناسه کاربر پاسخ دهنده');
            $table->integer('question_id')->nullable()->comment('شناسه سئوال');
            $table->integer('quiz_attemp_id')->nullable()->comment('شناسه رکورد شرکت رد آزمون');
            $table->integer('question_type_id')->default(1)->comment('شناسه نوع سئوال');
            $table->text('answer')->nullable()->comment('پاسخ تشریحی');
            $table->integer('answer_option_id')->nullable()->comment('شناسه نوع سئوال');
            $table->string('score', 5)->default(0)->comment("نمره");
            $table->string('view_time', 5)->default(0)->comment("درج زمان مشاهده سئوال");
            $table->integer('course_id')->nullable()->comment('شناسه درس');
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('quiz_answer');
    }
};
