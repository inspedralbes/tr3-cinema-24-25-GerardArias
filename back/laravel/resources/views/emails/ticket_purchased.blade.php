<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Compra de Entradas</title>
</head>
<body>
    <h1>Detalles de tu compra</h1>
    <p>Has comprado las siguientes entradas:</p>
    <ul>
        @foreach($tickets as $ticket)
            <li>Sesión: {{ $ticket->session_id }}, Asiento: {{ $ticket->seat_id }}, Precio: {{ $ticket->price }}€</li>
            <img src="cid:ticket_qr_{{ $ticket->id }}" alt="QR Ticket" />
        @endforeach
    </ul>
</body>
</html>
