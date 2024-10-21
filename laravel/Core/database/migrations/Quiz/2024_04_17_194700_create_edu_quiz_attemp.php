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
        Schema::create('quiz_attemp', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->increments('id');
            $table->integer('user_id')->nullable()->comment('شناسه کاربر آزمون دهنده');
            $table->integer('course_id')->nullable()->comment('شناسه درس');
            $table->integer('quiz_id')->nullable()->comment('شناسه آزمون');
            $table->string('start_at', 20)->nullable()->comment("شروع آزمون کاربر");
            $table->string('end_at', 20)->nullable()->comment("پایان آزمون کاربر");
            $table->string('deadline', 20)->nullable()->comment("مهلت پاسخگویی");
            $table->string('total_score', 5)->default(0)->comment("جمع نمره دانشجو");
            $table->string('quiz_score', 5)->default(0)->comment("جمع نمره آزمون");
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('quiz_attemp');
    }
};
