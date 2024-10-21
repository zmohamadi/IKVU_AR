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
        Schema::create('quiz_questions', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->text('title')->nullable()->comment("سئوال");
            $table->integer('quiz_id')->nullable()->comment('شناسه آزمون');
            $table->integer('question_type_id')->default(1)->comment('شناسه نوع سئوال');
            $table->integer('correct_option_id')->default(1)->comment('شناسه پاسخ صحیح');
            $table->integer('order')->nullable()->comment("ترتیب");
            $table->string('score', 5)->default(0)->comment("نمره");
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('quiz_questions');
    }
};
