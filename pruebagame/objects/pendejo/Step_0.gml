// Reiniciar movimiento
movimiento = false;

// Correr
if (keyboard_check(ord("X")))
{
    velocidad = 5;
}
else
{
    velocidad = 4;
}

// Derecha
if (keyboard_check(vk_right))
{
    direccion = "derecha";

    if (!place_meeting(x + velocidad, y, colision))
    {
        x += velocidad;
        movimiento = true;
    }
}

// Izquierda
if (keyboard_check(vk_left))
{
    direccion = "izquierda";

    if (!place_meeting(x - velocidad, y, colision))
    {
        x -= velocidad;
        movimiento = true;
    }
}

// Arriba
if (keyboard_check(vk_up))
{
    direccion = "arriba";

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

    if (!place_meeting(x, y + velocidad, colision))
    {
        y += velocidad;
        movimiento = true;
    }
}

// Cambiar sprite
if (movimiento)
{
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
}
else
{
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

    image_index = 0;
}