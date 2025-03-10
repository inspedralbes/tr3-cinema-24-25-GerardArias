@extends('layout.app')

@section('title', 'Inicio')

@section('content')

<!-- Sección Hero -->
<div class="hero" style="background-color: #2c3e50; padding: 60px 0; text-align: center; color: white; margin-bottom: 40px; border-radius: 10px;">
    <h1 style="font-size: 3em; font-weight: bold; text-transform: uppercase;">Benvingut al Administrador</h1>
    <p style="font-size: 1.2em; margin-top: 10px;">Gestiona totes les seccions des d'aquí</p>
</div>

<!-- Tarjetas en columnas -->
<div class="row d-flex justify-content-center">
    <!-- Pel·lícules -->
    <div class="col-md-4 mb-4">
        <div class="card p-3 text-center" style="background-color: #ecf0f1; border-radius: 15px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);">
            <h3 style="font-size: 1.8em; font-weight: bold; color: #34495e;">Pel·licules</h3>
            <a href="{{ route('movies.index') }}" class="btn" style="background-color: #3498db; color: white; font-weight: bold; padding: 10px 20px; text-transform: uppercase; border-radius: 5px; transition: background-color 0.3s ease;">
                Veure llistat de pel·licules
            </a>
        </div>
    </div>
    
    <!-- Entrades (Tickets) -->
    <div class="col-md-4 mb-4">
        <div class="card p-3 text-center" style="background-color: #ecf0f1; border-radius: 15px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);">
            <h3 style="font-size: 1.8em; font-weight: bold; color: #34495e;">Entrades (Tickets)</h3>
            <!-- Aquí puedes agregar algo más para las entradas -->
        </div>
    </div>

    <!-- Sessions -->
    <div class="col-md-4 mb-4">
        <div class="card p-3 text-center" style="background-color: #ecf0f1; border-radius: 15px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);">
            <h3 style="font-size: 1.8em; font-weight: bold; color: #34495e;">Sessions</h3>
            <a href="{{ route('sessions.index') }}" class="btn" style="background-color: #3498db; color: white; font-weight: bold; padding: 10px 20px; text-transform: uppercase; border-radius: 5px; transition: background-color 0.3s ease;">
                Veure llistat de les sessions disponibles
            </a>
        </div>
    </div>

    <!-- Usuaris -->
    <div class="col-md-4 mb-4">
        <div class="card p-3 text-center" style="background-color: #ecf0f1; border-radius: 15px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);">
            <h3 style="font-size: 1.8em; font-weight: bold; color: #34495e;">Usuaris</h3>
            <a href="{{ route('users.index') }}" class="btn" style="background-color: #3498db; color: white; font-weight: bold; padding: 10px 20px; text-transform: uppercase; border-radius: 5px; transition: background-color 0.3s ease;">
                Veure llistat dels usuaris
            </a>
        </div>
    </div>
</div>

@endsection
