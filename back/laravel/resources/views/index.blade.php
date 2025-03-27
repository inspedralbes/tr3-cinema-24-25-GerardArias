@extends('layout.app')

@section('title', 'Inicio')

@section('content')

<div class="hero text-center text-white py-5" style="background: linear-gradient(135deg, #1a1a2e, #16213e); border-radius: 10px; margin-bottom: 40px;">
    <h1 class="fw-bold text-uppercase">Benvingut al Administrador</h1>
    <p class="fs-5">Gestiona totes les seccions des d'aquí</p>
</div>

<div class="container">
    <div class="row d-flex justify-content-center">
        @php
            $sections = [
                ['title' => 'Pel·lícules', 'route' => 'movies.index', 'icon' => '🎬'],
                ['title' => 'Entrades', 'route' => 'tickets.index', 'icon' => '🎟️'],
                ['title' => 'Sessions', 'route' => 'sessions.index', 'icon' => '📅'],
                ['title' => 'Usuaris', 'route' => 'users.index', 'icon' => '👥']
            ];
        @endphp

        @foreach ($sections as $section)
            <div class="col-md-4 mb-4">
                <div class="card text-center p-4" style="background-color: #0f3460; color: white; border-radius: 15px; transition: transform 0.3s ease-in-out;">
                    <div class="fs-1">{{ $section['icon'] }}</div>
                    <h3 class="fw-bold mt-3">{{ $section['title'] }}</h3>
                    <a href="{{ route($section['route']) }}" class="btn mt-3" style="background-color: #e94560; color: white; padding: 10px 20px; border-radius: 5px; transition: background-color 0.3s;">
                        Veure més
                    </a>
                </div>
            </div>
        @endforeach
    </div>
</div>

@endsection
