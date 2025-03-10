<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MoviesController;
use App\Http\Controllers\FilmSessionsController;
use App\Http\Controllers\UserContoller;


Route::get('/', function () {
    return view('index');
});

route::resource('movies',MoviesController::class);
route::resource('sessions',FilmSessionsController::class);
route::resource('users',UserContoller::class);

