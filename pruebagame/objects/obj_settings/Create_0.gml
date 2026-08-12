global.font_main = font_add_sprite(spr_main_font, 32, true, 1);

// Inicializamos la base de datos universal de ítems y equipamiento
scr_item_db();
scr_equips_data(); // <-- ¡Añadido aquí!

// Creamos el gestor de menús de forma persistente y automática

// --- CONFIGURACIÓN GLOBAL ---
global.master_volume = 100; // 0 a 100
global.fullscreen_enabled = window_get_fullscreen(); // Detecta si ya está en pantalla completa
global.auto_run = false;     // Desactivado por defecto