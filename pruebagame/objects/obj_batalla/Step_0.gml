var _p = instance_place(x, y, obj_player);

if (_p != noone) {
    // Verificar que no exista ya una transicion corriendo para evitar bucles
    if (!instance_exists(obj_transision_bbs)) {
        
        // Disparamos el sonido al iniciar la transicion
        audio_play_sound(snd_bbs_start, 10, false);
        
        // Creamos la transicion
        instance_create_layer(0, 0, layer, obj_transision_bbs);
        
        instance_destroy(); // Destruir el trigger de batalla para que no se repita
    }
}