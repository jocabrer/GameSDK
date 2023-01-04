ChatCommands["!help"] = function(playerId, command)
	Log(">> !help - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId,   "You can use the following commands for help/information: \n " ..
                                                    " !rules (Show info) \n" ..
                                                    " !zone  (Teleport you to the safe zone - 20 Amcoin required) \n" ..
                                                    " !say (Send global messages \n example: !say Hi everyone ) \n" ..
                                                    " !discord (Send discord messages) \n" ..   
                                                    " !setmarker namecustom (Set a personal marker) \n " .. 
                                                    " !removemarker namecustom (Delete marker) \n" );
end

ChatCommands["!rules"] = function(playerId, command)
	Log(">> !rules - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "Forbidden to steal, do not kill other players, do not be rude, do not raid bases, do not run over, we check the logs to see these misconduct");
	
end

ChatCommands["!ayuda"] = function(playerId, command)
	Log(">> !ayuda - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "Puede usar los siguientes comandos para obtener ayuda/información: \n " ..
                                                  " !reglas (Mostrar info.) \n " ..
                                                  " !zona  (Viaje rápido a la Zona Segura - Requiere 20 Amcoin ) \n" ..
	                                              " !say (te permite enviar mensajes globales ejemplo: !say Hola a todos) \n"..
                                                  " !discord (Enviar mensaje al discord) \n "..   
                                                  " !setmarker nombre (Crea un marcador personal) \n " .. 
                                                  " !removemarker nombre (Borrar marcador) \n" );
    
end

ChatCommands["!reglas"] = function(playerId, command)
	Log(">> !reglas - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "Prohibido robar, matar a otros jugadores, no ser grosero, no incursionar en bases, atropellar, nosotros revisamos los logs para ver si se incumplen las reglas");
	
end


