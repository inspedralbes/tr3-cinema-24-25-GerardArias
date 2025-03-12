<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MoviesController;
use App\Http\Controllers\FilmSessionsController;
use App\Http\Controllers\UserContoller;
use App\Http\Controllers\SeatsController;


Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('/movies', [MoviesController::class, 'index']); 
Route::get('/sessions', [FilmSessionsController::class, 'index']);
Route::get('/users', [UserContoller::class, 'index']);
Route::get('seats/session/{sessionId}', [SeatsController::class, 'showSessionSeats']);
Route::post('seats/update/', [SeatsController::class, 'updateSeatStatus']); 
