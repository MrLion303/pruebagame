// Reiniciar movimiento
movimiento = false;

// Si NO existe el pauser Y TAMPOCO existe la caja de diálogo, permitir movimiento
if (!instance_exists(obj_pauser) && !instance_exists(obj_textbox))
{
    // Correr
    if (keyboard_check(ord("X")))
    {
        velocidad = 5;
    }
    else
    {
        velocidad = 4;
    }

    // Derecha (Subida y bajada automática de rampas)
    if (keyboard_check(vk_right))
    {
        direccion = "derecha";
        face = RIGHT;

        var _max_slope = 4; // Altura máxima que puede subir o bajar automáticamente

        if (!place_meeting(x + velocidad, y, colision))
        {
            x += velocidad;
            movimiento = true;
        }
        else
        {
            var _sloped = false;
            
            // 1. Intentar subir (rampa hacia arriba)
            for (var _i = 1; _i <= _max_slope; _i++)
            {
                if (!place_meeting(x + velocidad, y - _i, colision))
                {
                    y -= _i; 
                    x += velocidad; 
                    movimiento = true;
                    _sloped = true;
                    break;
                }
            }
            
            // 2. Si no pudo subir, intentar bajar (rampa hacia abajo / superior)
            if (!_sloped)
            {
                for (var _i = 1; _i <= _max_slope; _i++)
                {
                    if (!place_meeting(x + velocidad, y + _i, colision))
                    {
                        y += _i; 
                        x += velocidad; 
                        movimiento = true;
                        _sloped = true;
                        break;
                    }
                }
            }
        }
    }

    // Izquierda (Subida y bajada automática de rampas)
    if (keyboard_check(vk_left))
    {
        direccion = "izquierda";
        face = LEFT;

        var _max_slope = 4;

        if (!place_meeting(x - velocidad, y, colision))
        {
            x -= velocidad;
            movimiento = true;
        }
        else
        {
            var _sloped = false;
            
            // 1. Intentar subir
            for (var _i = 1; _i <= _max_slope; _i++)
            {
                if (!place_meeting(x - velocidad, y - _i, colision))
                {
                    y -= _i; 
                    x -= velocidad; 
                    movimiento = true;
                    _sloped = true;
                    break;
                }
            }
            
            // 2. Intentar bajar
            if (!_sloped)
            {
                for (var _i = 1; _i <= _max_slope; _i++)
                {
                    if (!place_meeting(x - velocidad, y + _i, colision))
                    {
                        y += _i; 
                        x -= velocidad; 
                        movimiento = true;
                        _sloped = true;
                        break;
                    }
                }
            }
        }
    }

    // Arriba
    if (keyboard_check(vk_up))
    {
        direccion = "arriba";
        face = UP;

        if (!place_meeting(x, y - velocidad, colision))
        {
            y -= velocidad;
            movimiento = true;
        }
    }

    // Abajo
    if (keyboard_check(vk_down))
    {
        direccion = "abajo";
        face = DOWN;

        if (!place_meeting(x, y + velocidad, colision))
        {
            y += velocidad;
            movimiento = true;
        }
    }
}

// Aplicar dirección del warp
switch(face)
{
    case RIGHT:
        direccion = "derecha";
        break;

    case LEFT:
        direccion = "izquierda";
        break;

    case UP:
        direccion = "arriba";
        break;

    case DOWN:
        direccion = "abajo";
        break;
}

// Cambiar sprite
switch (direccion)
{
    case "derecha":
        sprite_index = pendejo_derecha;
        break;

    case "izquierda":
        sprite_index = pendejo_izquierda;
        break;

    case "arriba":
        sprite_index = pendejo_arriba;
        break;

    case "abajo":
        sprite_index = pendejo_abajo;
        break;
}

// Quieto
if (!movimiento)
{
    image_index = 0;
}

// Keep track of direction facing
if (sprite_index == pendejo_abajo) {
    facing_direction = 2;
}
if (sprite_index == pendejo_arriba) {
    facing_direction = 3;
}
if (sprite_index == pendejo_derecha) {
    facing_direction = 0;
}
if (sprite_index == pendejo_izquierda) {
    facing_direction = 1;
}