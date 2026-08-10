depth = -9999;

// Textbox parámetros: Más angosta y más alta
textbox_width = 240;
textbox_height = 80; 
border = 8;          
line_sep = 18;       

line_width = textbox_width - (border * 2);

txtb_spr = [spr_textbox];
speaker_sprite = [noone];
txtb_img = 0;
txtb_img_spd = 3/30;

// Variables de control de páginas y animación
page = 0;
page_number = 0;
text = [""];         
text_lenght = [0];    
text_color = [c_white]; 

char[0, 0] = "";
char_x[0, 0] = 0;
char_y[0, 0] = 0;

draw_char = 0;
text_spd = 1;
setup = false;

txtb_spr_w = sprite_get_width(txtb_spr[0]);
txtb_spr_h = sprite_get_height(txtb_spr[0]);

// Opciones
option[0] = "";
option_link_id[0] = -1;
option_pos = 0;
option_number = 0;

text_id = "default";

// Efectos
scr_set_defaults_for_text();
last_free_space = 0;