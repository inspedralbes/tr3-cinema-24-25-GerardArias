@extends('layout.app')

@section('content')
<div style="max-width: 900px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9;">
    <h2 style="text-align: center; font-size: 2em; color: #333;">Llista d'Usuaris</h2>

    @if(session('success'))
        <div style="background-color: #2ecc71; color: white; padding: 10px; margin-bottom: 15px; border-radius: 5px; text-align: center;">
            {{ session('success') }}
        </div>
    @endif

    <div style="text-align: center; margin-bottom: 20px;">
        <a href="{{ route('users.create') }}" style="background-color: #3498db; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-size: 1em; cursor: pointer;">
            Crear Usuari
        </a>
    </div>

    <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
        <thead>
            <tr>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">ID</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Nom</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Cognom</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Email</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Teléfon</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Accions</th>
            </tr>
        </thead>
        <tbody>
            @foreach($users as $usuario)
                <tr style="border-bottom: 1px solid #ddd;">
                    <td style="padding: 10px; text-align: left;">{{ $usuario->id }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $usuario->name }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $usuario->lastname }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $usuario->email }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $usuario->phone }}</td>
                    <td style="padding: 10px; text-align: left;">
                        <a href="{{ route('users.edit', $usuario->id) }}" style="background-color: #f39c12; color: white; padding: 5px 10px; text-decoration: none; border-radius: 5px; font-size: 1em; cursor: pointer; margin-right: 10px;">
                            Editar
                        </a>
                        <form action="{{ route('users.destroy', $usuario->id) }}" method="POST" style="display:inline;">
                            @csrf
                            @method('DELETE')
                            <button type="submit" style="background-color: #e74c3c; color: white; border: none; padding: 5px 10px; border-radius: 5px; cursor: pointer;" onclick="return confirm('¿Estás seguro?')">
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
