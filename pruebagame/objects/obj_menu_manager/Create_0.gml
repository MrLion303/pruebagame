// Opciones del menú principal actualizadas con "INFO"
main_options = ["INV", "EQUIP", "INFO", "OPC", "CERRAR"];
main_index = 0;

// Estados posibles del menú
enum MENU_STATE {
    CLOSED,
    MAIN,
    INVENTORY,
    ITEM_ACTION,
    ITEM_INFO,
    ITEM_DROP_CONFIRM,
    
    // Estados para EQUIP
    EQUIP_MENU,
    EQUIP_ACTION,
    EQUIP_INFO,
    EQUIP_DROP_CONFIRM,
    
    INFO_MENU,       
    GAME_CLOSE_CONFIRM
}

state = MENU_STATE.CLOSED;

// Inventario de curación (12 slots: 4 filas x 3 columnas)
inventory = ["agua", -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
inv_x = 0;
inv_y = 0;
inv_scroll = 0; 

// Inventario de Equipamiento ampliado a 50 slots (16 filas x 3 columnas + 2 huecos, total 50)
equipment = array_create(51, -1);
equipment[0] = "espada_basica"; 
equipment[1] = "armadura_basica";
equip_x = 0;
equip_y = 0;
equip_scroll = 0; 

// Opciones de acción para los ítems
action_options = ["Usar", "Tirar", "Info"];
action_index = 0;

// Opciones de acción para el equipamiento
equip_action_options = ["Equipar", "Tirar", "Info"];
equip_action_index = 0;

drop_confirm_index = 1; 
close_confirm_index = 1;