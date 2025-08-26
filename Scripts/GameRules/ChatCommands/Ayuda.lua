ChatCommands = ChatCommands or {}

-- ==== EN ====
local function _help_en(playerId, command)
    Log(string.format(">> !help - %s", tostring(command)))
    g_gameRules.game:SendTextMessage(4, playerId,
        "Cmds:\n" ..
        "!rules\n" ..
        "!zone (20 AMC)\n" ..
        "!say <msg>\n" ..
        "!discord\n" ..
        "!setmarker <n>\n" ..
        "!removemarker <n>"
    )
end

local function _rules_en(playerId, command)
    Log(string.format(">> !rules - %s", tostring(command)))
    g_gameRules.game:SendTextMessage(4, playerId,
        "Rules:\n" ..
        "- Respect others\n" ..
        "- No insults/discrim.\n" ..
        "- No illegal acts\n" ..
        "Full: atw.cl/mis"
    )
end

ChatCommands["!help"]  = _help_en
ChatCommands["/help"]  = _help_en
ChatCommands["help"]   = _help_en
ChatCommands["!rules"] = _rules_en
ChatCommands["/rules"] = _rules_en
ChatCommands["rules"]  = _rules_en

-- ==== ES ====
local function _help_es(playerId, command)
    Log(string.format(">> !ayuda - %s", tostring(command)))
    g_gameRules.game:SendTextMessage(4, playerId,
        "Comandos:\n" ..
        "!reglas\n" ..
        "!zona (20 AMC)\n" ..
        "!say <texto>\n" ..
        "!discord\n" ..
        "!setmarker <nombre>\n" ..
        "!removemarker <nombre>"
    )
end

local function _rules_es(playerId, command)
    Log(string.format(">> !reglas - %s", tostring(command)))
    g_gameRules.game:SendTextMessage(4, playerId,
        "Reglas:\n" ..
        "- Respeta a otros\n" ..
        "- Sin insultos/discrim.\n" ..
        "- No actos ilegales\n" ..
        "Completo: atw.cl/mis"
    )
end

ChatCommands["!ayuda"]  = _help_es
ChatCommands["/ayuda"]  = _help_es
ChatCommands["ayuda"]   = _help_es
ChatCommands["!reglas"] = _rules_es
ChatCommands["/reglas"] = _rules_es
ChatCommands["reglas"]  = _rules_es
