@extends('layout.app')

@section('title', 'Editar Sessió')

@section('content')
<div style="max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9;">
    <h1 style="text-align: center; font-size: 2em; color: #333;">Editar Sessió</h1>

    <form action="{{ route('sessions.update', $session->id) }}" method="POST">
        @csrf
        @method('PUT')

        <div style="margin-bottom: 15px;">
            <label for="movie_id" style="font-size: 1.1em; color: #333;">Pel·lícula:</label>
            <select name="movie_id" id="movie_id" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 1em;">
                @foreach($movies as $movie)
                    <option value="{{ $movie->id }}" {{ $movie->id == $session->movie_id ? 'selected' : '' }}>
                        {{ $movie->title }}
                    </option>
                @endforeach
            </select>
        </div>

        <div style="margin-bottom: 15px;">
            <label for="date" style="font-size: 1.1em; color: #333;">Data:</label>
            <input type="date" name="date" id="date" value="{{ $session->date }}" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 1em;">
        </div>

        <div style="margin-bottom: 15px;">
            <label for="time" style="font-size: 1.1em; color: #333;">Hora:</label>
            <input type="time" name="time" id="time" value="{{ $session->time }}" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 1em;">
        </div>

        <div style="margin-bottom: 15px;">
            <label for="vip_enabled" style="font-size: 1.1em; color: #333;">VIP:</label>
            <select name="vip_enabled" id="vip_enabled" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 1em;">
                <option value="1" {{ $session->vip_enabled ? 'selected' : '' }}>Sí</option>
                <option value="0" {{ !$session->vip_enabled ? 'selected' : '' }}>No</option>
            </select>
        </div>

        <div style="margin-bottom: 15px;">
            <label for="is_discount_day" style="font-size: 1.1em; color: #333;">Dia de Descompte:</label>
            <select name="is_discount_day" id="is_discount_day" required style="width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; font-size: 1em;">
                <option value="1" {{ $session->is_discount_day ? 'selected' : '' }}>Sí</option>
                <option value="0" {{ !$session->is_discount_day ? 'selected' : '' }}>No</option>
            </select>
        </div>

        <div style="display: flex; justify-content: space-between; margin-top: 20px;">
            <button type="submit" style="background-color: #3498db; color: white; padding: 10px 20px; font-size: 1.2em; border: none; border-radius: 5px; cursor: pointer; width: 48%;">Actualitzar</button>
            <a href="{{ route('sessions.index') }}" style="background-color: #e74c3c; color: white; padding: 10px 20px; font-size: 1.2em; text-decoration: none; border-radius: 5px; width: 48%; display: inline-block; text-align: center; line-height: 1.5;">Cancel·lar</a>
        </div>
    </form>
</div>
@endsection
