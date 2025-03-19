<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use SimpleSoftwareIO\QrCode\Facades\QrCode; // Importar la librería para generar el QR
use Illuminate\Support\Facades\Storage;

class TicketPurchased extends Mailable
{
    use Queueable, SerializesModels;

    public $tickets;

    public function __construct($tickets)
    {
        $this->tickets = $tickets;
    }

    public function build()
    {
        // Crear el QR para cada ticket y guardarlo temporalmente
        foreach ($this->tickets as $ticket) {
            // Generar el contenido del QR (puedes personalizarlo con la información del ticket)
            $qrCodeContent = 'Sesion: ' . $ticket->session_id . ' Asiento: ' . $ticket->seat_id;
            
            // Generar el QR y guardarlo en una carpeta temporal
            $qrCodeImage = QrCode::format('png')->size(150)->generate($qrCodeContent);
            $fileName = 'ticket_qr_' . $ticket->id . '.png';
            $filePath = storage_path('app/public/' . $fileName);
            file_put_contents($filePath, $qrCodeImage);

            // Agregar el archivo al ticket
            $ticket->qr_code_path = $filePath;
        }

        // Enviar el correo con los tickets y los QR generados
        return $this->subject('Compra de Entradas')
            ->view('emails.ticket_purchased');
    }
}
