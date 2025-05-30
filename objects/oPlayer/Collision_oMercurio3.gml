if place_meeting(x,y,oMercurio3)
show_debug_message("uauauauauauuauau0000");
instance_destroy(oMercurio3)
contador=contador+1
if contador=3 {
//global.Qual_Fase = global.Qual_Fase+1
room_goto_next();
}