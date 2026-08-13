// ==========================================
// EVENTO: CREAR (CREATE)
// ==========================================
opcion_seleccionada = 0; 
opciones = [spr_bbs_fight, spr_bbs_item, spr_bbs_toy, spr_bbs_huir];

en_menu_fight = false;
en_seleccion_enemigo = false; 
enemigo_seleccionado_idx = 0; 
opcion_fight_seleccionada = 0; 
en_modo_info = false; 

// NUEVAS VARIABLES DE INVENTARIO EN BATALLA
en_menu_inventario = false;
inv_x = 0;
inv_y = 0;
inv_scroll = 0;
en_item_resultado = false;

ui_x_caja_izq = 30;
ui_y_caja_izq = 640;
ui_x_caja_der = 420;
ui_y_caja_der = 640;

audio_pause_all();

if (!variable_global_exists("enemigo_actual_id")) {
    global.enemigo_actual_id = "variante 1"; 
}

var _datos_variante = scr_enemigos_data(global.enemigo_actual_id);
enemigos = _datos_variante.enemigos;
musica_batalla_actual = _datos_variante.musica;

if (audio_exists(musica_batalla_actual)) {
    var _snd_batalla = audio_play_sound(musica_batalla_actual, 10, true);
    audio_resume_sound(_snd_batalla);
}

texto_inicio_batalla = (array_length(enemigos) > 0) ? enemigos[0].texto_inicio : "Un combate comienza!";
text_to_draw = texto_inicio_batalla;
text_to_draw = string_replace_all(text_to_draw, "\n", " ");
text_to_draw = string_replace_all(text_to_draw, "\r", " ");

text_length = string_length(text_to_draw);
draw_char = 0;
text_spd = 1;

setup = false;
text_sound_timer = 0;
text_sound_delay = 2;
line_break_num = 0;