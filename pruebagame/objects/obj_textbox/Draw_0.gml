accept_key = keyboard_check_pressed(ord("Z"));

textbox_x = camera_get_view_x(view_camera[0] );
textbox_y = camera_get_view_y(view_camera[0] ) + 144;


//setup
if setup == false
	{
	
	setup = true;
	draw_set_font(global.font_main);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	//loop a travez de las paginas
	page_number = array_length(text);
	for(var p = 0; p < page_number; p++)
		{
		
		//encontrar cuantos personajes hay en cada pagina y ordenar el numero en "text_leght"
		text_lenght[p] = string_length(text[p]);
		
		//obtener la posición X para el cuadro de texto
			//no tener caracteres (estar centrado)
		
		text_x_offset[p] = 44;
		
		}
	
	}
	

//escribir el texto
if draw_char < text_lenght[page]
	{
	
	draw_char += text_spd;
	draw_char = clamp(draw_char, 0, text_lenght[page]);
	
	
	}


//pasar paginas
if accept_key
	{
	
	//si se termina de escribir
	if draw_char == text_lenght[page]
		{
			
			
		//siguiente pagina
		if page < page_number-1
			{
			page++;
			draw_char = 0;
			}
		//destruir cuadro de texto
		else
			{
			instance_destroy();
			}
		}
	//si no ha terminado de escribir
	else
		{
		draw_char = text_lenght[page];
		
		}
		
		
	}

//dibujar cuadro de texto
txtb_img += txtb_img_spd;
txtb_spr_w = sprite_get_width(txtb_spr);
txtb_spr_h = sprite_get_height(txtb_spr);

//dibujar parte de atras del cuadro de texto
draw_sprite_ext(txtb_spr, txtb_img, textbox_x + text_x_offset[page], textbox_y, textbox_width/txtb_spr_w, textbox_heigh/txtb_spr_h, 0, c_white, 1);


//dibujar el texto
var _drawtext = string_copy(text[page], 1, draw_char);
draw_text_ext(textbox_x + text_x_offset[page] + border, textbox_y + border, _drawtext, line_sep, line_width);