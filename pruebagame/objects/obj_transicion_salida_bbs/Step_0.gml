// ==========================================
// TRANSICIÓN DE SALIDA DE BATALLA
// ==========================================

var _ultimo_frame = sprite_get_number(sprite_index) - 1;


// ==========================================
// CERRAR LA PANTALLA EN LA BATALLA
// ==========================================

if (image_speed > 0 && !fase_salida)
{
    if (image_index >= _ultimo_frame)
    {
        fase_salida = true;
        
        // Asegurarnos de que la pantalla esté completamente cerrada
        image_index = _ultimo_frame;
        
        // ==========================================
        // GUARDAR LA REFERENCIA DE LA ROOM
        // ==========================================
        
        var _room_destino;
        
        if (variable_global_exists("return_room"))
        {
            _room_destino = global.return_room;
        }
        else
        {
            _room_destino = pasillo_school;
        }
        
        // ==========================================
        // REGRESAR AL MAPA
        // ==========================================
        
        room_goto(_room_destino);
        
        // ==========================================
        // PREPARAR EL FADE OUT
        // ==========================================
        
        image_speed = -0.5;
        image_index = _ultimo_frame;
    }
}


// ==========================================
// ABRIR LA PANTALLA EN EL MAPA
// ==========================================

if (fase_salida && image_speed < 0)
{
    if (image_index <= 0)
    {
        image_index = 0;
        
        // La transición terminó.
        // El jugador ya está en return_x / return_y.
        instance_destroy();
    }
}