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
        Schema::create('course_users', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->integer('user_id')->nullable();
            $table->string('code')->nullable();
            $table->string('year_code')->nullable();
            $table->string('group')->nullable();
            $table->integer('less_id')->nullable();
            $table->integer('status_id')->nullable();
            $table->integer('role_id')->nullable();
            $table->string('title')->comment('در انتخاب واحد پر میشود')->nullable();
            $table->string('main_code')->comment('در انتخاب واحد پر میشود')->nullable();
            $table->string('start_date')->nullable();
            $table->string('end_date')->nullable();
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('course_users');
    }
};
