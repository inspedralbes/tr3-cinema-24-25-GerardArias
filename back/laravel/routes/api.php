<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MoviesController;
use App\Http\Controllers\FilmSessionsController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\SeatsController;
use App\Http\Controllers\TicketsController;


Route::middleware('auth:sanctum')->group(function () {
    Route::get('/users', [UserController::class, 'index']);
    Route::post('/logout', [UserController::class, 'logout']);
});

Route::post('/register', [UserController::class, 'store']);
Route::post('/login', [UserController::class, 'login']);

Route::get('/movies', [MoviesController::class, 'index']); 
Route::get('/sessions', [FilmSessionsController::class, 'index']);
Route::get('seats/session/{sessionId}', [SeatsController::class, 'showSessionSeats']);
Route::post('seats/update/', [SeatsController::class, 'updateSeatStatus']); 
Route::post('/tickets', [TicketsController::class, 'store']);
Route::get('/tickets/{email}', [TicketsController::class, 'getUserTickets']);
