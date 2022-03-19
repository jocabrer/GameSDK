ChatCommands["!help"] = function(playerId, command)
	Log(">> !help - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "You can use the following commands for help / information: !rules !discord !about !admininfo !kiosk !storage !vehicles !basebuilding");
	
end

ChatCommands["!rules"] = function(playerId, command)
	Log(">> !rules - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "Simplified Rules: No bases at military and yellow tents, hayward hotel, hayward airpane, hospital, police, ship, dam, rad zones, woodhaven/brightmoore bunker, gas pumps, and roads. No hacking, racism, sexism. Full rule list on Discord.");
	
end

ChatCommands["!discord"] = function(playerId, command)
	Log(">> !apocdiscord - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "To join the Biohazard Discord, please use the following link https://discord.gg/AyUEEUu");
	
end

ChatCommands["!about"] = function(playerId, command)
	Log(">> !about - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "Join the Discord to get news on the server and events.");
	
end

ChatCommands["!kiosk"] = function(playerId, command)
	Log(">> !kiosk - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "You can create a kiosk in Crafting");
	
end

ChatCommands["!admininfo"] = function(playerId, command)
	Log(">> !admininfo - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "Administrators are players like you. Sometimes we have to perform administrative duties and we will belong to the administrators faction, we have the yellow sign Admin over our heads and we run invisible, usually to remove illegal bases or stop events. (Admin is blocked from killing another player)");
	
end

ChatCommands["!storage"] = function(playerId, command)
	Log(">> !storage - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "The amount of storage is limited to ensure the best gameplay and performance that we can offer.");
	
end

ChatCommands["!vehicles"] = function(playerId, command)
	Log(">> !vehicles - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "To prevent build-up, most vehicles will disappear after 24-48 hours without interaction. Be active if you want to keep your cars! You can keep a maximum of 5 vehicles in 1 base");
	
end

ChatCommands["!basebuilding"] = function(playerId, command)
	Log(">> !basebuilding - %s", command);
	
	g_gameRules.game:SendTextMessage(4, playerId, "Building limit is 400 parts. Refer to rules to see where you can and can't build. If you are unsure, contact an Admin on discord.");
	
end