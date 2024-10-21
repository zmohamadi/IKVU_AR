<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Faker\Factory as FakerFactory;
use Faker\Generator as FakerGenerator;
use Illuminate\Support\Facades\Log;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        // $this->app->singleton(FakerGenerator::class, function () {
        //     $locale = config('app.faker_locale', 'en_US');
        //     $faker = FakerFactory::create($locale);
        //     Log::info('Faker locale set to: ' . $faker->locale);
        //     return $faker;
        // });
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
