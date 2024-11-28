<?php

namespace Tests\Feature;

use Tests\TestCase;

class HomepageTest extends TestCase
{
/**
* Test que verifica si la página principal devuelve una respuesta exitosa.
*/
public function test_homepage_returns_successful_response(): void
{
$response = $this->get('/');

// Verifica que la respuesta sea 200
$response->assertStatus(200);

// Verifica que la página contiene el texto "Laravel"
$response->assertSee('Laravel');
}
}