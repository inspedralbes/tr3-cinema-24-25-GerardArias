@extends('layout.app')

@section('title', 'Inicio')

@section('content')
    <h1 style="text-align:center; font-size: 2em; color: #333;">Pel·lícules</h1>
    
    <div style="max-width: 800px; margin: 0 auto; padding: 20px;">
        <ul style="list-style-type: none; padding: 0;">
            @foreach($movies as $movie)
                <li style="border-bottom: 1px solid #ddd; padding: 10px 0; display: flex; justify-content: space-between; align-items: center;">
                    <span style="font-size: 1.2em; color: #333;">
                        {{ $movie->title }} - <span style="color: #888;">{{ $movie->genre }}</span>
                    </span>
                    
                    <form action="{{ route('movies.destroy', $movie->id) }}" method="POST" style="display:inline;">
                        @csrf
                        @method('DELETE')
                        <button type="submit" style="background-color: #e74c3c; color: white; border: none; padding: 5px 10px; border-radius: 5px; cursor: pointer;" onclick="return confirm('¿Seguro que quieres eliminar esta película?')">Eliminar</button>
                    </form>
                </li>
            @endforeach
        </ul>
    </div>
@endsection
