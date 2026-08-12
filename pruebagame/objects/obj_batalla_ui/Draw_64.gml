// Variable de escala global
var _s = 2; 

// 1. Control de Fade In inicial (hace que aparezca suavemente de 0 a 1)
if (!variable_instance_exists(id, "alpha_aparicion")) {
    alpha_aparicion = 0.0;
}

// Velocidad a la que aparece (cámbiala si quieres que sea más rápido o más lento)
if (alpha_aparicion < 1.0) {
    alpha_aparicion += 0.05; // Sube un 5% cada frame
}

// Combinamos el fade in propio con el desvanecimiento de la transición si existe
var _fade_transicion = 1.0;
if (instance_exists(obj_transision_bbs)) {
    _fade_transicion = obj_transision_bbs.image_alpha; 
}

// Alfa final real (multiplica la aparición suave con la transición de la room)
var _alpha_final = alpha_aparicion * _fade_transicion;

// 2. Caja de diálogo superior
draw_sprite_ext(spr_bbs_textbox, 0, 14 * _s, 125 * _s, 5.666667 * _s, 1.0 * _s, 0, c_white, _alpha_final);

// 3. Caja inferior izquierda (debajo de la cabeza)
draw_sprite_ext(spr_bbs_textbox, 0, 6 * _s, 183 * _s, 2.27451 * _s, 1.0 * _s, 0, c_white, _alpha_final);

// Cabeza del protagonista
draw_sprite_ext(spr_bbs_prota_head, 0, 14 * _s, 195 * _s, 1.0 * _s, 1.0 * _s, 0, c_white, _alpha_final);

// 4. Caja inferior derecha (detrás de los botones)
draw_sprite_ext(spr_bbs_textbox, 0, 126 * _s, 183 * _s, 3.666666 * _s, 1.0 * _s, 0, c_white, _alpha_final);

// 5. Botones de acción (Fight, Item, Toy, Huir) con su Fade In sincronizado
var _escala_btn = 1.310613 * _s;
var _pos_x_btn = [132.371, 177.0, 221.0769, 265.0];

for (var i = 0; i < 4; i++) {
    var _frame = (opcion_seleccionada == i) ? 1 : 0;
    draw_sprite_ext(opciones[i], _frame, _pos_x_btn[i] * _s, 192 * _s, _escala_btn, _escala_btn, 0, c_white, _alpha_final);
}