ChatCommands["!help"] = function(playerId, command)
	Log(">> !help - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "You can use the following commands for help / information: !rules, the command !zone will teleport you to the safe zone, the !say command allows you to send global messages");
	
end

ChatCommands["!rules"] = function(playerId, command)
	Log(">> !rules - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "Forbidden to steal, do not kill other players, do not be rude, do not raid bases, do not run over, we check the logs to see these misconduct");
	
end



ChatCommands["!ayuda"] = function(playerId, command)
	Log(">> !ayuda - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "Puede usar los siguientes comandos para obtener ayuda/información: !reglas, el comando !zona te teletransportará hasta la zona segura, el comando !say te permite enviar mensajes globales");
	
end

ChatCommands["!reglas"] = function(playerId, command)
	Log(">> !reglas - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "Prohibido robar, no matar a otros jugadores, no seas grosero, no incursionar en bases, no atropellar, nosotros revisamos los logs para ver si se incumplen las reglas");
	
end


