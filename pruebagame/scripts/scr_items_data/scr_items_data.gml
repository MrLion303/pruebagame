function scr_item_db() {
    global.item_db = {
		
		
		
        agua: {
            nombre: "Vaso de Agua",
            descripcion: "Ayuda a hidratarte",
            tipo: "consumible",
            efecto: function() {
                // Suponiendo que tu jugador tiene la variable hp y max_hp
                if (variable_global_exists("hp")) {
                    hp = min(max_hp, hp + 50);
                }
            },
            icono: -1 // Reemplaza por tu sprite index si tienes
        },
		
		
		

        manzana: {
            nombre: "Manzana",
            descripcion: "Rica y crujiente",
            tipo: "consumible",
            efecto: function() { hp = min(max_hp, hp + 20); },
            icono: -1
        }
		
		
		        // Puedes agregar más ítems aquí fácilmente en el futuro:
        /*
        manzana: {
            nombre: "Manzana",
            descripcion: "Rica y crujiente",
            tipo: "consumible",
            efecto: function() { hp = min(max_hp, hp + 20); },
            icono: -1
        }
        */
    };
}