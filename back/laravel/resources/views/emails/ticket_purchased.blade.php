<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Compra d'Entrades</title>
</head>
<body>
    <h1>Detalls de la teva compra</h1>
    <p>Has comprat les següents entrades:</p>
    <ul>
        @foreach($tickets as $ticket)
            <li>Sessió: {{ $ticket->session_id }}, Seient: {{ $ticket->seat_id }}, Preu: {{ $ticket->price }}€</li>
        @endforeach
    </ul>
</body>
</html>
