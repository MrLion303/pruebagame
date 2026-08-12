// Navegación cíclica de izquierda a derecha
if (keyboard_check_pressed(vk_right)) {
    opcion_seleccionada++;
    if (opcion_seleccionada > 3) opcion_seleccionada = 0; // Regresa al inicio
}

if (keyboard_check_pressed(vk_left)) {
    opcion_seleccionada--;
    if (opcion_seleccionada < 0) opcion_seleccionada = 3; // Salta al final
}