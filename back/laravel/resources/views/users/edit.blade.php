@extends('layout.app')

@section('content')
<div style="max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9;">
    <h2 style="text-align: center; font-size: 2em; color: #333;">Editar Usuario</h2>

    <form action="{{ route('users.update', $user->id) }}" method="POST">
        @csrf
        @method('PUT')

        <div style="margin-bottom: 15px;">
            <label for="name">Nombre:</label>
            <input type="text" name="name" id="name" value="{{ old('name', $user->name) }}" required>
        </div>

        <div style="margin-bottom: 15px;">
            <label for="lastname">Apellido:</label>
            <input type="text" name="lastname" id="lastname" value="{{ old('lastname', $user->lastname) }}" required>
        </div>

        <div style="margin-bottom: 15px;">
            <label for="email">Email:</label>
            <input type="email" name="email" id="email" value="{{ old('email', $user->email) }}" required>
        </div>

        <div style="margin-bottom: 15px;">
            <label for="phone">Teléfono:</label>
            <input type="text" name="phone" id="phone" value="{{ old('phone', $user->phone) }}" required>
        </div>

        <div style="margin-bottom: 15px;">
            <label for="password">Nueva Contraseña (opcional):</label>
            <input type="password" name="password" id="password">
        </div>

        <button type="submit">Actualizar</button>
    </form>
</div>
@endsection