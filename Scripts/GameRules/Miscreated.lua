Script.ReloadScript("scripts/gamerules/GameRulesUtils.lua");

Miscreated = {
    Properties = {
        WorldEvent = {
            fMinTime = 700,  -- min time to spawn an event (in seconds)
            fMaxTime = 3600, -- max time to spawn an event (in seconds)
        }
    }
}

GameRulesSetStandardFuncs(Miscreated);

function Miscreated.Server:OnInit()
    self:CreateWorldEventTimer()
end

----------------------------------------------------------------------------------------------------
-- Support for the world events to spawn
----------------------------------------------------------------------------------------------------

function Miscreated:CreateWorldEventTimer()
    --Log("Miscreated.CreateWorldEventTimer")
    Script.SetTimerForFunction(
        randomF(self.Properties.WorldEvent.fMinTime * 1000, self.Properties.WorldEvent.fMaxTime * 1000),
        "SpawnWorldEvent",
        self)
end

SpawnWorldEvent = function(self)
    -- contexto temporal
    local CurrentMonth = os.date('%m')
    local isChristmasSeason = (CurrentMonth == '12' or CurrentMonth == '11')
    local hour = tonumber(os.date('%H')) or 12
    local isNight = (hour >= 21 or hour <= 4)

    -- jugadores (si el engine lo expone)
    local players = 1
    if g_gameRules and g_gameRules.game and g_gameRules.game.GetPlayerCount then
        local pc = g_gameRules.game:GetPlayerCount()
        if type(pc) == "number" and pc > 0 then players = pc end
    end

    -- estado persistente mínimo (sin nuevas funciones)
    Miscreated                = Miscreated or {}
    Miscreated._lastEventName = Miscreated._lastEventName or ""
    Miscreated._streakCount   = Miscreated._streakCount or 0
    Miscreated._lastAt        = Miscreated._lastAt or {} -- por evento
    Miscreated._stats         = Miscreated._stats or
        { AirDropPlane = 0, AirPlaneCrash = 0, UFOCrash = 0, AirDropChristmas = 0, total = 0 }

    -- BASE de pesos (enteros)
    local wAirDrop            = 50
    local wCrash              = 35
    local wUFO                = 15
    local wXmas               = isChristmasSeason and 10 or 0

    -- AJUSTE por noche (UFO sube un poco)
    if isNight then
        wUFO = wUFO + 10
    end

    -- AJUSTE por población (más jugadores => más “show” seguro)
    if players >= 20 then
        wAirDrop = wAirDrop + 10
        wCrash   = wCrash + 5
    elseif players <= 4 then
        wUFO = wUFO + 5
    end

    -- COOLDOWNS simples (segundos)
    local nowSec  = os.time()
    local cdDrop  = 900  -- 15 min
    local cdCrash = 1200 -- 20 min
    local cdUFO   = 1800 -- 30 min
    local cdXmas  = 1200 -- 20 min (solo si temporada)

    if Miscreated._lastAt["AirDropPlane"] and (nowSec - Miscreated._lastAt["AirDropPlane"] < cdDrop) then wAirDrop = 0 end
    if Miscreated._lastAt["AirPlaneCrash"] and (nowSec - Miscreated._lastAt["AirPlaneCrash"] < cdCrash) then wCrash = 0 end
    if Miscreated._lastAt["UFOCrash"] and (nowSec - Miscreated._lastAt["UFOCrash"] < cdUFO) then wUFO = 0 end
    if not isChristmasSeason then
        wXmas = 0
    elseif Miscreated._lastAt["AirDropChristmas"] and (nowSec - Miscreated._lastAt["AirDropChristmas"] < cdXmas) then
        wXmas = 0
    end

    -- ANTI-RACHA: si el mismo evento salió 2+ veces seguidas, castiga su peso
    if Miscreated._streakCount >= 2 then
        if Miscreated._lastEventName == "AirDropPlane" then wAirDrop = math.floor(wAirDrop * 0.2) end
        if Miscreated._lastEventName == "AirPlaneCrash" then wCrash = math.floor(wCrash * 0.2) end
        if Miscreated._lastEventName == "UFOCrash" then wUFO = math.floor(wUFO * 0.2) end
        if Miscreated._lastEventName == "AirDropChristmas" then wXmas = math.floor(wXmas * 0.2) end
    end

    -- si todo quedó en 0 por cooldowns, garantizamos al menos algo
    if (wAirDrop + wCrash + wUFO + wXmas) == 0 then
        wAirDrop = 1 -- airdrop “seguro”
    end

    -- ELECCIÓN ponderada (sin funciones auxiliares)
    local total = wAirDrop + wCrash + wUFO + wXmas
    local pick  = math.random(1, total)
    local eventName

    if pick <= wAirDrop then
        eventName = "AirDropPlane"
    elseif pick <= (wAirDrop + wCrash) then
        eventName = "AirPlaneCrash"
    elseif pick <= (wAirDrop + wCrash + wUFO) then
        eventName = "UFOCrash"
    else
        eventName = "AirDropChristmas"
    end

    -- LOG DEBUG de pesos/elección (útil para balancear)
    Log("WorldEvent pick=" ..
        pick ..
        " total=" ..
        total ..
        " weights AD=" ..
        wAirDrop ..
        " CR=" .. wCrash .. " UFO=" .. wUFO .. " XMAS=" ..
        wXmas .. " night=" .. tostring(isNight) .. " players=" .. tostring(players))

    -- MENSAJES
    if eventName == "AirDropPlane" then
        g_gameRules.game:SendTextMessage(0, 0, "Entrega de Airdrop / Airdrop delivery")
        Log("Miscreated:SpawnWorldEvent - Entrega de Airdrop / Airdrop delivery")
    elseif eventName == "AirPlaneCrash" then
        g_gameRules.game:SendTextMessage(0, 0, "Accidente de Avión / Plane crash")
        Log("Miscreated:SpawnWorldEvent - Accidente de Avión / Plane crash")
    elseif eventName == "UFOCrash" then
        g_gameRules.game:SendTextMessage(0, 0, "UFO detectado / UFO detected")
        Log("Miscreated:SpawnWorldEvent - UFO detectado / UFO detected")
    else -- AirDropChristmas
        g_gameRules.game:SendTextMessage(0, 0, "jojojo Santa detected!")
        Log("Miscreated:SpawnWorldEvent - Santa detected!")
    end

    -- SPAWN
    local spawnParams   = {}
    spawnParams.class   = eventName
    spawnParams.name    = spawnParams.class

    local spawnedEntity = System.SpawnEntity(spawnParams)
    if not spawnedEntity then
        Log("Miscreated:SpawnWorldEvent - entity could not be spawned")
    end

    -- actualizar estado (streak, lastAt, stats)
    if eventName == Miscreated._lastEventName then
        Miscreated._streakCount = Miscreated._streakCount + 1
    else
        Miscreated._streakCount = 1
    end
    Miscreated._lastEventName = eventName
    Miscreated._lastAt[eventName] = nowSec

    Miscreated._stats[eventName] = (Miscreated._stats[eventName] or 0) + 1
    Miscreated._stats.total = (Miscreated._stats.total or 0) + 1

    -- cada 10 eventos, imprime distribución (%) para tus “estadísticas”
    if (Miscreated._stats.total % 10) == 0 then
        local t = Miscreated._stats.total
        local pa = math.floor((Miscreated._stats.AirDropPlane * 100) / t)
        local pc = math.floor((Miscreated._stats.AirPlaneCrash * 100) / t)
        local pu = math.floor((Miscreated._stats.UFOCrash * 100) / t)
        local px = math.floor((Miscreated._stats.AirDropChristmas * 100) / t)
        Log(string.format("WorldEventStats T=%d AD=%d%% CR=%d%% UFO=%d%% XMAS=%d%%", t, pa, pc, pu, px))
    end

    -- siguiente evento
    self:CreateWorldEventTimer()
end



----------------------------------------------------------------------------------------------------
-- Support for custom chat command mods
----------------------------------------------------------------------------------------------------

-- Table for custom chat commands to use
ChatCommands = {}

-- Load custom chat commands (mods)
Script.LoadScriptFolder("Scripts/GameRules/ChatCommands", true, true)

-- Receives all unhandled, by the core game, chat commands
-- Do not add custom chat commands directly here
-- Add new chat commands to a file in the Scripts/GameRules/ChatCommands folder,
-- so they can be uploaded as mods to Steam
function Miscreated:ChatCommand(playerId, command)
    --Log(">> Miscreated:ChatCommand");

    -- player is an entity
    local player = System.GetEntity(playerId)

    if not player.actor then
        Log("Miscreated:ChatCommand - playerId is not a valid player")
        return
    end

    -- Find the requested chat command and execute it
    local index = string.find(command, " ")

    if not index then
        if ChatCommands[command] then
            ChatCommands[command](playerId, "")
        end
    else
        local cmd = string.sub(command, 1, index - 1)
        if ChatCommands[cmd] then
            ChatCommands[cmd](playerId, string.sub(command, index + 1))
        end
    end
end

----------------------------------------------------------------------------------------------------
-- Support for custom player spawns
----------------------------------------------------------------------------------------------------

-- See BattleRoyale.lua for a more complete example of the following 3 methods

--[[
-- Initialize the player
-- Use this to initialize the player before the server respawns the player
-- Any change to the player's position and rotation would have to be done here
function Miscreated:InitPlayer(playerId)
	--Log(">> Miscreated:InitPlayer");
end
--]]

--[[
-- This is called when the character is being revived by the server
-- Set player stats here - only default CryEngine stats are currently exposed, like health
function Miscreated:RevivePlayer(playerId)
	--Log(">> Miscreated:RevivePlayer");
end
--]]

-- If this method is defined, then Miscreated will ONLY spawn items for a new or respawned
-- player based on the code below.
-- This is called after the player starts the spawning process
-- Add any custom equipment or other finalizing touches here
--[[
function Miscreated:EquipPlayer(playerId)
	--Log(">> Miscreated:EquipPlayer");
	
	-- Get the entity for the player
	local player = System.GetEntity(playerId);

	-- Verify the player is of type "player" - sanity check
	if (player and player.player) then

		-- Give an AT15 to playerId into whatever slot is available and have the player select it
		local weapon = ISM.GiveItem(playerId, "AT15", true);

		-- Add a STANAGx30 to playerId into the stanag_mag00 slot of the AT15
		-- Slot names can be found in the item XML files and they start at index 00 and increment up from there
		local accessory = ISM.GiveItem(playerId, "STANAGx30", false, weapon.id, "stanag_mag00");
	end
end
--]]
