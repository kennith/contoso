<?php

namespace Tests\Feature\app\Console\Commands;

use Tests\TestCase;
use App\Mail\HelloWorldMail;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Foundation\Testing\RefreshDatabase;

class SendHelloWorldMailCommandTest extends TestCase
{
    use RefreshDatabase;

    public function testMailBag()
    {
        Mail::fake();
        Mail::assertNothingSent();

        Artisan::call('app:send-hello-world-mail');

        Mail::assertSent(HelloWorldMail::class);
    }
}
