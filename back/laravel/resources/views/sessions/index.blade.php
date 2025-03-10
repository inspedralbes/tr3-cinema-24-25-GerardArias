@extends('layout.app')

@section('title', 'Sesiones de Cine')

@section('content')
    <h1 style="text-align:center; font-size: 2em; color: #333;">Sesiones de Cine</h1>

    @if(session('success'))
        <div style="color: green; margin-bottom: 10px; text-align: center;">
            {{ session('success') }}
        </div>
    @endif

    <div style="text-align: center; margin-bottom: 20px;">
        <a href="{{ route('sessions.create') }}" style="background-color: #3498db; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-size: 1em; cursor: pointer;">Crear Nueva Sesión</a>
    </div>

    <div style="max-width: 800px; margin: 0 auto; padding: 20px;">
        <ul style="list-style-type: none; padding: 0;">
            @foreach($sessions as $session)
                <li style="border-bottom: 1px solid #ddd; padding: 10px 0; display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <strong style="font-size: 1.2em; color: #333;">{{ $session->movie->title }}</strong> - 
                        <span style="color: #888;">{{ $session->date }} - {{ $session->time }}</span>
                    </div>

                    <div>
                        <a href="{{ route('sessions.edit', $session) }}" style="color: #3498db; text-decoration: none; margin-right: 10px;">Editar</a>
                        
                        <form action="{{ route('sessions.destroy', $session->id) }}" method="POST" style="display:inline;">
                            @csrf
                            @method('DELETE')
                            <button type="submit" style="background-color: #e74c3c; color: white; border: none; padding: 5px 10px; border-radius: 5px; cursor: pointer;" onclick="return confirm('¿Seguro que deseas eliminar esta sesión?')">Eliminar</button>
                        </form>
                    </div>
                </li>
            @endforeach
        </ul>
    </div>
@endsection
