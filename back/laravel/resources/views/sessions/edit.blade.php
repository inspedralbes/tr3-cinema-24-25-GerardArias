@extends('layout.app')

@section('title', 'Editar Sessió')

@section('content')
<div>
    <h1>Editar Sessió</h1>

    <form action="{{ route('sessions.update', $session->id) }}" method="POST">
        @csrf
        @method('PUT')
        <div>
            <label>Pel·lícula</label>
            <select name="movie_id" required>
                @foreach($movies as $movie)
                    <option value="{{ $movie->id }}" {{ $movie->id == $session->movie_id ? 'selected' : '' }}>
                        {{ $movie->title }}
                    </option>
                @endforeach
            </select>
        </div>
        <div>
            <label>Data</label>
            <input type="date" name="date" value="{{ $session->date }}" required>
        </div>
        <div>
            <label>Hora</label>
            <input type="time" name="time" value="{{ $session->time }}" required>
        </div>
        <div>
            <label>VIP</label>
            <select name="vip_enabled" required>
                <option value="1" {{ $session->vip_enabled ? 'selected' : '' }}>Sí</option>
                <option value="0" {{ !$session->vip_enabled ? 'selected' : '' }}>No</option>
            </select>
        </div>
        <div>
            <label>Dia de Descompte</label>
            <select name="is_discount_day" required>
                <option value="1" {{ $session->is_discount_day ? 'selected' : '' }}>Sí</option>
                <option value="0" {{ !$session->is_discount_day ? 'selected' : '' }}>No</option>
            </select>
        </div>
        <button type="submit">Actualitzar</button>
        <a href="{{ route('sessions.index') }}">Cancel·lar</a>
    </form>
</div>
@endsection
