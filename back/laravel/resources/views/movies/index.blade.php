@extends('layout.app')

@section('title', 'Inicio')

@section('content')
    <h1>Películas</h1>
    <ul>
        @foreach($movies as $movie)
            <li>{{ $movie->title }} - {{ $movie->genre }}</li>
        @endforeach
    </ul>

@endsection