// ==========================================
// EVENTO: PASO (STEP) - COMPLETO
// ==========================================
accept_key = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter);
skip_key = keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift) || keyboard_check_pressed(vk_control);
var _fast_skip_key = keyboard_check(ord("C")) || keyboard_check_pressed(vk_control);

// Control de animación manual para el sprite del enemigo si sigue vivo
if (variable_struct_exists(enemigo, "derrotado") && enemigo.derrotado) {
    enemigo.anim_index = 0; 
} else {
    if (variable_struct_exists(enemigo, "anim_index")) {
        enemigo.anim_index += 0.15; 
    }
}

// --- SI EL ENEMIGO YA FUE DERROTADO Y ESTÁ MOSTRANDO EL TEXTO DE MUERTE ---
if (variable_struct_exists(enemigo, "derrotado") && enemigo.derrotado) {
    if (draw_char < text_length) {
        var _actual_speed = _fast_skip_key ? 999 : text_spd;
        draw_char += _actual_speed;
        draw_char = clamp(draw_char, 0, text_length);
        if (skip_key || _fast_skip_key || accept_key) { draw_char = text_length; }
    } else {
        if (accept_key) {
            if (variable_struct_exists(enemigo, "musica")) audio_stop_sound(enemigo.musica);
            if (audio_is_playing(snd_bbs_start)) audio_stop_sound(snd_bbs_start);
            
            audio_resume_all();
            
            if (variable_global_exists("return_room")) room_goto(global.return_room);
            else room_goto(pasillo_school);
            instance_destroy();
        }
    }
    exit; 
}

if (!en_menu_fight) {
    if (keyboard_check_pressed(vk_right)) { opcion_seleccionada++; if (opcion_seleccionada > 3) opcion_seleccionada = 0; audio_play_sound(snd_menumove, 10, false); }
    if (keyboard_check_pressed(vk_left)) { opcion_seleccionada--; if (opcion_seleccionada < 0) opcion_seleccionada = 3; audio_play_sound(snd_menumove, 10, false); }
} else if (!en_modo_info) {
    if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_down)) { opcion_fight_seleccionada++; if (opcion_fight_seleccionada > 1) opcion_fight_seleccionada = 0; audio_play_sound(snd_menumove, 10, false); }
    if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_up)) { opcion_fight_seleccionada--; if (opcion_fight_seleccionada < 0) opcion_fight_seleccionada = 1; audio_play_sound(snd_menumove, 10, false); }
}

if (draw_char < text_length) {
    var _actual_speed = _fast_skip_key ? 999 : text_spd;
    draw_char += _actual_speed;
    draw_char = clamp(draw_char, 0, text_length);
    if (skip_key || _fast_skip_key) { draw_char = text_length; }
} else {
    if (accept_key) {
        if (!en_menu_fight) {
            if (opcion_seleccionada == 0) { 
                en_menu_fight = true; 
                en_modo_info = false;
                opcion_fight_seleccionada = 0; 
                audio_play_sound(snd_menumove, 10, false); 
            }
            else if (opcion_seleccionada == 3) {
                if (variable_struct_exists(enemigo, "musica")) audio_stop_sound(enemigo.musica);
                if (audio_is_playing(snd_bbs_start)) audio_stop_sound(snd_bbs_start);
                
                audio_resume_all();
                audio_play_sound(snd_board_escaped, 10, false); 
                
                if (variable_global_exists("return_room")) room_goto(global.return_room);
                else room_goto(pasillo_school);
                instance_destroy();
            }
        } else if (en_modo_info) {
            en_modo_info = false;
            en_menu_fight = false;
            text_to_draw = string_replace_all(enemigo.texto_inicio, "\n", " ");
            text_length = string_length(text_to_draw);
            draw_char = 0;
            setup = false;
            audio_play_sound(snd_menumove, 10, false);
        } else {
            if (opcion_fight_seleccionada == 0) { 
                
                var _atk_base_puntos = 0;
                
                if (instance_exists(obj_player)) {
                    _atk_base_puntos = obj_player.ataque_base;
                    
                    if (variable_global_exists("equip_db")) {
                        if (is_struct(obj_player.equipo_arma)) {
                            if (variable_struct_exists(obj_player.equipo_arma, "ataque")) {
                                _atk_base_puntos += obj_player.equipo_arma.ataque;
                            }
                        } else if (obj_player.equipo_arma != -1) {
                            var _arma_data = global.equip_db[$ obj_player.equipo_arma];
                            if (_arma_data != undefined && struct_exists(_arma_data, "ataque")) {
                                _atk_base_puntos += _arma_data.ataque;
                            }
                        }
                    }
                }
                
                var _dano = 10 + (_atk_base_puntos * 2);
                
                enemigo.vida_actual -= _dano;
                
                if (enemigo.vida_actual <= 0) {
                    enemigo.vida_actual = 0;
                    enemigo.derrotado = true; 
                    
                    // Detenemos la música de batalla y reproducimos el sonido de muerte del enemigo
                    if (variable_struct_exists(enemigo, "musica")) {
                        audio_stop_sound(enemigo.musica);
                    }
                    audio_play_sound(snd_enemy_killed, 10, false); // <-- SONIDO AÑADIDO
                    
                    if (variable_struct_exists(enemigo, "texto_muerte")) {
                        text_to_draw = string_replace_all(enemigo.texto_muerte, "\n", " ");
                    } else {
                        text_to_draw = "¡Venciste a " + enemigo.nombre + "!";
                    }
                } else {
                    text_to_draw = "¡Hiciste " + string(_dano) + " de dano!";
                }
                
                text_length = string_length(text_to_draw);
                draw_char = 0;
                setup = false;
                en_menu_fight = false;
                audio_play_sound(snd_menumove, 10, false);
            }
            else { 
                en_modo_info = true;
                text_to_draw = string_replace_all(enemigo.descripcion, "\n", " ");
                text_length = string_length(text_to_draw);
                draw_char = 0;
                setup = false; 
                audio_play_sound(snd_menumove, 10, false);
            }
        }
    }
    if (skip_key) {
        if (en_modo_info) {
            en_modo_info = false;
            en_menu_fight = false;
            text_to_draw = string_replace_all(enemigo.texto_inicio, "\n", " ");
            text_length = string_length(text_to_draw);
            draw_char = 0;
            setup = false;
            audio_play_sound(snd_menumove, 10, false);
        } else if (en_menu_fight) {
            en_menu_fight = false;
            audio_play_sound(snd_menumove, 10, false);
        }
    }
}