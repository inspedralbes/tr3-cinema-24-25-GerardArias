<?php

namespace App\Http\Controllers;

use App\Models\Seats;
use Illuminate\Http\Request;

class SeatsController extends Controller
{
    public function index()
    {
        return response()->json(Seats::all());
    }

    public function store(Request $request)
    {
        $seat = Seats::create($request->validate([
            'session_id' => 'required|exists:sessions,id',
            'row' => 'required|string|size:1',
            'number' => 'required|integer',
            'type' => 'required|in:Normal,VIP',
            'status' => 'required|in:Disponible,Ocupada',
        ]));
        return response()->json($seat, 201);
    }
}
