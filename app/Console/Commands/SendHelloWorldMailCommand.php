<?php

namespace App\Console\Commands;

use App\Mail\HelloWorldMail;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Mail;

class SendHelloWorldMailCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:send-hello-world-mail';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Send a hello world mail';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $helloWorldMail = new HelloWorldMail();
        Mail::to('test@example.com')->send($helloWorldMail);
        return 0;
    }
}
