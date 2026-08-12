main_options = ["INV", "EQUIP", "STAD", "OPC", "CERRAR"];
main_index = 0;

enum MENU_STATE {
    CLOSED,
    MAIN,
    INVENTORY,
    ITEM_ACTION,
    ITEM_INFO,
    ITEM_DROP_CONFIRM,
    
    EQUIP_MENU,
    EQUIP_ACTION,
    EQUIP_INFO,
    EQUIP_DROP_CONFIRM,
    
    INFO_MENU,        
    OPTIONS_MENU,    
    GAME_CLOSE_CONFIRM
}

state = MENU_STATE.CLOSED;

inventory = ["agua", -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1];
inv_x = 0;
inv_y = 0;
inv_scroll = 0; 

equipment = array_create(51, -1);
equipment[0] = "espada_basica";		
equipment[1] = "armadura_basica";
equip_x = 0;
equip_y = 0;
equip_scroll = 0; 
max_equip_scroll = 14; 

action_options = ["Usar", "Tirar", "Info"];
action_index = 0;

equip_action_options = ["Equip", "Tirar", "Info"];
equip_action_index = 0;

drop_confirm_index = 1; 
close_confirm_index = 1;