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
        Schema::create('core_systems', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->string('name', 150)->nullable()->comment('نام انگلیسی سیستم');
            $table->string('title_fa', 150)->nullable()->comment('عنوان فارسی سامانه');
            $table->string('comments', 250)->nullable()->comment('توضیحات');
            $table->string('photo', 70)->nullable()->comment('تصویر سامانه');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('core_systems');
    }
};
