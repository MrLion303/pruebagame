accept_key = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter);
skip_key = keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift) || keyboard_check_pressed(vk_control);
var _fast_skip_key = keyboard_check(ord("C")) || keyboard_check_pressed(vk_control);

// Control de Fade Out si la batalla termina (Victoria o Huir)
if (instance_exists(obj_batalla_controller)) {
    if (obj_batalla_controller.fase_actual == FASE_BATALLA.VICTORIA || obj_batalla_controller.fase_actual == FASE_BATALLA.HUIR) {
        fade_salida_activa = true;
    }
}

if (fade_salida_activa) {
    alpha_salida -= 0.05;
    if (alpha_salida <= 0) {
        alpha_salida = 0;
        instance_destroy();
        exit;
    }
}

if (!variable_instance_exists(id, "en_resultado_ataque")) {
    en_resultado_ataque = false;
}

// 1. Logica de animacion de derrota y temblor (shake)
for (var i = 0; i < array_length(enemigos); i++) {
    if (!variable_struct_exists(enemigos[i], "shake_timer")) enemigos[i].shake_timer = 0;
    if (enemigos[i].shake_timer > 0) enemigos[i].shake_timer--;
    
    if (variable_struct_exists(enemigos[i], "derrotado") && enemigos[i].derrotado) {
        enemigos[i].anim_index = 0;
    } else {
        if (!variable_struct_exists(enemigos[i], "anim_index")) enemigos[i].anim_index = 0;
        enemigos[i].anim_index += 0.15;
    }
}

// 2. Comprobacion de fin de batalla
var _todos_derrotados = true;
for (var i = 0; i < array_length(enemigos); i++) {
    if (!variable_struct_exists(enemigos[i], "derrotado") || !enemigos[i].derrotado) {
        _todos_derrotados = false;
        break;
    }
}

if (_todos_derrotados) {
    // Silenciamos la música de batalla al instante de ganar
    if (variable_instance_exists(id, "musica_batalla_actual") && audio_exists(musica_batalla_actual)) {
        if (audio_is_playing(musica_batalla_actual)) {
            audio_stop_sound(musica_batalla_actual);
        }
    }

    if (draw_char < text_length) {
        var _actual_speed = _fast_skip_key ? 999 : text_spd;
        draw_char += _actual_speed;
        draw_char = clamp(draw_char, 0, text_length);
        if (skip_key || _fast_skip_key || accept_key) {
            draw_char = text_length;
        }
    } else {
        if (accept_key) {
            audio_resume_all();
            if (instance_exists(obj_batalla_controller)) {
                obj_batalla_controller.fase_actual = FASE_BATALLA.VICTORIA;
            }
        }
    }
    exit;
}

// 3. Logica de menús
if (!en_resultado_ataque) {
    if (en_menu_inventario) {
        if (keyboard_check_pressed(vk_right)) {
            inv_x = (inv_x + 1) % 2;
            audio_play_sound(snd_menumove, 10, false);
        }
        if (keyboard_check_pressed(vk_left)) {
            inv_x = (inv_x - 1 + 2) % 2;
            audio_play_sound(snd_menumove, 10, false);
        }
        if (keyboard_check_pressed(vk_down)) {
            var _total_items = (instance_exists(obj_player) && variable_instance_exists(obj_player, "inventory")) ? array_length(obj_player.inventory) : 0;
            var _filas_totales = ceil(_total_items / 2);
            var _max_scroll = max(0, _filas_totales - 2);
            inv_y++;
            if (inv_y > 1) {
                inv_y = 1;
                if (inv_scroll < _max_scroll) {
                    inv_scroll++;
                }
            }
            audio_play_sound(snd_menumove, 10, false);
        }
        if (keyboard_check_pressed(vk_up)) {
            inv_y--;
            if (inv_y < 0) {
                inv_y = 0;
                if (inv_scroll > 0) inv_scroll--;
            }
            audio_play_sound(snd_menumove, 10, false);
        }
        if (skip_key) {
            en_menu_inventario = false;
            audio_play_sound(snd_menumove, 10, false);
        }
    } else if (!en_menu_fight && !en_seleccion_enemigo) {
        if (keyboard_check_pressed(vk_right)) {
            opcion_seleccionada++;
            if (opcion_seleccionada > 3) opcion_seleccionada = 0;
            audio_play_sound(snd_menumove, 10, false);
        }
        if (keyboard_check_pressed(vk_left)) {
            opcion_seleccionada--;
            if (opcion_seleccionada < 0) opcion_seleccionada = 3;
            audio_play_sound(snd_menumove, 10, false);
        }
    } else if (en_seleccion_enemigo) {
        var _total_en = array_length(enemigos);
        if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_down)) {
            enemigo_seleccionado_idx = (enemigo_seleccionado_idx + 1) % _total_en;
            var _inicio = enemigo_seleccionado_idx;
            while (variable_struct_exists(enemigos[enemigo_seleccionado_idx], "derrotado") && enemigos[enemigo_seleccionado_idx].derrotado) {
                enemigo_seleccionado_idx = (enemigo_seleccionado_idx + 1) % _total_en;
                if (enemigo_seleccionado_idx == _inicio) break;
            }
            audio_play_sound(snd_menumove, 10, false);
        }
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_up)) {
            enemigo_seleccionado_idx--;
            if (enemigo_seleccionado_idx < 0) enemigo_seleccionado_idx = _total_en - 1;
            var _inicio = enemigo_seleccionado_idx;
            while (variable_struct_exists(enemigos[enemigo_seleccionado_idx], "derrotado") && enemigos[enemigo_seleccionado_idx].derrotado) {
                enemigo_seleccionado_idx--;
                if (enemigo_seleccionado_idx < 0) enemigo_seleccionado_idx = _total_en - 1;
                if (enemigo_seleccionado_idx == _inicio) break;
            }
            audio_play_sound(snd_menumove, 10, false);
        }
    } else if (!en_modo_info) {
        if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_down)) {
            opcion_fight_seleccionada++;
            if (opcion_fight_seleccionada > 1) opcion_fight_seleccionada = 0;
            audio_play_sound(snd_menumove, 10, false);
        }
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_up)) {
            opcion_fight_seleccionada--;
            if (opcion_fight_seleccionada < 0) opcion_fight_seleccionada = 1;
            audio_play_sound(snd_menumove, 10, false);
        }
    }
}

// 4. Logica de texto y selección
if (draw_char < text_length) {
    var _actual_speed = _fast_skip_key ? 999 : text_spd;
    draw_char += _actual_speed;
    draw_char = clamp(draw_char, 0, text_length);
    if (skip_key || _fast_skip_key) {
        draw_char = text_length;
    }
} else {
    if (accept_key) {
        if (en_menu_inventario) {
            if (instance_exists(obj_player) && variable_instance_exists(obj_player, "inventory")) {
                var _inv_index = inv_x + (inv_y * 2) + (inv_scroll * 2);
                if (_inv_index < array_length(obj_player.inventory)) {
                    var _item_key = obj_player.inventory[_inv_index];
                    if (_item_key != -1 && _item_key != undefined) {
                        if (variable_global_exists("item_db")) {
                            var _item_data = global.item_db[$ _item_key];
                            if (_item_data != undefined) {
                                var _es_consumible = variable_struct_exists(_item_data, "tipo") ? (_item_data.tipo == "consumible") : true;
                                if (_es_consumible) {
                                    var _hp_antes = 0;
                                    if (instance_exists(obj_player)) {
                                        _hp_antes = obj_player.hp;
                                    }
                                    if (variable_struct_exists(_item_data, "efecto")) {
                                        _item_data.efecto();
                                    }
                                    var _hp_curado = 0;
                                    if (instance_exists(obj_player)) {
                                        _hp_curado = obj_player.hp - _hp_antes;
                                    }
                                    obj_player.inventory[_inv_index] = -1;
                                    if (_hp_curado > 0) {
                                        text_to_draw = "Consumiste " + _item_data.nombre + "! Te curaste " + string(_hp_curado) + " de vida!";
                                    } else if (instance_exists(obj_player) && _hp_antes >= obj_player.hp_max) {
                                        text_to_draw = "Consumiste " + _item_data.nombre + ", pero ya tienes la vida llena!";
                                    } else {
                                        text_to_draw = "Consumiste " + _item_data.nombre + "!";
                                    }
                                    en_resultado_ataque = true;
                                    en_menu_inventario = false;
                                    text_length = string_length(text_to_draw);
                                    draw_char = 0;
                                    setup = false;
                                    audio_play_sound(snd_menumove, 10, false);
                                }
                            }
                        }
                    }
                }
            }
        } else if (en_resultado_ataque) {
            en_resultado_ataque = false;
            en_menu_fight = false;
            en_seleccion_enemigo = false;
            en_modo_info = false;
            opcion_seleccionada = 0;
            text_to_draw = texto_inicio_batalla;
            text_length = string_length(text_to_draw);
            draw_char = 0;
            setup = false;
            audio_play_sound(snd_menumove, 10, false);
            
            if (instance_exists(obj_batalla_controller)) {
                obj_batalla_controller.fase_actual = FASE_BATALLA.ENEMIGO_TURNO;
            }
        } else if (!en_menu_fight && !en_seleccion_enemigo) {
            if (opcion_seleccionada == 0) {
                en_seleccion_enemigo = true;
                for (var i = 0; i < array_length(enemigos); i++) {
                    if (!variable_struct_exists(enemigos[i], "derrotado") || !enemigos[i].derrotado) {
                        enemigo_seleccionado_idx = i;
                        break;
                    }
                }
                audio_play_sound(snd_menumove, 10, false);
            } else if (opcion_seleccionada == 1) {
                en_menu_inventario = true;
                inv_x = 0;
                inv_y = 0;
                inv_scroll = 0;
                audio_play_sound(snd_menumove, 10, false);
            } else if (opcion_seleccionada == 3) {
                audio_resume_all();
                audio_play_sound(snd_board_escaped, 10, false);
                if (instance_exists(obj_batalla_controller)) {
                    obj_batalla_controller.fase_actual = FASE_BATALLA.HUIR;
                }
            }
        } else if (en_seleccion_enemigo) {
            var _en_sel = enemigos[enemigo_seleccionado_idx];
            if (variable_struct_exists(_en_sel, "derrotado") && _en_sel.derrotado) {
                if (audio_is_playing(snd_error)) audio_stop_sound(snd_error);
                audio_play_sound(snd_error, 10, false);
            } else {
                en_seleccion_enemigo = false;
                en_menu_fight = true;
                en_modo_info = false;
                opcion_fight_seleccionada = 0;
                audio_play_sound(snd_menumove, 10, false);
            }
        } else if (en_modo_info) {
            en_modo_info = false;
            en_menu_fight = false;
            text_to_draw = texto_inicio_batalla;
            text_length = string_length(text_to_draw);
            draw_char = 0;
            setup = false;
            audio_play_sound(snd_menumove, 10, false);
        } else {
            var _en_actual = enemigos[enemigo_seleccionado_idx];
            if (opcion_fight_seleccionada == 0) {
                var _atk_base_puntos = 0;
                if (instance_exists(obj_player)) {
                    _atk_base_puntos = obj_player.ataque_base;
                    if (variable_global_exists("equip_db")) {
                        if (is_struct(obj_player.equipo_arma)) {
                            if (variable_struct_exists(obj_player.equipo_arma, "ataque")) _atk_base_puntos += obj_player.equipo_arma.ataque;
                        } else if (obj_player.equipo_arma != -1) {
                            var _arma_data = global.equip_db[$ obj_player.equipo_arma];
                            if (_arma_data != undefined && struct_exists(_arma_data, "ataque")) _atk_base_puntos += _arma_data.ataque;
                        }
                    }
                }
                
                var _dano = 10 + (_atk_base_puntos * 2);
                _en_actual.vida_actual -= _dano;
                _en_actual.shake_timer = 15;
                
                if (audio_is_playing(snd_shake)) audio_stop_sound(snd_shake);
                audio_play_sound(snd_shake, 10, false);
                
                if (_en_actual.vida_actual <= 0) {
                    _en_actual.vida_actual = 0;
                    _en_actual.derrotado = true;
                    audio_play_sound(snd_enemy_killed, 10, false);
                    if (variable_struct_exists(_en_actual, "texto_muerte")) text_to_draw = string_replace_all(_en_actual.texto_muerte, "\n", " ");
                    else text_to_draw = "Venciste a " + _en_actual.nombre + "!";
                } else {
                    text_to_draw = "Hiciste " + string(_dano) + " de daño a " + _en_actual.nombre + "!";
                }
                
                en_resultado_ataque = true;
                en_menu_fight = false;
                en_seleccion_enemigo = false;
                en_modo_info = false;
                text_length = string_length(text_to_draw);
                draw_char = 0;
                setup = false;
                audio_play_sound(snd_menumove, 10, false);
            } else {
                en_modo_info = true;
                text_to_draw = string_replace_all(_en_actual.descripcion, "\n", " ");
                text_length = string_length(text_to_draw);
                draw_char = 0;
                setup = false;
                audio_play_sound(snd_menumove, 10, false);
            }
        }
    }
}

if (skip_key && !en_resultado_ataque) {
    if (en_menu_inventario) {
        en_menu_inventario = false;
        audio_play_sound(snd_menumove, 10, false);
    } else if (en_modo_info) {
        en_modo_info = false;
        en_menu_fight = false;
        text_to_draw = texto_inicio_batalla;
        text_length = string_length(text_to_draw);
        draw_char = 0;
        setup = false;
        audio_play_sound(snd_menumove, 10, false);
    } else if (en_menu_fight) {
        en_menu_fight = false;
        en_seleccion_enemigo = true;
        audio_play_sound(snd_menumove, 10, false);
    } else if (en_seleccion_enemigo) {
        en_seleccion_enemigo = false;
        audio_play_sound(snd_menumove, 10, false);
    }
}