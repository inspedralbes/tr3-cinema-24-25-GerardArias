@extends('layout.app')

@section('content')
<div style="max-width: 900px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background-color: #f9f9f9;">
    <h2 style="text-align: center; font-size: 2em; color: #333;">Lista de Tickets</h2>

    @if(session('success'))
        <div style="background-color: #2ecc71; color: white; padding: 10px; margin-bottom: 15px; border-radius: 5px; text-align: center;">
            {{ session('success') }}
        </div>
    @endif

    <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
        <thead>
            <tr>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">ID</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Email</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Película</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Asiento</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Precio</th>
                <th style="padding: 12px; background-color: #3498db; color: white; text-align: left;">Acciones</th>
            </tr>
        </thead>
        <tbody>
            @foreach($tickets as $ticket)
                <tr style="border-bottom: 1px solid #ddd;">
                    <td style="padding: 10px; text-align: left;">{{ $ticket->id }}</td>
                    <td style="padding: 10px; text-align: left;">{{ $ticket->email }}</td>
                    <td style="padding: 10px; text-align: left;">
                        {{ $ticket->filmSession && $ticket->filmSession->movie ? $ticket->filmSession->movie->name : 'N/A' }}
                    </td>
                    <td style="padding: 10px; text-align: left;">
                        {{ $ticket->seat ? $ticket->seat->row . '-' . $ticket->seat->number : 'N/A' }}
                    </td>
                    <td style="padding: 10px; text-align: left;">${{ number_format($ticket->price, 2) }}</td>
                    <td style="padding: 10px; text-align: left;">
                        <form action="{{ route('tickets.destroy', $ticket->id) }}" method="POST" style="display:inline;">
                            @csrf
                            @method('DELETE')
                            <button type="submit" style="background-color: #e74c3c; color: white; border: none; padding: 5px 10px; border-radius: 5px; cursor: pointer;" onclick="return confirm('¿Estás seguro de eliminar este ticket?')">
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
