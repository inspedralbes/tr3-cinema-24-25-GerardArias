<?php

namespace App\Http\Controllers;

use App\Models\FilmSessions;
use App\Models\Movies;
use Illuminate\Http\Request;

class FilmSessionsController extends Controller
{
    public function index(Request $request)
    {
        $sessions = filmSessions::with('movie')->get();

        if ($request->is('api/*')) {
            return response()->json($sessions);
        }

        return view('sessions.index', compact('sessions'));
    }

    public function create()
    {
        $movies = Movies::all();
        return view('sessions.create', compact('movies'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'movie_id' => 'required|exists:movies,id',
            'date' => 'required|date',
            'time' => 'required|date_format:H:i',
        ]);

        $validated['vip_enabled'] = $request->has('vip_enabled') ? 1 : 0;
        $validated['is_discount_day'] = $request->has('is_discount_day') ? 1 : 0;

        FilmSessions::create($validated);

        return redirect()->route('sessions.index')->with('success', 'Sesión creada correctamente!');
    }


    public function show(filmSessions $session)
    {
        return view('sessions.show', compact('session'));
    }

    public function edit(filmSessions $session)
    {
        $movies = Movies::all();
        return view('sessions.edit', compact('session', 'movies'));
    }

    public function update(Request $request, filmSessions $session)
    {
        $validated = $request->validate([
            'movie_id' => 'required|exists:movies,id',
            'date' => 'required|date',
            'time' => 'required|date_format:H:i:s',
            'vip_enabled' => 'required|boolean',
            'is_discount_day' => 'required|boolean',
        ]);

        $session->update($validated);
        return redirect()->route('sessions.index')->with('success', 'Sessió actualitzada!');
    }

    public function destroy(filmSessions $session)
    {
        $session->delete();
        return redirect()->route('sessions.index')->with('success', 'Sessió eliminada.');
    }
}
