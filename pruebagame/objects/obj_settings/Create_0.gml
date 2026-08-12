global.font_main = font_add_sprite(spr_main_font, 32, true, 1);

// Inicializamos la base de datos universal de ítems y equipamiento
scr_item_db();
scr_equips_data(); // <-- ¡Añadido aquí!

// Creamos el gestor de menús de forma persistente y automática

