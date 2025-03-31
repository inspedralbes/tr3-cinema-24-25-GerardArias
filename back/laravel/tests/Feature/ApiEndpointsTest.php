<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ApiEndpointsTest extends TestCase
{
    use RefreshDatabase;

    /**
     * Test para el endpoint de registro.
     * Se asume que el controlador retorna un código 201 con la estructura {user, token}.
     */
    public function test_register_endpoint_creates_a_user()
    {
        $userData = [
            'name'                  => 'Juan Pérez',
            'email'                 => 'juan@example.com',
            'password'              => 'password',
            'password_confirmation' => 'password'
        ];

        $response = $this->postJson('/api/register', $userData);

        $response->assertStatus(201)
                 ->assertJsonStructure(['user', 'token']);
    }

    /**
     * Test para el endpoint de login.
     * Se espera que al enviar las credenciales válidas se retorne un token.
     */
    public function test_login_endpoint_returns_token()
    {
        $user = User::factory()->create([
            'password' => bcrypt('password'),
        ]);

        $loginData = [
            'email'    => $user->email,
            'password' => 'password'
        ];

        $response = $this->postJson('/api/login', $loginData);

        $response->assertStatus(200)
                 ->assertJsonStructure(['user', 'token']);
    }

    /**
     * Test para el endpoint que lista las películas.
     */
    public function test_movies_endpoint_returns_movies()
    {
        $response = $this->getJson('/api/movies');
        $response->assertStatus(200);
    }

    /**
     * Test para el endpoint que lista las sesiones.
     */
    public function test_sessions_endpoint_returns_sessions()
    {
        $response = $this->getJson('/api/sessions');
        $response->assertStatus(200);
    }

    /**
     * Test para el endpoint que muestra los asientos de una sesión.
     * Se utiliza un ID de sesión de ejemplo.
     */
    public function test_seats_endpoint_returns_session_seats()
    {
        $sessionId = 1; // Debe existir o estar simulado en tus seeds/factories
        $response = $this->getJson("/api/seats/session/{$sessionId}");
        $response->assertStatus(200);
    }

    /**
     * Test para el endpoint que actualiza el estado de un asiento.
     */
    public function test_update_seat_status_endpoint_updates_seat()
    {
        // Datos de ejemplo; asegúrate que tu lógica en el controlador maneje estos datos
        $payload = [
            'seat_id' => 1,
            'status'  => 'occupied'
        ];

        $response = $this->postJson('/api/seats/update', $payload);
        $response->assertStatus(200);
    }

    /**
     * Test para el endpoint que crea un ticket.
     */
    public function test_store_ticket_endpoint_creates_ticket()
    {
        $payload = [
            'movie_id'    => 1,
            'session_id'  => 1,
            'user_email'  => 'juan@example.com',
            'seat_numbers'=> [1, 2, 3]
        ];

        $response = $this->postJson('/api/tickets', $payload);
        $response->assertStatus(201);
    }

    /**
     * Test para el endpoint que obtiene los tickets de un usuario por email.
     */
    public function test_get_user_tickets_endpoint_returns_tickets()
    {
        $email = 'juan@example.com';
        $response = $this->getJson("/api/tickets/{$email}");
        $response->assertStatus(200);
    }

    /**
     * Test para verificar que las rutas protegidas requieren autenticación.
     */
    public function test_authenticated_routes_require_authentication()
    {
        // Sin autenticación: se espera un 401 en el endpoint de usuarios
        $response = $this->getJson('/api/users');
        $response->assertStatus(401);

        // Se crea un usuario para autenticarse usando Sanctum
        $user = User::factory()->create();
        $this->actingAs($user, 'sanctum');

        $response = $this->getJson('/api/users');
        $response->assertStatus(200);

        // Se prueba el logout sin autenticación
        $this->withHeaders([]); // Remover la autenticación
        $response = $this->postJson('/api/logout');
        $response->assertStatus(401);
    }
}
