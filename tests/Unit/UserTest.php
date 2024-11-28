<?php

namespace Tests\Unit;

use App\Models\User;
use PHPUnit\Framework\TestCase;

class UserTest extends TestCase
{
/**
* Test que verifica los atributos "fillable" del modelo User.
*/
public function test_user_has_fillable_attributes(): void
{
$user = new User();
$this->assertEquals(['name', 'email', 'password'], $user->getFillable());
}

/**
* Test que verifica que el atributo "password" está oculto en la serialización.
*/
public function test_user_has_hidden_password(): void
{
$user = new User();
$this->assertContains('password', $user->getHidden());
$this->assertContains('remember_token', $user->getHidden());
}

/**
* Test que verifica que los atributos están correctamente casteados.
*/
public function test_user_has_correct_casts(): void
{
$user = new User();
$this->assertEquals([
'email_verified_at' => 'datetime',
'password' => 'hashed',
'id' => 'int', // Añadido para reflejar correctamente el cast
], $user->getCasts());
}
}
