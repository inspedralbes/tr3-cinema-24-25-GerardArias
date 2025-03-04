<?php

namespace App\Http\Controllers;

use App\Models\Ticket;
use Illuminate\Http\Request;

class TicketController extends Controller
{
    public function index()
    {
        return response()->json(Ticket::all());
    }

    public function store(Request $request)
    {
        $ticket = Ticket::create($request->validate([
            'user_id' => 'required|exists:users,id',
            'session_id' => 'required|exists:sessions,id',
            'seat_id' => 'required|exists:seats,id',
            'price' => 'required|integer',
        ]));
        return response()->json($ticket, 201);
    }
}
