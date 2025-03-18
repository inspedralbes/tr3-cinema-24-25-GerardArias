<?php

namespace App\Http\Controllers;

use App\Models\Tickets;
use Illuminate\Http\Request;

class TicketsController extends Controller
{
    public function index()
    {
        return response()->json(Tickets::all());
    }

    public function store(Request $request)
    {
        $ticket = Tickets::create($request->validate([
            'email' => 'required|string',
            'session_id' => 'required|exists:sessions,id',
            'seat_id' => 'required|exists:seats,id',
            'price' => 'required|integer',
        ]));
        return response()->json($ticket, 201);
    }
}
