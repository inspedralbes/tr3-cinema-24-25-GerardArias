@extends('layout.app')

@section('title', 'Crear Sesión de Cine')

@section('content')
    <h1>Crear Nueva Sesión</h1>

    <form action="{{ route('filmsessions.store') }}" method="POST">
        @csrf
        <div>
            <label for="movie_id">Película:</label>
            <select name="movie_id" id="movie_id" required>
                @foreach($movies as $movie)
                    <option value="{{ $movie->id }}">{{ $movie->title }}</option>
                @endforeach
            </select>
        </div>

        <div>
            <label for="date">Fecha:</label>
            <input type="date" name="date" id="date" required>
        </div>

        <div>
            <label for="time">Hora:</label>
            <input type="time" name="time" id="time" required>
        </div>

        <div>
            <label for="vip_enabled">¿VIP?</label>
            <input type="checkbox" name="vip_enabled" id="vip_enabled" value="1">
        </div>

        <div>
            <label for="is_discount_day">¿Día con descuento?</label>
            <input type="checkbox" name="is_discount_day" id="is_discount_day" value="1">
        </div>

        <button type="submit">Crear Sesión</button>
    </form>
@endsection
