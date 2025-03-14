<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MoviesController;
use App\Http\Controllers\FilmSessionsController;
use App\Http\Controllers\UserController;


Route::middleware('auth:sanctum')->group(function () {
    Route::get('/users', [UserController::class, 'index']);
    Route::post('/logout', [UserController::class, 'logout']);
});

Route::post('/register', [UserController::class, 'store']);
Route::post('/login', [UserController::class, 'login']);

Route::get('/movies', [MoviesController::class, 'index']); 
Route::get('/sessions', [FilmSessionsController::class, 'index']);
