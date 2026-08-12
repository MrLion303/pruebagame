velocidad = 4;
movimiento = false;
direccion = "abajo";

face = DOWN;
facing_direction = 2;

// --- NUEVAS ESTADÍSTICAS Y EQUIPAMIENTO ---
hp = 80;
hp_max = 80;
nivel = 1;
ataque_base = 0;
defensa_base = 0;
exp_actual = 0;
exp_siguiente = 100;

// Slots de equipo activo
equipo_arma = -1;        
equipo_armadura = -1;

// Bandera maestra de control de movimiento (por defecto true, se apaga al viajar a batalla)
puede_moverse = true;

// --- RECUPERAR POSICIÓN DE RETORNO (BATALLAS / TELETRANSPORTE) ---
if (variable_global_exists("return_x") && variable_global_exists("return_y")) {
    x = global.return_x;
    y = global.return_y;
    
    // Al nacer tras una batalla, bloqueamos el movimiento inmediatamente
    puede_moverse = false;
    
    // Limpiamos las variables globales
    variable_global_del("return_x");
    variable_global_del("return_y");
    
    if (variable_global_exists("return_room")) {
        variable_global_del("return_room");
    }
}