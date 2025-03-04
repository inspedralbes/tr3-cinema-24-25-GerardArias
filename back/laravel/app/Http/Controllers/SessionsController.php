<?php

namespace App\Http\Controllers;

use App\Models\Session;
use Illuminate\Http\Request;

class SessionController extends Controller
{
    public function index()
    {
        return response()->json(Session::with('movie')->get());
    }

    public function store(Request $request)
    {
        $session = Session::create($request->validate([
            'movie_id' => 'required|exists:movies,id',
            'date' => 'required|date',
            'time' => 'required',
            'vip_enabled' => 'required|boolean',
            'is_discount_day' => 'boolean',
        ]));
        return response()->json($session, 201);
    }
}
