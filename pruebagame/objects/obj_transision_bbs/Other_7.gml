// Si termino la primera mitad (fade to black) y aun no cambiamos de room
if (image_speed > 0 && !fase_salida) {
    fase_salida = true; // Bloqueamos para que solo pase una vez
    
    // Cambiar a la habitacion de batalla
    room_goto(bbs);
    
    // Invertir la animacion para hacer el fade out (revelar la pantalla) con la misma velocidad lenta
    image_speed = -0.5; // <--- CAMBIO: Negativo y con la misma velocidad lenta
    image_index = sprite_get_number(sprite_index) - 1;  
} 
else if (image_speed < 0) {
    // Si ya termino la animacion inversa en la habitacion de batalla, nos destruimos
    instance_destroy();
}