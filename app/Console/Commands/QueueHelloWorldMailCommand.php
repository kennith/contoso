<?php

namespace App\Console\Commands;

use App\Jobs\SendHelloWorldMailJob;
use Illuminate\Console\Command;

class QueueHelloWorldMailCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:queue-hello-world-mail';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Add hello world mail to the queue';

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
        SendHelloWorldMailJob::dispatch();
        return 0;
    }
}
