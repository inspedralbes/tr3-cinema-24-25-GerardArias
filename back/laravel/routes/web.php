<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MoviesController;
use App\Http\Controllers\FilmSessionsController;

Route::get('/', function () {
    return view('index');
});

route::resource('movies',MoviesController::class);
route::resource('filmsessions',FilmSessionsController::class);
