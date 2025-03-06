<?php

namespace App\Http\Controllers;

use App\Models\FilmSessions;
use App\Models\Movies; // Necesario para el dropdown de películas
use Illuminate\Http\Request;

class FilmSessionsController extends Controller
{
    public function index()
    {
        $filmSessions = FilmSessions::with('movie')->get();
        return view('filmsessions.index', compact('filmSessions'));
    }

    public function create()
    {
        $movies = Movies::all(); // Traer todas las películas para usarlas en el formulario
        return view('filmsessions.create', compact('movies'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'movie_id' => 'required|exists:movies,id',
            'date' => 'required|date',
            'time' => 'required',
            'vip_enabled' => 'required|boolean',
            'is_discount_day' => 'boolean',
        ]);

        $filmSession = FilmSessions::create($validated);
        return redirect()->route('filmsessions.index')->with('success', 'Sesión creada correctamente');
    }

    public function edit(FilmSessions $filmSession)
    {
        $movies = Movies::all();
        return view('filmsessions.edit', compact('filmSession', 'movies'));
    }

    public function update(Request $request, FilmSessions $filmSession)
    {
        $validated = $request->validate([
            'movie_id' => 'sometimes|exists:movies,id',
            'date' => 'sometimes|date',
            'time' => 'sometimes',
            'vip_enabled' => 'sometimes|boolean',
            'is_discount_day' => 'sometimes|boolean',
        ]);

        $filmSession->update($validated);
        return redirect()->route('filmsessions.index')->with('success', 'Sesión actualizada correctamente');
    }

    public function destroy(FilmSessions $filmSession)
    {
        $filmSession->delete();
        return redirect()->route('filmsessions.index')->with('success', 'Sesión eliminada correctamente');
    }
}
