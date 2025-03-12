<?php
namespace App\Http\Controllers;

use App\Models\FilmSessions;
use App\Models\Movies;
use App\Models\Seats;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class FilmSessionsController extends Controller
{
    public function index(Request $request)
    {
        $sessions = FilmSessions::with('movie')->get();

        if ($request->is('api/*')) {
            return response()->json($sessions);
        }

        return view('sessions.index', compact('sessions'));
    }

    public function create()
    {
        $movies = Movies::all();
        return view('sessions.create', compact('movies'));
    }

    public function store(Request $request)
    {
        // Validar los datos enviados desde el formulario
        $validated = $request->validate([
            'movie_id' => 'required|exists:movies,id',
            'date' => 'required|date',
            'time' => 'required|date_format:H:i',
            'vip_enabled' => 'sometimes|boolean',
            'is_discount_day' => 'sometimes|boolean',
        ]);

        // Asignar valores booleanos para las opciones VIP y descuento
        $validated['vip_enabled'] = $request->has('vip_enabled');
        $validated['is_discount_day'] = $request->has('is_discount_day');

        try {
            // Crear la sesión
            $session = FilmSessions::create($validated);
            Log::info('Sesión creada con éxito con ID:', ['session_id' => $session->id]);

            // Generar y guardar las butacas como JSON
            $seatsJson = $this->generateSeatsJson($session);

            // Guardar el JSON de las butacas en la tabla `seats` para esta sesión
            $session->seats_json = $seatsJson;
            $session->save(); // Guardamos el JSON en la sesión

            // Redirigir con éxito
            return redirect()->route('sessions.index')->with('success', 'Sessió creada correctament!');
        } catch (\Exception $e) {
            // Si algo sale mal, capturamos la excepción
            Log::error('Error al crear la sesión:', ['error' => $e->getMessage()]);
            return redirect()->back()->with('error', 'Ocurrió un error al crear la sesión.');
        }
    }

    public function show(FilmSessions $session)
    {
        return view('sessions.show', compact('session'));
    }

    public function edit(FilmSessions $session)
    {
        $movies = Movies::all();
        return view('sessions.edit', compact('session', 'movies'));
    }

    public function update(Request $request, FilmSessions $session)
    {
        $validated = $request->validate([
            'movie_id' => 'required|exists:movies,id',
            'date' => 'required|date',
            'time' => 'required|date_format:H:i:s',
            'vip_enabled' => 'required|boolean',
            'is_discount_day' => 'required|boolean',
        ]);

        $session->update($validated);
        return redirect()->route('sessions.index')->with('success', 'Sessió actualitzada!');
    }

    public function destroy(FilmSessions $session)
    {
        $session->delete();
        return redirect()->route('sessions.index')->with('success', 'Sessió eliminada.');
    }

    // Función para crear las butacas a partir del JSON
    private function generateSeatsJson(FilmSessions $session)
    {
        $rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L'];
        $maxSeatsPerRow = 10;

        $seatsData = [];

        foreach ($rows as $row) {
            for ($number = 1; $number <= $maxSeatsPerRow; $number++) {
                $type = ($number <= 2 && $session->vip_enabled) ? 'VIP' : 'Normal';

                // Crear un arreglo con la información de la butaca
                $seatsData[] = [
                    'row' => $row,
                    'number' => $number,
                    'type' => $type,
                    'status' => 'Disponible',
                ];
            }
        }

        // Devolver el JSON con todas las butacas
        return json_encode($seatsData);
    }
}
