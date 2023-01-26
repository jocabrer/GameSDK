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
	
	g_gameRules.game:SendTextMessage(4, playerId, "It is expected that all players respect the server's rules of coexistence, \n " ..
                                                  "this includes being respectful and considerate of other players, \n " ..
                                                  "not using offensive or discriminatory language, \n " .. 
                                                  "and not promoting inappropriate or illegal behavior. \n " .. 
                                                  "Full rules in discord atw.cl/mis");
	
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
	
	g_gameRules.game:SendTextMessage(4, playerId, "Se espera que todos los jugadores respeten las reglas de convivencia en el servidor,\n " ..
                                                  "esto incluye ser respetuoso y considerado con los demás jugadores, \n " ..
                                                  "no utilizar lenguaje ofensivo o discriminatorio, \n " ..
                                                  "y no promover conductas inapropiadas o ilegales. \n " .. 
                                                  "Reglas completas en discord atw.cl/mis");
	
end


