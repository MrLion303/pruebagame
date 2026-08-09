room_goto(target_rm);

obj_player.x = target_x;
obj_player.y = target_y;
obj_player.face = target_face;

// Si NO debemos conservar la música, hacemos el comportamiento normal (parar y poner la nueva con fade in)
if (!keep_music) 
{
    audio_stop_all();

    if (target_music != -1)
    {
        var _new_audio = audio_play_sound(target_music, 1, true);
        audio_sound_gain(_new_audio, 0, 0); 
        audio_sound_gain(_new_audio, 1, 1000); 
    }
}
// Si keep_music es true, la música del pasillo_school sigue sonando de largo hacia toriel_salon sin cortarse.

image_speed = -1;