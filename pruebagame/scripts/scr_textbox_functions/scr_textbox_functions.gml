/// @param text
/// @param [color]
function scr_text(_text, _color = c_white){
    with (obj_textbox)
    {
        text[page_number] = _text;
        
        if (!variable_instance_exists(id, "text_color")) {
            text_color = array_create(page_number + 1, c_white);
        }
        if (array_length(text_color) <= page_number) {
            array_resize(text_color, page_number + 1);
        }
        text_color[page_number] = _color;
        
        if (!variable_instance_exists(id, "is_multi_color")) {
            is_multi_color = array_create(page_number + 1, false);
        }
        if (array_length(is_multi_color) <= page_number) {
            array_resize(is_multi_color, page_number + 1);
        }
        is_multi_color[page_number] = false;
        
        page_number++;
        text_lenght[page_number - 1] = string_length(text[page_number - 1]);
    }
}

/// @param text1
/// @param color1
/// @param text2
/// @param color2
function scr_text_multi(_t1, _c1, _t2, _c2) {
    with (obj_textbox) {
        text[page_number] = _t1 + _t2; 
        
        if (!variable_instance_exists(id, "is_multi_color")) {
            is_multi_color = array_create(page_number + 1, false);
        }
        if (array_length(is_multi_color) <= page_number) {
            array_resize(is_multi_color, page_number + 1);
        }
        is_multi_color[page_number] = true;
        
        if (!variable_instance_exists(id, "multi_part1")) multi_part1 = [];
        if (!variable_instance_exists(id, "multi_color1")) multi_color1 = [];
        if (!variable_instance_exists(id, "multi_part2")) multi_part2 = [];
        if (!variable_instance_exists(id, "multi_color2")) multi_color2 = [];
        
        multi_part1[page_number] = _t1;
        multi_color1[page_number] = _c1;
        multi_part2[page_number] = _t2;
        multi_color2[page_number] = _c2;
        
        page_number++;
        text_lenght[page_number - 1] = string_length(text[page_number - 1]);
    }
}

/// @param option 
/// @param link_id
function scr_option(_option, _link_id) {
    option[option_number] = _option;
    option_link_id[option_number] = _link_id;
    option_number++;
}

/// @param text_id
function create_textbox(_text_id) {
    var _txt = instance_create_depth(0, 0, -9999, obj_textbox);
    with(_txt)
    {
        text_id = _text_id;
        scr_game_text(_text_id); 
        
        if (page_number > 0) {
            text_lenght[0] = string_length(text[0]);
        }
    }
}