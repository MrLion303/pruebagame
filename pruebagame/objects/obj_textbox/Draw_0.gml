accept_key = keyboard_check_pressed(ord("Z")) || keyboard_check_pressed(vk_enter);
skip_key = keyboard_check_pressed(ord("X")) || keyboard_check_pressed(vk_shift);

if (!variable_instance_exists(id, "page_number") || page_number <= 0) exit;
if (!variable_instance_exists(id, "text") || !is_array(text)) exit;

var _box_scale = 0.75; 
var _box_w = textbox_width * _box_scale;
var _box_h = textbox_heigh * _box_scale;

var _cam_x = camera_get_view_x(view_camera[0]);
var _cam_y = camera_get_view_y(view_camera[0]);
var _cam_w = camera_get_view_width(view_camera[0]);

textbox_x = _cam_x + (_cam_w - _box_w) / 2; 
textbox_y = _cam_y + camera_get_view_height(view_camera[0]) - _box_h - 16;

var _txtb_x = textbox_x + border;
var _txtb_y = textbox_y + border;

if setup == false
{
    setup = true;
    draw_set_font(global.font_main);
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
}

if (page >= page_number) page = page_number - 1;
if (page < 0) page = 0;

if (!is_array(text_lenght)) text_lenght = array_create(page_number, 0);
if (array_length(text_lenght) <= page) {
    array_resize(text_lenght, page_number);
}
if (is_undefined(text_lenght[page])) {
    text_lenght[page] = 0;
}

if (draw_char < text_lenght[page])
{
    draw_char += text_spd;
    draw_char = clamp(draw_char, 0, text_lenght[page]);
    
    if skip_key
    {
        draw_char = text_lenght[page];
    }
}
else if accept_key
{
    if (draw_char >= text_lenght[page]) {
        if page < page_number - 1
        {
            page++;
            draw_char = 0;
        }
        else
        {
            if variable_instance_exists(id, "option_number") && option_number > 0 {
                create_textbox(option_link_id[option_pos]);
            }
            instance_destroy();
            exit;
        }
    }
}

txtb_img += txtb_img_spd;
draw_sprite_ext(txtb_spr, txtb_img, textbox_x, textbox_y, _box_w/txtb_spr_w, _box_h/txtb_spr_h, 0, c_white, 1);

if (variable_instance_exists(id, "option_number") && option_number > 0)
{
    if (draw_char == text_lenght[page] && page == page_number - 1)
    {
        option_pos += keyboard_check_pressed(vk_right) - keyboard_check_pressed(vk_left);
        option_pos = clamp(option_pos, 0, option_number - 1);
        
        var _op_scale = 1/3; 
        var _op_spacing = 36; 
        var _total_options_width = 0;
        
        for (var op = 0; op < option_number; op++)
        {
            _total_options_width += (string_width(option[op]) * _op_scale);
            if (op < option_number - 1) {
                _total_options_width += _op_spacing;
            }
        }
        
        var _start_x = textbox_x + (_box_w - _total_options_width) / 2;
        var _start_y = textbox_y + _box_h - border - 28; 
        var _current_x = _start_x;
        
        for (var op = 0; op < option_number; op++)
        {
            var _text_w = string_width(option[op]) * _op_scale;
            
            if option_pos == op 
            {
                draw_sprite_ext(spr_textbox_arrow, 0, _current_x - 12, _start_y + 3, 0.4, 0.4, 0, c_white, 1);
            }
            
            draw_text_transformed(_current_x, _start_y, option[op], _op_scale, _op_scale, 0);
            _current_x += _text_w + _op_spacing;
        }
    }
}

var _text_scale = 5/9;
var _correct_line_width = (_box_w - (border * 2)) / _text_scale;
var _proper_line_sep = 28; 

var _drawtext = "";
if (is_array(text) && page < array_length(text)) {
    _drawtext = string_copy(text[page], 1, draw_char);
}

var _current_color = c_white;
if (variable_instance_exists(id, "text_color") && is_array(text_color) && page < array_length(text_color)) {
    _current_color = text_color[page];
}

draw_text_ext_transformed_color(
    _txtb_x, 
    _txtb_y, 
    _drawtext, 
    _proper_line_sep, 
    _correct_line_width, 
    _text_scale, 
    _text_scale, 
    0,
    _current_color, _current_color, _current_color, _current_color, 1
);