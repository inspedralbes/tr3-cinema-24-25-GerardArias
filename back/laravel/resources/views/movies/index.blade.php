<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Películas</title>
</head>
<body>
    <h1>Películas</h1>
    <ul>
        @foreach($movies as $movie)
            <li>{{ $movie->title }} - {{ $movie->genre }}</li>
        @endforeach
    </ul>
</body>
</html>
