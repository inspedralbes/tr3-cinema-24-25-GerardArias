<?php

namespace App\Http\Controllers;

use App\Models\Tickets;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use App\Mail\TicketPurchased;

class TicketsController extends Controller
{
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

        $tickets = Tickets::with('seat', 'filmSession.movie')->whereIn('id', collect($tickets)->pluck('id'))->get();

        foreach ($tickets as $ticket) {
            $ticket->seat_id = $ticket->seat->row . '-' . $ticket->seat->number;
            $ticket->session_number = $ticket->filmSession->session_number;
            $ticket->movie_name = $ticket->filmSession->movie->name;
        }

        Mail::to($data['email'])->send(new TicketPurchased($tickets));

        return response()->json($tickets, 201);
    }

    public function getUserTickets($email)
    {
        $tickets = Tickets::with('seat', 'filmSession.movie')->where('email', $email)->get();

        foreach ($tickets as $ticket) {
            $ticket->seat_id = $ticket->seat->row . '-' . $ticket->seat->number;
            $ticket->session_number = $ticket->filmSession->session_number;
            $ticket->movie_name = $ticket->filmSession->movie->title; 
        }


        return response()->json($tickets);
    }
}
