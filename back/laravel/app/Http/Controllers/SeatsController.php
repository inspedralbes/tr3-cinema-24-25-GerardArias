<?php

namespace App\Http\Controllers;

use App\Models\Seat;
use Illuminate\Http\Request;

class SeatController extends Controller
{
    public function index()
    {
        return response()->json(Seat::all());
    }

    public function store(Request $request)
    {
        $seat = Seat::create($request->validate([
            'session_id' => 'required|exists:sessions,id',
            'row' => 'required|string|size:1',
            'number' => 'required|integer',
            'type' => 'required|in:Normal,VIP',
            'status' => 'required|in:Disponible,Ocupada',
        ]));
        return response()->json($seat, 201);
    }
}
