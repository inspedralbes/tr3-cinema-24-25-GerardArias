<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tickets extends Model
{
    use HasFactory;

    protected $table = 'tickets';

    protected $fillable = [
        'email',
        'session_id',
        'seat_id',
        'price',
    ];

    /**
     * Relación con la sesión de película.
     */
    public function filmSession()
    {
        return $this->belongsTo(FilmSessions::class, 'session_id');
    }

    /**
     * Relación con el asiento.
     */
    public function seat()
    {
        return $this->belongsTo(Seats::class, 'seat_id');
    }
}
