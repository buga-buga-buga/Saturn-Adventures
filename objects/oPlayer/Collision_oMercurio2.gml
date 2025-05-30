if place_meeting(x,y,oMercurio2)
show_debug_message("uauauauauauuauau0000");
instance_destroy(oMercurio2)
contador=contador+1
if contador=3
room_goto_next();instance_destroy(oMercurio2)