@extends('layout.app')

@section('title', 'Inicio')

@section('content')
    <h1>Sessions</h1>
    <ul>
        @foreach($filmSessions as $session)
            <li>{{ $session->movie->title }} - {{ $session->date }} - {{ $session->time }}</li>
        @endforeach
    </ul>

@endsection