<?php

namespace Tests\Feature\app\Console\Commands;

use App\Jobs\SendHelloWorldMailJob;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Support\Facades\Queue;
use Illuminate\Support\Facades\Artisan;
use Tests\TestCase;

class QueueHelloWorldMailCommandTest extends TestCase
{
    public function testQueueJob()
    {
        Queue::fake();

        Artisan::call('app:queue-hello-world-mail');
        Queue::assertPushed(SendHelloWorldMailJob::class);
    }
}
