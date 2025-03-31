<?php

namespace App\Http\Controllers;

use App\Models\Seats;
use Illuminate\Http\Request;

class SeatsController extends Controller
{
    public function showSessionSeats($sessionId)
    {
        $seats = Seats::where('session_id', $sessionId)->get();
        return response()->json($seats);
    }

    public function updateSeatStatus(Request $request)
    {
        $validated = $request->validate([
            'session_id' => 'required|exists:film_sessions,id',
            'seat_ids' => 'required|array',
            'seat_ids.*' => 'exists:seats,id',
        ]);

        $updatedSeats = Seats::whereIn('id', $validated['seat_ids'])
            ->where('status', 'Disponible') 
            ->update(['status' => 'Ocupada']);

        if ($updatedSeats > 0) {
            return response()->json(['message' => 'Asientos ocupados con éxito'], 200);
        } else {
            return response()->json(['error' => 'No se pudieron ocupar los asientos'], 400);
        }
    }
}
