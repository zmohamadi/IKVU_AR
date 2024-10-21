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
        Schema::create('core_menus', function (Blueprint $table) {
            $table->engine  = 'MyISAM';
            $table->charset = 'utf8';
            $table->collation = 'utf8_persian_ci';
            $table->id();
            $table->string('name', 150)->nullable()->comment('نام انگلیسی منو');
            $table->string('title_fa', 150)->nullable()->comment('عنوان فارسی منو');
            $table->integer('system_id')->length(11)->default(0)->comment('سیستم');
            $table->integer('parent_id')->length(11)->default(0)->comment('parent شناسه');
            $table->integer('order')->length(11)->default(0)->comment('ترتیب');
            $table->integer('is_public')->length(1)->default(0)->comment('در صورتیکه عمومی باشد، این فیلد برابر 1 و در دسترسی ها لحاظ نمی گردد');
            $table->integer('open')->length(1)->default(0)->comment('در صورتیکه پرنت باشد، اینکه به صوتر باز نمایش داده شود یا بسته');
            $table->string('icon', 120)->nullable()->comment('آیکون منو');
            $table->string('href', 120)->nullable()->comment('لینک منو');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('core_menus');
    }
};
