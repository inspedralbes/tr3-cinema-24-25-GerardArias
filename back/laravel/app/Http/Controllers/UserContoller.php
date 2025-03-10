<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Http\Request;

class UserContoller extends Controller
{
    public function index(Request $request)
    {
        $users = User::all();
        
        if ($request->is('api/*')) {
            return response()->json($users);
        }
        
        return view('users.index', compact('users'));
    }

    public function create()
    {
        return view('users.create');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'lastname' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8',
            'phone' => 'required|string|max:20',
        ]);

        $validated['password'] = Hash::make($validated['password']);

        $user = User::create($validated);

        if ($request->is('api/*')) {
            return response()->json($user, 201);
        }
        
        return redirect()->route('users.index')->with('success', 'Usuario creado exitosamente');
    }

    public function show(Request $request, $id)
    {
        $user = User::findOrFail($id);
        
        if ($request->is('api/*')) {
            return response()->json($user);
        }
        
        return view('users.show', compact('user'));
    }

    public function edit($id)
    {
        $user = User::findOrFail($id);
        return view('users.edit', compact('user'));
    }

    public function update(Request $request, $id)
    {
        $user = User::findOrFail($id);

        $validated = $request->validate([
            'name' => 'sometimes|string|max:255',
            'lastname' => 'sometimes|string|max:255',
            'email' => 'sometimes|string|email|max:255|unique:users,email,' . $id,
            'password' => 'sometimes|string|min:8',
            'phone' => 'sometimes|string|max:20',
        ]);

        if (isset($validated['password'])) {
            $validated['password'] = Hash::make($validated['password']);
        }

        $user->update($validated);

        if ($request->is('api/*')) {
            return response()->json($user);
        }
        
        return redirect()->route('users.index')->with('success', 'Usuario actualizado exitosamente');
    }

    public function destroy(Request $request, $id)
    {
        $user = User::findOrFail($id);
        $user->delete();

        if ($request->is('api/*')) {
            return response()->json(['message' => 'Usuario eliminado exitosamente']);
        }
        
        return redirect()->route('users.index')->with('success', 'Usuario eliminado exitosamente');
    }
}
