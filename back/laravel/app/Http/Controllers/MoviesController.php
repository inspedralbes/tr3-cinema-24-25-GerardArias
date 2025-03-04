<?php

namespace App\Http\Controllers;

use App\Models\Movie;
use Illuminate\Http\Request;

class MovieController extends Controller
{
    /**
     * Display a listing of the movies.
     */
    public function index()
    {
        $movies = Movie::all();
        return response()->json($movies);
    }

    /**
     * Store a newly created movie in storage.
     */
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required|string|max:255',
            'plot' => 'required|string',
            'runtime' => 'required|integer',
            'genre' => 'required|string|max:255',
            'poster' => 'required|string|max:255',
        ]);

        $movie = Movie::create($request->all());
        return response()->json($movie, 201);
    }

    /**
     * Display the specified movie.
     */
    public function show(Movie $movie)
    {
        return response()->json($movie);
    }

    /**
     * Update the specified movie in storage.
     */
    public function update(Request $request, Movie $movie)
    {
        $request->validate([
            'title' => 'sometimes|string|max:255',
            'plot' => 'sometimes|string',
            'runtime' => 'sometimes|integer',
            'genre' => 'sometimes|string|max:255',
            'poster' => 'sometimes|string|max:255',
        ]);

        $movie->update($request->all());
        return response()->json($movie);
    }

    /**
     * Remove the specified movie from storage.
     */
    public function destroy(Movie $movie)
    {
        $movie->delete();
        return response()->json(null, 204);
    }
}
