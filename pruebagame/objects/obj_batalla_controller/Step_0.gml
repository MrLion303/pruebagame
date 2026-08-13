var _accept_key = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter);

switch (fase_actual) {
    case FASE_BATALLA.INICIO:
        if (!instance_exists(obj_batalla_ui)) {
            instance_create_layer(x, y, layer, obj_batalla_ui);
        }
        fase_actual = FASE_BATALLA.JUGADOR_MENU;
        break;
        
    case FASE_BATALLA.JUGADOR_MENU:
        var _todos_muertos = true;
        for (var i = 0; i < array_length(enemigos); i++) {
            if (enemigos[i].vida_actual > 0) {
                _todos_muertos = false;
                break;
            }
        }
        
        if (_todos_muertos) {
            fase_actual = FASE_BATALLA.VICTORIA;
        }
        break;
        
    case FASE_BATALLA.ENEMIGO_TURNO:
        var _total_en = array_length(enemigos);
        while (turno_enemigo_idx < _total_en && enemigos[turno_enemigo_idx].vida_actual <= 0) {
            turno_enemigo_idx++;
        }
        
        if (turno_enemigo_idx >= _total_en) {
            turno_enemigo_idx = 0;
            fase_actual = FASE_BATALLA.JUGADOR_MENU;
            
            if (instance_exists(obj_batalla_ui)) {
                obj_batalla_ui.en_resultado_ataque = false;
                obj_batalla_ui.text_to_draw = obj_batalla_ui.texto_inicio_batalla;
                obj_batalla_ui.text_length = string_length(obj_batalla_ui.text_to_draw);
                obj_batalla_ui.draw_char = 0;
                obj_batalla_ui.setup = false;
            }
            break;
        }
        
        var _en_actual = enemigos[turno_enemigo_idx];
        var _dano_enemigo = irandom_range(5, 12);
        if (instance_exists(obj_player)) {
            obj_player.hp -= _dano_enemigo;
            if (obj_player.hp < 0) obj_player.hp = 0;
        }
        
        if (audio_is_playing(snd_atacado)) {
            audio_stop_sound(snd_atacado);
        }
        audio_play_sound(snd_atacado, 10, false);
        
        if (instance_exists(obj_batalla_ui)) {
            obj_batalla_ui.en_resultado_ataque = true;
            obj_batalla_ui.text_to_draw = _en_actual.nombre + " ataca y te causa " + string(_dano_enemigo) + " de daño!";
            obj_batalla_ui.text_length = string_length(obj_batalla_ui.text_to_draw);
            obj_batalla_ui.draw_char = 0;
            obj_batalla_ui.setup = false;
        }
        
        fase_actual = FASE_BATALLA.ENEMIGO_ATACANDO;
        break;
        
    case FASE_BATALLA.ENEMIGO_ATACANDO:
        if (instance_exists(obj_batalla_ui)) {
            if (obj_batalla_ui.draw_char >= obj_batalla_ui.text_length) {
                if (_accept_key) {
                    turno_enemigo_idx++;
                    fase_actual = FASE_BATALLA.ENEMIGO_TURNO;
                }
            }
        }
        break;
        
    case FASE_BATALLA.VICTORIA:
        // Creamos la transición de salida limpia hacia el mapa guardado
        if (!instance_exists(obj_transicion_salida_bbs)) {
            if (audio_exists(musica_batalla_actual)) {
                audio_stop_sound(musica_batalla_actual);
            }
            instance_create_layer(x, y, layer, obj_transicion_salida_bbs);
        } else {
            instance_destroy();
        }
        break;
        
    case FASE_BATALLA.HUIR:
        if (!instance_exists(obj_transicion_salida_bbs)) {
            if (audio_exists(musica_batalla_actual)) {
                audio_stop_sound(musica_batalla_actual);
            }
            instance_create_layer(x, y, layer, obj_transicion_salida_bbs);
        } else {
            instance_destroy();
        }
        break;
        
    case FASE_BATALLA.DERROTA:
        break;
}