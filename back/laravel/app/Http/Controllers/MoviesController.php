<?php

namespace App\Http\Controllers;

use App\Models\Movies;
use Illuminate\Http\Request;

class MoviesController extends Controller
{
    /**
     * Display a listing of the movies.
     */
    public function index( Request $request)
    {
        $movies = Movies::all();

        if ($request->is('api/*')) {
            return response()->json($movies); 
        }

        return view('movies.index', compact('movies'));
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

        $movie = Movies::create($request->all());
        return response()->json($movie, 201);
    }

    /**
     * Display the specified movie.
     */
    public function show(Movies $movie)
    {
        return response()->json($movie);
    }

    /**
     * Update the specified movie in storage.
     */
    public function update(Request $request, Movies $movie)
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
    public function destroy(Movies $movie)
    {
        $movie->delete();
        return redirect()->route('movies.index')->with('success', 'Película eliminada correctamente');    
    }
}
