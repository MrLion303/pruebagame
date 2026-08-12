if (state == MENU_STATE.CLOSED) exit;

if (variable_global_exists("font_main")) {
    draw_set_font(global.font_main);
}

var gui_x = 64;
var gui_y = 64;
var gui_w = 520;
var gui_h = 340;

// 1. Fondo Principal
draw_sprite_stretched(spr_textbox, 0, gui_x, gui_y, gui_w, gui_h);

// 2. Menú Izquierdo (5 opciones)
var m_x = gui_x + 16;
var m_y = gui_y + 16;
var m_w = 130;
var m_h = 308;
draw_sprite_stretched(spr_textbox, 0, m_x, m_y, m_w, m_h);

// Dibujar las 5 opciones del menú izquierdo
for (var i = 0; i < array_length(main_options); i++) {
    var col = (state == MENU_STATE.MAIN && main_index == i) ? c_yellow : c_orange;
    draw_set_color(col);
    draw_text(m_x + 16, m_y + 12 + (i * 46), main_options[i]);
}

// CASO A: Confirmar cierre de juego
if (state == MENU_STATE.GAME_CLOSE_CONFIRM) {
    var close_box_w = 314;
    var close_box_h = 115;
    var close_box_x = m_x + m_w + 12;
    var close_box_y = gui_y + (gui_h / 2) - (close_box_h / 2);
    
    draw_sprite_stretched(spr_textbox, 0, close_box_x, close_box_y, close_box_w, close_box_h);
    
    draw_set_color(c_yellow);
    draw_text(close_box_x + 16, close_box_y + 16, "Estas seguro?");
    
    var options_close = ["Si", "No"];
    for (var c = 0; c < array_length(options_close); c++) {
        var col_c = (close_confirm_index == c) ? c_yellow : c_white;
        draw_set_color(col_c);
        draw_text(close_box_x + 40 + (c * 110), close_box_y + 60, options_close[c]);
    }
}
// CASO B: Menú INFO
else if (state == MENU_STATE.INFO_MENU) {
    var info_box_x = m_x + m_w + 12;
    var info_box_y = m_y;
    var info_box_w = 346;
    var info_box_h = m_h;
    
    draw_sprite_stretched(spr_textbox, 0, info_box_x, info_box_y, info_box_w, info_box_h);
    draw_set_color(c_yellow);
    draw_text(info_box_x + 24, info_box_y + 24, "Seccion INFO");
    draw_set_color(c_white);
    draw_text_ext(info_box_x + 24, info_box_y + 70, "Proximamente...", 25, 300);
}
// CASO C: INVENTARIO DE CURACIÓN
else if (state >= MENU_STATE.INVENTORY && state <= MENU_STATE.ITEM_DROP_CONFIRM) {
    var inv_box_x = m_x + m_w + 12;
    var inv_box_y = m_y;
    var inv_box_w = 346;
    var inv_box_h = m_h;
    
    draw_sprite_stretched(spr_textbox, 0, inv_box_x, inv_box_y, inv_box_w, inv_box_h);
    
    var start_x = inv_box_x + 24;
    var start_y = inv_box_y + 20;
    var cell_w = 100;
    var cell_h = 45;
    
    for (var yy = 0; yy < 3; yy++) {
        for (var xx = 0; xx < 3; xx++) {
            var index = (yy + inv_scroll) * 3 + xx;
            var cx = start_x + (xx * cell_w);
            var cy = start_y + (yy * cell_h);
            
            if (state == MENU_STATE.INVENTORY && inv_x == xx && inv_y == yy) {
                draw_set_color(c_yellow);
                draw_rectangle(cx - 4, cy - 4, cx + cell_w - 18, cy + cell_h - 10, true);
            }
            
            if (index < array_length(inventory)) {
                var item_key = inventory[index];
                if (item_key != -1) {
                    var item = global.item_db[$ item_key];
                    draw_set_color(c_orange);
                    draw_text_ext_transformed(cx, cy, item.nombre, 23, 120, 0.66, 0.66, 0);
                } else {
                    draw_set_color(c_dkgray);
                    draw_text_transformed(cx, cy, "-----", 0.66, 0.66, 0);
                }
            }
        }
    }
    
    // --- BARRA DE SCROLL INVENTARIO ---
    var bar_x = inv_box_x + 322;
    var bar_y = start_y;
    var bar_h = 120;
    draw_set_color(c_dkgray);
    draw_line_width(bar_x, bar_y, bar_x, bar_y + bar_h, 2);
    
    var dot_y = bar_y + (inv_scroll / 1) * bar_h;
    var sq_size = 4;
    draw_set_color(c_white);
    draw_rectangle(bar_x - sq_size, dot_y - sq_size, bar_x + sq_size, dot_y + sq_size, false);
    // ----------------------------------
    
    var box_inf_x = inv_box_x + 16;
    var box_inf_y = inv_box_y + 175;
    var box_inf_w = 314;
    var box_inf_h = 115;
    
    draw_sprite_stretched(spr_textbox, 0, box_inf_x, box_inf_y, box_inf_w, box_inf_h);
    
    if (state == MENU_STATE.ITEM_ACTION) {
        for (var a = 0; a < array_length(action_options); a++) {
            var col_a = (action_index == a) ? c_yellow : c_white;
            draw_set_color(col_a);
            draw_text(box_inf_x + 16 + (a * 95), box_inf_y + 16, action_options[a]);
        }
        draw_set_color(c_ltgray);
        draw_text(box_inf_x + 16, box_inf_y + 65, "Z: Selecc | X: Volver");
    } 
    else if (state == MENU_STATE.ITEM_INFO) {
        var inv_index = min((inv_y + inv_scroll) * 3 + inv_x, array_length(inventory) - 1);
        var selected_item_key = inventory[inv_index];
        var item_info = global.item_db[$ selected_item_key];
        
        draw_set_color(c_yellow);
        draw_text(box_inf_x + 16, box_inf_y + 16, item_info.nombre);
        draw_set_color(c_white);
        draw_text_ext(box_inf_x + 16, box_inf_y + 45, item_info.descripcion, 25, 280);
    }
    else if (state == MENU_STATE.ITEM_DROP_CONFIRM) {
        draw_set_color(c_yellow);
        draw_text(box_inf_x + 16, box_inf_y + 16, "Estas seguro?");
        var options_drop = ["Si", "No"];
        for (var d = 0; d < array_length(options_drop); d++) {
            var col_d = (drop_confirm_index == d) ? c_yellow : c_white;
            draw_set_color(col_d);
            draw_text(box_inf_x + 40 + (d * 110), box_inf_y + 60, options_drop[d]);
        }
    }
    else {
        var inv_index = min((inv_y + inv_scroll) * 3 + inv_x, array_length(inventory) - 1);
        var selected_item_key = inventory[inv_index];
        draw_set_color(c_white);
        if (selected_item_key != -1) {
            var item_info = global.item_db[$ selected_item_key];
            draw_text_ext(box_inf_x + 16, box_inf_y + 20, item_info.descripcion, 25, 280);
        } else {
            draw_text(box_inf_x + 16, box_inf_y + 25, "Espacio vacio.");
        }
    }
}
// CASO D: MENÚ DE EQUIPAMIENTO (51 slots)
else if (state >= MENU_STATE.EQUIP_MENU && state <= MENU_STATE.EQUIP_DROP_CONFIRM) {
    var eq_box_x = m_x + m_w + 12;
    var eq_box_y = m_y;
    var eq_box_w = 346;
    var eq_box_h = m_h;
    
    draw_sprite_stretched(spr_textbox, 0, eq_box_x, eq_box_y, eq_box_w, eq_box_h);
    
    var start_x = eq_box_x + 24;
    var start_y = eq_box_y + 20;
    var cell_w = 100;
    var cell_h = 45;
    
    for (var yy = 0; yy < 3; yy++) {
        for (var xx = 0; xx < 3; xx++) {
            var index = (yy + equip_scroll) * 3 + xx;
            var cx = start_x + (xx * cell_w);
            var cy = start_y + (yy * cell_h);
            
            if (state == MENU_STATE.EQUIP_MENU && equip_x == xx && equip_y == yy) {
                draw_set_color(c_yellow);
                draw_rectangle(cx - 4, cy - 4, cx + cell_w - 18, cy + cell_h - 10, true);
            }
            
            if (index < array_length(equipment)) {
                var eq_key = equipment[index];
                if (eq_key != -1) {
                    var eq_item = global.equip_db[$ eq_key];
                    draw_set_color(c_orange);
                    draw_text_ext_transformed(cx, cy, eq_item.nombre, 23, 120, 0.66, 0.66, 0);
                } else {
                    draw_set_color(c_dkgray);
                    draw_text_transformed(cx, cy, "-----", 0.66, 0.66, 0);
                }
            }
        }
    }
    
    // --- BARRA DE SCROLL EQUIPAMIENTO ---
    var bar_x = eq_box_x + 322;
    var bar_y = start_y;
    var bar_h = 120;
    draw_set_color(c_dkgray);
    draw_line_width(bar_x, bar_y, bar_x, bar_y + bar_h, 2);
    
    var max_scroll = (array_length(equipment) / 3) - 3; // (51 / 3) - 3 = 14
    var dot_y = bar_y + (max_scroll > 0 ? (equip_scroll / max_scroll) * bar_h : 0);
    var sq_size = 4;
    draw_set_color(c_white);
    draw_rectangle(bar_x - sq_size, dot_y - sq_size, bar_x + sq_size, dot_y + sq_size, false);
    // -------------------------------------------------------
    
    var box_inf_x = eq_box_x + 16;
    var box_inf_y = eq_box_y + 175;
    var box_inf_w = 314;
    var box_inf_h = 115;
    
    draw_sprite_stretched(spr_textbox, 0, box_inf_x, box_inf_y, box_inf_w, box_inf_h);
    
    if (state == MENU_STATE.EQUIP_ACTION) {
        for (var a = 0; a < array_length(equip_action_options); a++) {
            var col_a = (equip_action_index == a) ? c_yellow : c_white;
            draw_set_color(col_a);
            draw_text(box_inf_x + 12 + (a * 102), box_inf_y + 16, equip_action_options[a]);
        }
        draw_set_color(c_ltgray);
        draw_text(box_inf_x + 16, box_inf_y + 65, "Z: Selecc | X: Volver");
    } 
    else if (state == MENU_STATE.EQUIP_INFO) {
        var eq_index = min((equip_y + equip_scroll) * 3 + equip_x, array_length(equipment) - 1);
        var selected_eq_key = equipment[eq_index];
        var eq_info = global.equip_db[$ selected_eq_key];
        
        draw_set_color(c_yellow);
        draw_text(box_inf_x + 16, box_inf_y + 16, eq_info.nombre);
        draw_set_color(c_white);
        draw_text_ext(box_inf_x + 16, box_inf_y + 45, eq_info.descripcion, 25, 280);
    }
    else if (state == MENU_STATE.EQUIP_DROP_CONFIRM) {
        draw_set_color(c_yellow);
        draw_text(box_inf_x + 16, box_inf_y + 16, "Estas seguro?");
        var options_drop = ["Si", "No"];
        for (var d = 0; d < array_length(options_drop); d++) {
            var col_d = (drop_confirm_index == d) ? c_yellow : c_white;
            draw_set_color(col_d);
            draw_text(box_inf_x + 40 + (d * 110), box_inf_y + 60, options_drop[d]);
        }
    }
    else {
        var eq_index = min((equip_y + equip_scroll) * 3 + equip_x, array_length(equipment) - 1);
        var selected_eq_key = equipment[eq_index];
        draw_set_color(c_white);
        if (selected_eq_key != -1) {
            var eq_info = global.equip_db[$ selected_eq_key];
            draw_text_ext(box_inf_x + 16, box_inf_y + 20, eq_info.descripcion, 25, 280);
        } else {
            draw_text(box_inf_x + 16, box_inf_y + 25, "Espacio vacio.");
        }
    }
}

draw_set_color(c_white);