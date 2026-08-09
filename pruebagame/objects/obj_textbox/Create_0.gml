depth = -9999;

// Textbox parámetros
textbox_width = 288;
textbox_heigh = 95; 
border = 12; 
line_sep = 26; 

line_width = (textbox_width - (border * 2)) / (2/3);

txtb_spr = spr_textbox;
txtb_img = 0;
txtb_img_spd = 3/30;

// Variables de control de páginas y animación
page = 0;
page_number = 0;
text = [""];         
text_lenght = [0];    
text_color = [c_white]; 
draw_char = 0;
text_spd = 1;
setup = false;

txtb_spr_w = sprite_get_width(txtb_spr);
txtb_spr_h = sprite_get_height(txtb_spr);

// Opciones
option[0] = "";
option_link_id[0] = -1;
option_pos = 0;
option_number = 0;

text_id = "default";