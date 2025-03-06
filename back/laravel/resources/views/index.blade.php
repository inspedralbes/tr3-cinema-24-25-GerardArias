@extends('layout.app')

@section('title', 'Inicio')

@section('content')


<div class="hero">
    <h1>Benvingut al CRUD</h1>
    <p>Administra usuaris i projectes de manera sencilla i eficient.</p>
</div>

<!-- Centrado de las columnas -->
<div class="row d-flex justify-content-center">
    <div class="col-md-4 mb-4">
        <div class="card p-3 text-center">
            <h3>Pel·licules</h3>
        </div>
    </div>
    <div class="col-md-4 mb-4">
        <div class="card p-3 text-center">
            <h3>Entrades(tickets)</h3>
        </div>
    </div>
</div>

@endsection