@extends('layout.app')

@section('content')
<div style="max-width: 900px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9;">
    <h2 style="text-align: center; font-size: 2em; color: #333;">Lista de Usuarios</h2>

    <div style="text-align: center; margin-bottom: 20px;">
        <a href="{{ route('users.create') }}" style="background-color: #3498db; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; font-size: 1em; cursor: pointer;">
            Crear Usuario
        </a>
    </div>

    <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
        <thead>
            <tr>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">ID</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Nombre</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Apellido</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Email</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Teléfono</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Acciones</th>
            </tr>
        </thead>
        <tbody>
            @foreach($users as $user)
                <tr style="border-bottom: 1px solid #ddd;">
                    <td style="padding: 10px; text-align: left;">{{ $user->id }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $user->name }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $user->lastname }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $user->email }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $user->phone }}</td>
                    <td style="padding: 10px; text-align: left;">
                        <a href="{{ route('users.edit', $user->id) }}" style="background-color: #f39c12; color: white; padding: 5px 10px; text-decoration: none; border-radius: 5px; font-size: 1em; cursor: pointer; margin-right: 10px;">
                            Editar
                        </a>
                        <form action="{{ route('users.destroy', $user->id) }}" method="POST" style="display:inline;">
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
