<?php

namespace App\Http\Controllers;

use App\Models\Tickets;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\Mail\TicketPurchased;

class TicketsController extends Controller
{
    public function index()
    {
        return response()->json(Tickets::all());
    }

    public function store(Request $request)
    {
        $email = $request->input('email'); 
        $session_id = $request->input('session_id'); 
        $seat_ids = $request->input('seat_ids'); 
        $price = $request->input('price'); 
        $data = [];
        $data['email'] = $email;
        $data['session_id'] = $session_id;
        $data['seat_ids'] = $seat_ids;
        $data['price'] = $price;

        // $data = $request->validate([
        //     'email' => 'required|string',
        //     'session_id' => 'required|exists:sessions,id',
        //     'seat_ids' => 'required|array',
        //     'seat_ids.*' => 'required|exists:seats,id',
        //     'price' => 'required|integer'
        // ]);

        $tickets = [];
        foreach ($data['seat_ids'] as $seat_id) {
            $ticket = Tickets::create([
                'email' => $data['email'],
                'session_id' => $data['session_id'],
                'seat_id' => $seat_id,
                'price' => $data['price']
            ]);
            $tickets[] = $ticket;
        }

        Mail::to($data['email'])->send(new TicketPurchased($tickets));

        return response()->json($tickets, 201);
    }
}
