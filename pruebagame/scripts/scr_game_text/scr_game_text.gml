// pasar renglon \n

// @param text_id
function scr_game_text(_text_id){
	
    switch(_text_id) {





        case "npc":
            scr_text("Hola como tai yo bien y usted? jejejej12344");
            scr_text("EL PITITO TE LO COMES HOLA SOY GERMAN");
            scr_text("Bueno... te gusta el keke?");
				scr_option("Yeah ME ENCANTA", "npc 1 - yes");
				scr_option("Ni de pedoooo", "npc 1 - no");
            break;
            
	        case "npc 1 - yes":
	            scr_text("VIVAAAAAAAAAAA!!!");
	            break;
            
			  case "npc 1 - no":
	            scr_text("que tontorron");
	            break;
        
		case "npc 1":
    // Diálogo con Noelle y su respectivo sprite de cabeza a la izquierda
    scr_text("Hola, soy Noelle y este es mi diálogo con retrato.", c_white, spr_noelle_normal);
    scr_text("Este segundo renglón también se acomoda solito respetando la cabeza.", c_white, spr_noelle_normal);
    
    // Diálogo normal sin sprite por si quieres alternar en la misma caja
    scr_text("Y este mensaje vuelve a ser normal sin cabeza.");
    break;
		
		
		
        case "npc 2":
            scr_text("Soy el original");
            scr_text("Ayudame a encontrar, por favor, a mi madre");
            break;
        
        case "npc 3":
            scr_text("Hola como tai yo bien y usted? jejejej12344");
            scr_text("Nah... yo si");
            break;





    }

}