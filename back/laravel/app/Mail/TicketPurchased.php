<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use SimpleSoftwareIO\QrCode\Facades\QrCode;
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
        foreach ($this->tickets as $ticket) {
            $qrCodeContent = 'Sesion: ' . $ticket->session_id . ' Asiento: ' . $ticket->seat_id;
            
            $qrCodeImage = QrCode::format('png')->size(150)->generate($qrCodeContent);
            $fileName = 'ticket_qr_' . $ticket->id . '.png';
            $filePath = storage_path('app/public/' . $fileName);
            file_put_contents($filePath, $qrCodeImage);

            $ticket->qr_code_path = $filePath;
        }

        return $this->subject('Compra de Entradas')
            ->view('emails.ticket_purchased');
    }
}
