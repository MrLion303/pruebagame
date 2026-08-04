movimiento = false;

var l6E532987_0;
l6E532987_0 = keyboard_check(ord("X"));
if (l6E532987_0)
{
	velocidad = 5;
}

else
{
	velocidad = 4;
}

var l7A66E26E_0;
l7A66E26E_0 = keyboard_check(vk_right);
if (l7A66E26E_0)
{
	x = x + velocidad;
}

var l71B165B4_0;
l71B165B4_0 = keyboard_check(vk_left);
if (l71B165B4_0)
{
	x = x - velocidad;

	movimiento = true;
}

var l57A62734_0;
l57A62734_0 = keyboard_check(vk_up);
if (l57A62734_0)
{
	y = y - velocidad;

	movimiento = true;
}

var l67A1873C_0;
l67A1873C_0 = keyboard_check(vk_down);
if (l67A1873C_0)
{
	y = y + velocidad;

	movimiento = true;
}

var l6ED69B1D_0 = instance_place(x, y, [pared]);
if ((l6ED69B1D_0 > 0))
{
	var l727BDE60_0;
l727BDE60_0 = keyboard_check(vk_right);
if (l727BDE60_0)
{
	x = x - velocidad;
}

	var l7E2C0B56_0;
l7E2C0B56_0 = keyboard_check(vk_left);
if (l7E2C0B56_0)
{
	x = x + velocidad;
}

	var l78A72B2D_0;
l78A72B2D_0 = keyboard_check(vk_up);
if (l78A72B2D_0)
{
	y = y + velocidad;
}

	var l70177E0E_0;
l70177E0E_0 = keyboard_check(vk_down);
if (l70177E0E_0)
{
	y = y - velocidad;
}
}

if (keyboard_check(vk_right))
{
    sprite_index = pendejo_derecha;
}
else if (keyboard_check(vk_left))
{
    sprite_index = pendejo_izquierda;
}
else if (keyboard_check(vk_up))
{
    sprite_index = pendejo_arriba;
}
else if (keyboard_check(vk_down))
{
    sprite_index = pendejo_abajo;
}
else
{
    sprite_index = pendejo_idle;
    image_index = 0;
}