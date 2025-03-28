@extends('layout.app')

@section('content')
<div style="max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9;">
    <h2 style="text-align: center; font-size: 2em; color: #333;">Crear Usuario</h2>

    <form action="{{ route('users.store') }}" method="POST">
        @csrf
        <div style="margin-bottom: 15px;">
            <label for="name">Nombre:</label>
            <input type="text" name="name" id="name" required>
        </div>

        <div style="margin-bottom: 15px;">
            <label for="lastname">Apellido:</label>
            <input type="text" name="lastname" id="lastname" required>
        </div>

        <div style="margin-bottom: 15px;">
            <label for="email">Email:</label>
            <input type="email" name="email" id="email" required>
        </div>

        <div style="margin-bottom: 15px;">
            <label for="phone">Teléfono:</label>
            <input type="text" name="phone" id="phone" required>
        </div>

        <div style="margin-bottom: 15px;">
            <label for="password">Contraseña:</label>
            <input type="password" name="password" id="password" required>
        </div>

        <button type="submit">Guardar</button>
    </form>
</div>
@endsection
