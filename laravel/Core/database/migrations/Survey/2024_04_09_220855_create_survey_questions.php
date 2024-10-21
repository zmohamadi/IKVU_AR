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
        Schema::create('survey_questions', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->string('title')->nullable()->comment("عنوان");
            $table->unsignedBigInteger('survey_id')->nullable()->comment("شناسه نظر سنجی");
            $table->integer('question_type_id')->default(2)->comment("شناسه نوع سئوال(فقط چند گزینه ای)");
            $table->integer('order')->nullable()->comment("ترتیب");
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('survey_questions');
    }
};
