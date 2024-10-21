<?php

namespace Admin\Controllers\Public;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class EMail extends Mailable
{
    use Queueable, SerializesModels;
    protected $email;
    /**
     * Create a new message instance.
     *
     * @param $email
     * @return void
     */
    public function __construct($email,$view)
    {
        $this->email = $email;
        $this->view = $view;
    }
    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
        $email = $this->email;
        $view = $this->view;
        return $this->view('emails.'.$view)->with(compact('email'));
    }
}