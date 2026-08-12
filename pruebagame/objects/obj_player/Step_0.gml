// Reiniciar movimiento
movimiento = false;

// Comprobación segura del estado del menú
var _menu_abierto = false;
if (instance_exists(obj_menu_manager)) {
    if (obj_menu_manager.state != MENU_STATE.CLOSED) {
        _menu_abierto = true;
    }
}

// Si NO existe el pauser, Y TAMPOCO la caja de diálogo, Y EL MENÚ ESTÁ CERRADO, permitir movimiento
if (!instance_exists(obj_pauser) && !instance_exists(obj_textbox) && !_menu_abierto)
{
    // Lógica exacta de Auto-correr (Velocidad base 6, baja a 4 al presionar X o Shift solo si está activo)
    var _vel = 4;
    var _auto_run_active = (variable_global_exists("autocorrer_enabled") && global.autocorrer_enabled);
    var _tecla_lenta = (keyboard_check(ord("X")) || keyboard_check(vk_shift));
    
    if (_auto_run_active)
    {
        if (_tecla_lenta)
        {
            _vel = 4; // Baja a 4 al mantener X o Shift porque el auto-correr está encendido
        }
        else
        {
            _vel = 6; // Corre por defecto a 6
        }
    }
    else
    {
        if (_tecla_lenta)
        {
            _vel = 6; // Si está apagado, la X o Shift sirve para correr a 6
        }
        else
        {
            _vel = 4; // Camina por defecto a 4
        }
    }

    // Derecha (Subida y bajada automática adaptada a la velocidad actual)
    if (keyboard_check(vk_right))
    {
        direccion = "derecha";
        face = RIGHT;

        var _max_slope = _vel; 

        if (!place_meeting(x + _vel, y, colision))
        {
            x += _vel;
            movimiento = true;
        }
        else
        {
            var _sloped = false;
            
            // 1. Intentar subir
            for (var _i = 1; _i <= _max_slope; _i++)
            {
                if (!place_meeting(x + _vel, y - _i, colision))
                {
                    y -= _i; 
                    x += _vel; 
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
                    if (!place_meeting(x + _vel, y + _i, colision))
                    {
                        y += _i; 
                        x += _vel; 
                        movimiento = true;
                        _sloped = true;
                        break;
                    }
                }
            }
        }
    }

    // Izquierda (Subida y bajada automática adaptada a la velocidad actual)
    if (keyboard_check(vk_left))
    {
        direccion = "izquierda";
        face = LEFT;

        var _max_slope = _vel;

        if (!place_meeting(x - _vel, y, colision))
        {
            x -= _vel;
            movimiento = true;
        }
        else
        {
            var _sloped = false;
            
            // 1. Intentar subir
            for (var _i = 1; _i <= _max_slope; _i++)
            {
                if (!place_meeting(x - _vel, y - _i, colision))
                {
                    y -= _i; 
                    x -= _vel; 
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
                    if (!place_meeting(x - _vel, y + _i, colision))
                    {
                        y += _i; 
                        x -= _vel; 
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

        if (!place_meeting(x, y - _vel, colision))
        {
            y -= _vel;
            movimiento = true;
        }
    }

    // Abajo
    if (keyboard_check(vk_down))
    {
        direccion = "abajo";
        face = DOWN;

        if (!place_meeting(x, y + _vel, colision))
        {
            y += _vel;
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