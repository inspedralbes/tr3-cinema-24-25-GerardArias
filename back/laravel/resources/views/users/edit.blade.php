@extends('layout.app')

@section('content')
<div style="max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9;">
    <h2 style="text-align: center; font-size: 2em; color: #333;">Editar Usuario</h2>

    <form action="{{ route('users.update', $user->id) }}" method="POST">
        @csrf
        @method('PUT')

        <div style="margin-bottom: 15px;">
            <label for="name" style="font-size: 1.1em; color: #333;">Nombre:</label>
            <input type="text" name="name" id="name" value="{{ $user->name }}" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 1em;">
        </div>

        <div style="margin-bottom: 15px;">
            <label for="lastname" style="font-size: 1.1em; color: #333;">Apellido:</label>
            <input type="text" name="lastname" id="lastname" value="{{ $user->lastname }}" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 1em;">
        </div>

        <div style="margin-bottom: 15px;">
            <label for="email" style="font-size: 1.1em; color: #333;">Email:</label>
            <input type="email" name="email" id="email" value="{{ $user->email }}" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 1em;">
        </div>

        <div style="margin-bottom: 15px;">
            <label for="phone" style="font-size: 1.1em; color: #333;">Teléfono:</label>
            <input type="text" name="phone" id="phone" value="{{ $user->phone }}" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 1em;">
        </div>

        <div style="margin-bottom: 15px;">
            <label for="password" style="font-size: 1.1em; color: #333;">Nueva Contraseña (opcional):</label>
            <input type="password" name="password" id="password" style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 1em;">
        </div>

        <button type="submit" style="background-color: #3498db; color: white; padding: 10px 20px; font-size: 1.2em; border: none; border-radius: 5px; cursor: pointer; width: 100%; margin-top: 20px;">
            Actualizar
        </button>
    </form>
</div>
@endsection
