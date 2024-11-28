<?php

namespace Tests\Feature;

use Illuminate\Support\Facades\Artisan;
use Tests\TestCase;

class ConsoleTest extends TestCase
{
/**
* Test que verifica que el comando `inspire` devuelve una cita inspiradora.
*/
public function test_inspire_command_outputs_quote(): void
{
Artisan::call('inspire');

$output = Artisan::output();
$this->assertNotEmpty($output);
$this->assertStringContainsString('“', $output); // Verifica que contiene una cita
}
}
