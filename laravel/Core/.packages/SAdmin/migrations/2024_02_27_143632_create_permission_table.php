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
        Schema::create('core_permissions', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->string('name', 150)->nullable()->comment('نام انگلیسی پرمیژن');
            $table->string('title_fa', 150)->nullable()->comment('عنوان فارسی');
            $table->integer('menu_id')->length(11)->default(0)->comment('منوی مربوطه');
            $table->integer('system_id')->length(11)->default(0)->comment('سیستم');
            $table->integer('order')->length(11)->default(0)->comment('ترتیب');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('core_permissions');
    }
};
