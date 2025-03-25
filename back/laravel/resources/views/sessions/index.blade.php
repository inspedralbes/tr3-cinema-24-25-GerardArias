@extends('layout.app')

@section('content')
<div style="max-width: 900px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9;">
    <h2 style="text-align: center; font-size: 2em; color: #333;">Llista de Sessions de Cinema</h2>

    @if(session('success'))
        <div style="background-color: #2ecc71; color: white; padding: 10px; margin-bottom: 15px; border-radius: 5px; text-align: center;">
            {{ session('success') }}
        </div>
    @endif

    <div style="text-align: center; margin-bottom: 20px;">
        <a href="{{ route('sessions.create') }}" style="background-color: #3498db; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-size: 1em; cursor: pointer;">
            Crear Nova Sessió
        </a>
    </div>

    <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
        <thead>
            <tr>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">ID</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Pel·lícula</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Data</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Hora</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Accions</th>
            </tr>
        </thead>
        <tbody>
            @foreach($sessions as $session)
                <tr style="border-bottom: 1px solid #ddd;">
                    <td style="padding: 10px; text-align: left;">{{ $session->id }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $session->movie->title }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $session->date }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $session->time }}</td>
                    <td style="padding: 10px; text-align: left;">
                        <a href="{{ route('sessions.edit', $session->id) }}" style="background-color: #f39c12; color: white; padding: 5px 10px; text-decoration: none; border-radius: 5px; font-size: 1em; cursor: pointer; margin-right: 10px;">
                            Editar
                        </a>
                        <form action="{{ route('sessions.destroy', $session->id) }}" method="POST" style="display:inline;">
                            @csrf
                            @method('DELETE')
                            <button type="submit" style="background-color: #e74c3c; color: white; border: none; padding: 5px 10px; border-radius: 5px; cursor: pointer;" onclick="return confirm('Estàs segur que vols eliminar aquesta sessió?')">
                                Eliminar
                            </button>
                        </form>
                    </td>
                </tr>
            @endforeach
        </tbody>
    </table>
</div>
@endsection
