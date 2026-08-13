var _accept_key = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter);

switch (fase_actual) {
    case FASE_BATALLA.INICIO:
        if (!instance_exists(obj_batalla_ui)) {
            instance_create_layer(x, y, layer, obj_batalla_ui);
        }
        fase_actual = FASE_BATALLA.JUGADOR_MENU;
        break;
        
    case FASE_BATALLA.JUGADOR_MENU:
        // Verificamos si todos los enemigos murieron para declarar victoria
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
        // Buscamos el siguiente enemigo que siga vivo para que ataque
        var _total_en = array_length(enemigos);
        
        while (turno_enemigo_idx < _total_en && enemigos[turno_enemigo_idx].vida_actual <= 0) {
            turno_enemigo_idx++;
        }
        
        // Si ya atacaron todos los enemigos vivos, regresamos el turno al jugador
        if (turno_enemigo_idx >= _total_en) {
            turno_enemigo_idx = 0;
            fase_actual = FASE_BATALLA.JUGADOR_MENU;
            
            // Le devolvemos el texto por defecto a la UI del jugador
            if (instance_exists(obj_batalla_ui)) {
                obj_batalla_ui.en_resultado_ataque = false;
                obj_batalla_ui.text_to_draw = obj_batalla_ui.texto_inicio_batalla;
                obj_batalla_ui.text_length = string_length(obj_batalla_ui.text_to_draw);
                obj_batalla_ui.draw_char = 0;
                obj_batalla_ui.setup = false;
            }
            break;
        }
        
        // Obtenemos los datos del enemigo actual que va a golpear
        var _en_actual = enemigos[turno_enemigo_idx];
        
        // Calculamos el daño
        var _dano_enemigo = irandom_range(5, 12); 
        if (instance_exists(obj_player)) {
            obj_player.hp -= _dano_enemigo;
            if (obj_player.hp < 0) obj_player.hp = 0;
        }
        
        // Reproducir sonido de impacto al recibir daño
        if (audio_is_playing(snd_atacado)) {
            audio_stop_sound(snd_atacado);
        }
        audio_play_sound(snd_atacado, 10, false);
        
        // Mandamos el mensaje de ataque a la UI de batalla
        if (instance_exists(obj_batalla_ui)) {
            obj_batalla_ui.en_resultado_ataque = true;
            obj_batalla_ui.text_to_draw = _en_actual.nombre + " ataca y te causa " + string(_dano_enemigo) + " de daño!";
            obj_batalla_ui.text_length = string_length(obj_batalla_ui.text_to_draw);
            obj_batalla_ui.draw_char = 0;
            obj_batalla_ui.setup = false;
        }
        
        // Cambiamos a estado de espera hasta que el jugador presione Z
        fase_actual = FASE_BATALLA.ENEMIGO_ATACANDO;
        break;
        
    case FASE_BATALLA.ENEMIGO_ATACANDO:
        // Esperamos a que el texto termine de escribirse y el usuario presione Z para continuar
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
        // Detenemos cualquier texto de la UI para que no interfiera
        if (instance_exists(obj_batalla_ui)) {
            obj_batalla_ui.en_resultado_ataque = false;
        }

        // Creamos la transición de salida una sola vez
        if (!instance_exists(obj_transicion_salida_bbs)) {
            if (audio_exists(musica_batalla_actual)) {
                audio_stop_sound(musica_batalla_actual);
            }
            instance_create_layer(x, y, layer, obj_transicion_salida_bbs);
        }
        
        // No hacemos un room_goto aquí; dejamos que la transición maneje todo en su Animation End
        break;
        
    case FASE_BATALLA.DERROTA:
        break;
}