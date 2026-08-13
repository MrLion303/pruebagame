// ==========================================
// EVENTO: DIBUJAR GUI (DRAW GUI) - COMPLETO
// ==========================================
var _s = 2;
if (!variable_instance_exists(id, "alpha_aparicion")) alpha_aparicion = 0.0;
if (alpha_aparicion < 1.0) alpha_aparicion += 0.05; 
var _fade_transicion = 1.0;
if (instance_exists(obj_transision_bbs)) { _fade_transicion = obj_transision_bbs.image_alpha; }
var _alpha_final = alpha_aparicion * _fade_transicion;

// --- POSICIÓN CORREGIDA SEGÚN TU CIRCULO ---
var _enemigo_x = (14 + 145) * _s; // Movido a la izquierda
var _enemigo_y = (65) * _s;        // Movido más abajo para que el centro coincida con el círculo

if (!variable_instance_exists(id, "enemigo_img_index")) { enemigo_img_index = 0; }

// --- CONTROL DE ANIMACIÓN Y OSCURECIMIENTO EXTREMO AL DERROTARLO ---
var _enemigo_derrotado = (variable_struct_exists(enemigo, "derrotado") && enemigo.derrotado);

if (_enemigo_derrotado) {
    enemigo_img_index = 0; 
    var _enemigo_color = make_color_rgb(40, 40, 40); 
} else {
    enemigo_img_index += 0.1; 
    var _enemigo_color = c_white; 
}

// Obtenemos la escala del struct
var _escala_enemigo = variable_struct_exists(enemigo, "escala_sprite") ? enemigo.escala_sprite : 2.0;

// Dibujamos con el origen centrado exactamente donde marcaste
draw_sprite_ext(enemigo.sprite, enemigo_img_index, _enemigo_x, _enemigo_y, _escala_enemigo * _s, _escala_enemigo * _s, 0, _enemigo_color, _alpha_final);

draw_sprite_ext(spr_bbs_textbox, 0, 14 * _s, 125 * _s, 5.666667 * _s, 1.0 * _s, 0, c_white, _alpha_final);
if (variable_global_exists("font_main")) { draw_set_font(global.font_main); }

var _p_left_margin = 16 * _s;
var _p_avail_width = (260 * _s); 

if (setup == false) {
    setup = true;
    text_length = string_length(text_to_draw);
    var _last_space = -1; var _line_start_char = 1; line_break_num = 0;
    for(var c = 1; c <= text_length; c++) {
        var _char_current = string_char_at(text_to_draw, c);
        if (_char_current == " ") _last_space = c;
        var _sub_str = string_copy(text_to_draw, _line_start_char, c - _line_start_char + 1);
        var _str_w = string_width(_sub_str);
        if (_str_w > _p_avail_width) {
            if (_last_space != -1 && _last_space >= _line_start_char) { line_break_pos[line_break_num] = _last_space + 1; line_break_num++; _line_start_char = _last_space + 1; _last_space = -1; }
            else { line_break_pos[line_break_num] = c; line_break_num++; _line_start_char = c; _last_space = -1; }
        }
    }
    for(var c = 0; c < text_length; c++) {
        var _char_pos = c + 1; char_array[c] = string_char_at(text_to_draw, _char_pos);
        var _txt_x = (14 * _s) + _p_left_margin; var _txt_y = (125 * _s) + (8 * _s) + (1 * _s);
        var _txt_line = 0; var _line_start_pos = 1;
        for(var lb = 0; lb < line_break_num; lb++) {
            if _char_pos >= line_break_pos[lb] { _txt_line = lb + 1; _line_start_pos = line_break_pos[lb]; }
        }
        if (_line_start_pos == _char_pos && char_array[c] == " ") { char_x[c] = -9999; char_y[c] = -9999; continue; }
        var _str_copy = string_copy(text_to_draw, _line_start_pos, _char_pos - _line_start_pos + 1);
        var _current_txt_w = string_width(_str_copy);
        char_x[c] = _txt_x + _current_txt_w - string_width(char_array[c]);
        char_y[c] = _txt_y + (_txt_line * (18 * _s));
    }
}

if (!en_menu_fight || en_modo_info) {
    var _caracteres_visibles = floor(draw_char);
    if (variable_instance_exists(id, "char_x") && variable_instance_exists(id, "char_array")) {
        for (var c = 0; c < _caracteres_visibles; c++) {
            if (c < array_length(char_x) && char_x[c] != -9999) { draw_text_color(char_x[c], char_y[c], char_array[c], c_white, c_white, c_white, c_white, _alpha_final); }
        }
    }
} else {
    var _tx = (14 + 16) * _s; var _ty = (125 + 10) * _s; var _op = ["* Atacar", "* Info"];
    for (var i = 0; i < 2; i++) {
        var _col = (opcion_fight_seleccionada == i) ? c_yellow : c_white;
        draw_text_color(_tx + (i * 120 * _s), _ty, _op[i], _col, _col, _col, _col, _alpha_final);
    }
    var _bar_en_x = _tx; var _bar_en_y = _ty + (20 * _s); var _bar_en_w = (string_width("* Atacar") * _s) * 0.75; var _bar_en_h = 5 * _s;
    var _vida_act = enemigo.vida_actual; var _vida_max = enemigo.vida_max;
    draw_set_alpha(_alpha_final);
    draw_rectangle_color(_bar_en_x, _bar_en_y, _bar_en_x + _bar_en_w, _bar_en_y + _bar_en_h, c_yellow, c_yellow, c_yellow, c_yellow, false);
    var _porcentaje_vida_en = clamp(_vida_act / _vida_max, 0, 1);
    var _current_en_w = _bar_en_w * _porcentaje_vida_en;
    if (_current_en_w > 0) { draw_rectangle_color(_bar_en_x, _bar_en_y, _bar_en_x + _current_en_w, _bar_en_y + _bar_en_h, c_lime, c_lime, c_lime, c_lime, false); }
    draw_set_alpha(1.0);
}

draw_set_alpha(_alpha_final);
draw_sprite_ext(spr_bbs_textbox, 0, 6 * _s, 183 * _s, 2.27451 * _s, 1.0 * _s, 0, c_white, _alpha_final);
draw_sprite_ext(spr_bbs_prota_head, 0, 14 * _s, 195 * _s, 1.0 * _s, 1.0 * _s, 0, c_white, _alpha_final);
draw_sprite_ext(spr_bbs_textbox, 0, 126 * _s, 183 * _s, 3.666666 * _s, 1.0 * _s, 0, c_white, _alpha_final);

var _hp_actual = 80; var _hp_max = 80;
if (instance_exists(obj_player)) { _hp_actual = obj_player.hp; _hp_max = obj_player.hp_max; }
var _info_x = 55 * _s; var _info_y = 189 * _s;
draw_set_halign(fa_left);
draw_text_color(_info_x, _info_y, "Noelle", c_white, c_white, c_white, c_white, _alpha_final);
var _hp_label_y = _info_y + 16 * _s;
draw_text_transformed_color(_info_x, _hp_label_y, "HP", 0.7, 0.7, 0, c_white, c_white, c_white, c_white, _alpha_final);
var _hp_texto = string(_hp_actual) + " / " + string(_hp_max);
var _hp_texto_x = _info_x + 24 * _s;
draw_text_transformed_color(_hp_texto_x, _hp_label_y, _hp_texto, 0.7, 0.7, 0, c_white, c_white, c_white, c_white, _alpha_final);
var _ancho_total_texto = (_hp_texto_x + (string_width(_hp_texto) * 0.7)) - _info_x;
draw_rectangle_color(_info_x, _hp_label_y + 9 * _s, _info_x + _ancho_total_texto, _hp_label_y + 9 * _s + 6 * _s, $202020, $202020, $202020, $202020, false);
var _porcentaje_hp = clamp(_hp_actual / _hp_max, 0, 1);
draw_rectangle_color(_info_x, _hp_label_y + 9 * _s, _info_x + (_ancho_total_texto * _porcentaje_hp), _hp_label_y + 9 * _s + 6 * _s, c_yellow, c_yellow, c_yellow, c_yellow, false);

draw_set_alpha(1.0);
var _escala_btn = 1.310613 * _s;
var _pos_x_btn = [132.371, 177.0, 221.0769, 265.0];
for (var i = 0; i < 4; i++) {
    var _frame = (opcion_seleccionada == i) ? 1 : 0;
    draw_sprite_ext(opciones[i], _frame, _pos_x_btn[i] * _s, 192 * _s, _escala_btn, _escala_btn, 0, c_white, _alpha_final);
}