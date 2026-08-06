//empezar save
ini_open("prueba.ini")
if(image_index = 0 and keyboard_check_pressed(ord("Z"))){

	room_goto(global.start_room)
	var instantiated = instance_create_layer(global.start_x, global.start_y, "Player", obj_player)
	global.new_game = false

}
ini_close()