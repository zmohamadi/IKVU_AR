<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('survey_answer', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->integer('attemp_id')->nullable()->comment("شناسه جدول میانی کاربر و نظرسنجی");
            $table->integer('survey_id')->nullable()->comment("شناسه نظرسنجی");
            $table->integer('user_id')->nullable()->comment("شناسه کاربر");
            $table->integer('question_id')->nullable()->comment("شناسه سئوال");
            $table->integer('question_option_id')->nullable()->comment("شناسه گزینه انتخابی");
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('survey_answer');
    }
};
