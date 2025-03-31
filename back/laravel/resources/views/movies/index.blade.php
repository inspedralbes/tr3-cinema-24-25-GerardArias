@extends('layout.app')

@section('content')
<div style="max-width: 900px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9;">
    <h2 style="text-align: center; font-size: 2em; color: #333;">Llista de Pel·lícules</h2>

    @if(session('success'))
        <div style="background-color: #2ecc71; color: white; padding: 10px; margin-bottom: 15px; border-radius: 5px; text-align: center;">
            {{ session('success') }}
        </div>
    @endif

    <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
        <thead>
            <tr>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">ID</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Títol</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Gènere</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Accions</th>
            </tr>
        </thead>
        <tbody>
            @foreach($movies as $movie)
                <tr style="border-bottom: 1px solid #ddd;">
                    <td style="padding: 10px; text-align: left;">{{ $movie->id }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $movie->title }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $movie->genre }}</td>
                    <td style="padding: 10px; text-align: left;">
                        <form action="{{ route('movies.destroy', $movie->id) }}" method="POST" style="display:inline;">
                            @csrf
                            @method('DELETE')
                            <button type="submit" style="background-color: #e74c3c; color: white; border: none; padding: 5px 10px; border-radius: 5px; cursor: pointer;" onclick="return confirm('¿Seguro que quieres eliminar esta película?')">
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
