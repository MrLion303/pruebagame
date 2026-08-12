// Si ya estamos en la room de batalla y la animacion esta retrocediendo (fade out)
// cuando llegue al inicio (image_index < 1), el objeto se destruye.
if (room == bbs && image_index < 1) {
    instance_destroy();
}