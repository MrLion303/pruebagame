// ==========================================
// EVENTO: CREAR (CREATE)
// ==========================================
opcion_seleccionada = 0; 
opciones = [spr_bbs_fight, spr_bbs_item, spr_bbs_toy, spr_bbs_huir];

en_menu_fight = false;
opcion_fight_seleccionada = 0;
en_modo_info = false; 

ui_x_caja_izq = 30;
ui_y_caja_izq = 640;
ui_x_caja_der = 420;
ui_y_caja_der = 640;

audio_pause_all();

if (!variable_global_exists("enemigo_actual_id")) {
    global.enemigo_actual_id = "toby"; 
}
enemigo = scr_enemigos_data(global.enemigo_actual_id);

if (variable_struct_exists(enemigo, "musica") && audio_exists(enemigo.musica)) {
    var _snd_batalla = audio_play_sound(enemigo.musica, 10, true);
    audio_resume_sound(_snd_batalla);
}

text_to_draw = string_replace_all(enemigo.texto_inicio, "\n", " ");
text_to_draw = string_replace_all(text_to_draw, "\r", " ");
text_to_draw = string_replace_all(text_to_draw, chr(10), " ");
text_to_draw = string_replace_all(text_to_draw, chr(13), " ");

text_length = string_length(text_to_draw);
draw_char = 0;
text_spd = 1;

setup = false;
text_sound_timer = 0;
text_sound_delay = 2;
line_break_num = 0;