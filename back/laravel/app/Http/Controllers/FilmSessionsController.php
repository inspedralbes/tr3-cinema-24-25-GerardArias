<?php

namespace App\Http\Controllers;

use App\Models\FilmSessions;
use App\Models\Movies;
use App\Models\Seats;  // Asegúrate de incluir el modelo Seats
use Illuminate\Http\Request;

class FilmSessionsController extends Controller
{
    public function index(Request $request)
    {
        $sessions = FilmSessions::with('movie')->get();

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
            'vip_enabled' => 'sometimes|boolean',
            'is_discount_day' => 'sometimes|boolean',
        ]);

        $validated['vip_enabled'] = $request->has('vip_enabled');
        $validated['is_discount_day'] = $request->has('is_discount_day');

        $session = FilmSessions::create($validated);
        $this->createSeatsForSession($session);
        return redirect()->route('sessions.index')->with('success', 'Sessió creada correctament!');
    }


    public function show(FilmSessions $session)
    {
        return view('sessions.show', compact('session'));
    }

    public function edit(FilmSessions $session)
    {
        $movies = Movies::all();
        return view('sessions.edit', compact('session', 'movies'));
    }

    public function update(Request $request, FilmSessions $session)
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

    public function destroy(FilmSessions $session)
    {
        $session->delete();
        return redirect()->route('sessions.index')->with('success', 'Sessió eliminada.');
    }

    private function createSeatsForSession(FilmSessions $session)
    {
        $rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L'];
        $maxSeatsPerRow = 10;

        foreach ($rows as $row) {
            for ($number = 1; $number <= $maxSeatsPerRow; $number++) {
                $type = ($row == 'F' && $session->vip_enabled) ? 'VIP' : 'Normal';

                Seats::create([
                    'session_id' => $session->id,
                    'row' => $row,
                    'number' => $number,
                    'type' => $type,
                    'status' => 'Disponible',
                ]);
            }
        }
    }
}
