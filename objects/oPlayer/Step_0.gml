
#region CONTROLES
var key_right=keyboard_check(ord("D"))
var key_left=keyboard_check(ord("A"))
var key_jump=keyboard_check(vk_space)
var dash_up=keyboard_check(ord("Q"))
var side_dash=keyboard_check(ord("E"))
// Verifica se está no chão
var no_ar = !place_meeting(x, y+1, oChao);
#endregion

#region MOVIMENTAÇÃO
var move = key_right - key_left // D positivo, A negativo, 0 para
hspd = move * spd;
vspd = vspd + grv;

// Ta andando ?

if (hspd !=0) { 
	image_xscale=sign(hspd);
	estado_sprite=1
}  else if (!no_ar) {
   sprite_index=sPlayer_Andando
}


//COLISÃO HORIZONTAL
if place_meeting(x+hspd,y,oChao)
{ 
while(!place_meeting(x+sign(hspd),y,oChao))
{ 
x = x + sign(hspd)
}
hspd = 0
}
x = x + hspd;
//COLISÃO VERTICAL

if place_meeting(x,y+vspd,oChao){
while(!place_meeting(x,y+sign(vspd),oChao)){
y = y + sign(vspd)}
vspd = 0
}
y = y + vspd
#endregion

#region Pulo
if place_meeting(x,y+1,oChao) and key_jump
{
	vspd -= 8
	estado_sprite = 2 // pulano
}
#endregion

#region Dash para cima
if dash_up && conta_qs < maximo_q {
	sprite_index=sPlayer_DashCima
	estado_sprite = 3 // dashano
    vspd = -13; // Dash vertical
    conta_qs += 1;
} else {
if (!no_ar) {
    conta_qs = 0;// Reseta ao tocar o chão
	 if (hspd == 0) {
        estado_sprite = 0; // Parado
    }
}
}
#endregion


// Controla o sprite que sera exibido de acordo com o estado que foi setado ao longo do programa

switch (estado_sprite) {
    case 0:
       // show_debug_message("Esta parado.");
		//show_debug_message(sprite_index)
		sprite_index=sPlayer_1
        break;
    case 1:
       // show_debug_message("Andando.");
		//show_debug_message(sprite_index)
		sprite_index=sPlayer_Andando
        break;
    case 2:
      //  show_debug_message("Pulano.");
		sprite_index=sPlayer_Andando
        break;
	case 3:
	    // show_debug_message("DASHEI PRA CIMA.");
		 sprite_index=sPlayer_DashCima
		 break;
	case 4:
		// show_debug_message("DASHEI PRO LADO.")
		 sprite_index=sPlayer_DashLado
		 break
	default:
        show_debug_message("Estado desconhecido.");
}

#region Dash de lado

// Inicia o dash se a tecla for pressionada, o contador permitir e não estiver em um dash ativo
if side_dash 
&& (conta_es < maximo_es) 
&& (dash_timer <= 10 and dash_timer <> 0 )
{
    show_debug_message("Iniciando dash lateral!");

    // Define o estado de dash lateral
    sprite_index = sPlayer_DashLado;
    estado_sprite = 4; // Estado de corrida

    hspd = 17 * image_xscale; // Corre na direção que está virado
    conta_es += 1; // Incrementa o contador de dashes


// Mantém o dash ativo por um tempo
	if dash_timer > 0
	{ 
	    dash_timer -= 1;
	    x += hspd; // Continua movendo o personagem enquanto o dash estiver ativo
	}
} 

if side_dash
show_debug_message("timer" + string(dash_timer)+ " conta_es :" + string(conta_es) + string(sprite_index) + string(estado_sprite))	

if (dash_timer <= 0 or conta_es = maximo_es) and not side_dash
{
	    estado_sprite = 0;
		conta_es = 0;
		dash_timer = 10
	    hspd = 0; // Para o movimento do dash
	}
