@extends('layout.app')

@section('title', 'Inicio')

@section('content')


<div class="hero">
    <h1>Benvingut al Administrador</h1>
</div>

<!-- Centrado de las columnas -->
<div class="row d-flex justify-content-center">
    <div class="col-md-4 mb-4">
        <div class="card p-3 text-center">
            <h3>Pel·licules</h3>
            <a href="{{ route('movies.index') }}" class="btn btn-dark">Veure llistat de pel·licules</a>
        </div>
    </div>
    <div class="col-md-4 mb-4">
        <div class="card p-3 text-center">
            <h3>Entrades(tickets)</h3>
        </div>
    </div>
    <div class="col-md-4 mb-4">
        <div class="card p-3 text-center">
            <h3>Sessions</h3>
            <a href="{{ route('sessions.index') }}" class="btn btn-dark">Veure llistat de les sessions disponibles</a>
        </div>
    </div>
</div>

@endsection