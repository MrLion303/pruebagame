function scr_enemigos_data(_id_enemigo) {
    var _datos = {};
    
    switch (_id_enemigo) {
        case "toby":
            _datos.nombre = "Toby";
            _datos.sprite = spr_enemigo_1;
            _datos.vida_max = 30;
            _datos.vida_actual = 30;
            _datos.ataque = 2;
            _datos.defensa = 0;
            _datos.descripcion = "Hola, esta es mi descripcion";
            _datos.texto_inicio = "* Un Toby salvaje aparece de su escondite!";
            _datos.musica = mus_battle_1; // <-- Tema musical personalizado para Toby
            break;
            
        case "slime":
            _datos.nombre = "Slime Verdoso";
            _datos.sprite = spr_slime;
            _datos.vida_max = 15;
            _datos.vida_actual = 15;
            _datos.ataque = 1;
            _datos.defensa = 1;
            _datos.descripcion = "Un pequeño monstruo gelatinoso.";
            _datos.texto_inicio = "¡Un Slime gelatinoso bloquea el paso!";
            _datos.musica = mus_battle_1; // <-- Puedes ponerle otro tema o repetir el mismo
            break;
        
        default:
            // Enemigo por defecto si ocurre algún error
            _datos.nombre = "Desconocido";
            _datos.sprite = spr_enemigo_1;
            _datos.vida_max = 10;
            _datos.vida_actual = 10;
            _datos.ataque = 1;
            _datos.defensa = 0;
            _datos.descripcion = "Un error en la matrix.";
            _datos.texto_inicio = "Algo extraño emerge de la oscuridad...";
            _datos.musica = mus_battle_1; // <-- Música por defecto por si falla
            break;
    }
    
    return _datos;
}