<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Seats extends Model
{
    use HasFactory;

    protected $fillable = ['session_id', 'seats_json'];

    protected $casts = [
        'seats_json' => 'array',
    ];

    public function session()
    {
        return $this->belongsTo(FilmSessions::class);
    }
}
