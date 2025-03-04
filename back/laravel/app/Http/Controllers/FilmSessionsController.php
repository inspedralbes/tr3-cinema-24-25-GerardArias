<?php

namespace App\Http\Controllers;

use App\Models\FilmSessions;
use Illuminate\Http\Request;

class FilmSessionsController extends Controller
{
    public function index()
    {
        return response()->json(FilmSessions::with('movie')->get());
    }

    public function store(Request $request)
    {
        $filmSession = FilmSessions::create($request->validate([
            'movie_id' => 'required|exists:movies,id',
            'date' => 'required|date',
            'time' => 'required',
            'vip_enabled' => 'required|boolean',
            'is_discount_day' => 'boolean',
        ]));
        return response()->json($filmSession, 201);
    }

    public function show(FilmSessions $filmSession)
    {
        return response()->json($filmSession);
    }

    public function update(Request $request, FilmSessions $filmSession)
    {
        $filmSession->update($request->validate([
            'movie_id' => 'sometimes|exists:movies,id',
            'date' => 'sometimes|date',
            'time' => 'sometimes',
            'vip_enabled' => 'sometimes|boolean',
            'is_discount_day' => 'sometimes|boolean',
        ]));
        return response()->json($filmSession);
    }

    public function destroy(FilmSessions $filmSession)
    {
        $filmSession->delete();
        return response()->json(null, 204);
    }
}
