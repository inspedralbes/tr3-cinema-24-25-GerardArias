@extends('layout.app')

@section('title', 'Editar Sesión de Cine')

@section('content')
    <h1>Editar Sesión de Cine</h1>

    <form action="{{ route('filmsessions.update', $session->id) }}" method="POST">
        @csrf
        @method('PUT')
        
        <div>
            <label for="movie_id">Película:</label>
            <select name="movie_id" id="movie_id">
                @foreach($movies as $movie)
                    <option value="{{ $movie->id }}" {{ $session->movie_id == $movie->id ? 'selected' : '' }}>
                        {{ $movie->title }}
                    </option>
                @endforeach
            </select>
        </div>

        <div>
            <label for="date">Fecha:</label>
            <input type="date" name="date" id="date" value="{{ $session->date }}" required>
        </div>

        <div>
            <label for="time">Hora:</label>
            <input type="time" name="time" id="time" value="{{ $session->time }}" required>
        </div>

        <div>
            <label for="vip_enabled">¿VIP?</label>
            <input type="checkbox" name="vip_enabled" id="vip_enabled" value="1" {{ $session->vip_enabled ? 'checked' : '' }}>
        </div>

        <div>
            <label for="is_discount_day">¿Día con descuento?</label>
            <input type="checkbox" name="is_discount_day" id="is_discount_day" value="1" {{ $session->is_discount_day ? 'checked' : '' }}>
        </div>

        <button type="submit">Actualizar Sesión</button>
    </form>
@endsection
