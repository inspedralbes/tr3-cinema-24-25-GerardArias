<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MoviesController;
use App\Http\Controllers\FilmSessionsController;
use App\Http\Controllers\UserContoller;


Route::middleware('auth:sanctum')->group(function () {
    Route::get('/users', [UserContoller::class, 'index']);
    Route::get('/users/{id}', [UserContoller::class, 'show']);
    Route::put('/users/{id}', [UserContoller::class, 'update']);
    Route::delete('/users/{id}', [UserContoller::class, 'destroy']);
    Route::post('/logout', [UserContoller::class, 'logout']);
});

Route::post('/register', [UserContoller::class, 'store']);
Route::post('/login', [UserContoller::class, 'login']);

Route::get('/movies', [MoviesController::class, 'index']); 
Route::get('/sessions', [FilmSessionsController::class, 'index']);
