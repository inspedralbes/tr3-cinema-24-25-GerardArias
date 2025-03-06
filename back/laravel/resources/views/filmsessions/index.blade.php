@extends('layout.app')

@section('title', 'Sesiones de Cine')

@section('content')
    <h1>Sesiones de Cine</h1>

    @if(session('success'))
        <div style="color: green; margin-bottom: 10px;">
            {{ session('success') }}
        </div>
    @endif

    <a href="{{ route('filmsessions.create') }}">Crear Nueva Sesión</a>

    <ul>
        @foreach($filmSessions as $session)
            <li>
                <strong>{{ $session->movie->title }}</strong> - 
                {{ $session->date }} - 
                {{ $session->time }} 
                <a href="{{ route('filmsessions.edit', $session->id) }}">Editar</a>

                <form action="{{ route('filmsessions.destroy', $session->id) }}" method="POST" style="display:inline;">
                    @csrf
                    @method('DELETE')
                    <button type="submit" onclick="return confirm('¿Seguro que deseas eliminar esta sesión?')">Eliminar</button>
                </form>
            </li>
        @endforeach
    </ul>
@endsection
