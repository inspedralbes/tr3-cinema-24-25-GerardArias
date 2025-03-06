@extends('layout.app')

@section('title', 'Inicio')

@section('content')
    <h1>Pel·licules</h1>
    <ul>
        @foreach($movies as $movie)
            <li>
                {{ $movie->title }} - {{ $movie->genre }}
                <form action="{{ route('movies.destroy', $movie->id) }}" method="POST" style="display:inline;">
                    @csrf
                    @method('DELETE')
                    <button type="submit" onclick="return confirm('¿Seguro que quieres eliminar esta película?')">Eliminar</button>
                </form>
            </li>
        @endforeach
    </ul>
@endsection
