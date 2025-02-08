-- Created mutually by -4iY- and Theros
-----------
--[[ -- Changelog Start
	! Originally created by -4iY- on the 6th of June 2020
	! Changed: 02/09/2020 [Theros]
	? Modified to Read valid steamIds from a textfile in ServerRoot, avoids the need for users to repackage the mod for their own use
	* added: Method IsAdminPlayer
	* removed: all occurences of `local allowCommand = string.find(AllowedIds, steamid)`
	* changed: all occurences of `if allowCommand then` to `if IsAdminPlayer(steamid) then`

	! Changed:09/09/2020 [Theros]
	? general code cleanup and fixes.
	* fixed: ufo/airdop commands didnt actualy spawn anything (also added ingame response)
	* added: base_owner command, originaly suggested by snake

--]] -- Changelog End
--
-- ───────────────────────────────────────────────────────────── CHATCOMMANDS ─────
--
ChatCommands['!ban'] = function(playerId, command)
    -- Log the command execution
    Log('>> !ban - %s', command)
    -- Gets PlayerID of the invoker
    local player = System.GetEntity(playerId)
    -- Gets SteamID of the invoker
    local steamid = player.player:GetSteam64Id()

    -- Matches the ID to the Admin ID table
    if IsAdminPlayer(steamid) then
        -- Execute the rcon command
        System.ExecuteCommand('mis_ban_steamid ' .. command)
        -- If not in the list
    else
        g_gameRules.game:SendTextMessage(4, playerId,
                                         'You do not have permission to use this command!');
    end
end

ChatCommands['!unban'] = function(playerId, command)
    -- Log the command
    Log('>> !unban - %s', command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        -- Execute the rcon command
        System.ExecuteCommand('mis_ban_remove ' .. command)
        -- If not in the list
    else
        g_gameRules.game:SendTextMessage(4, playerId,
                                         'You do not have permission to use this command!');
    end
end

ChatCommands['!kick'] = function(playerId, command)
    -- Log the command
    Log('>> !kick - %s', command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        -- Execute the rcon command
        System.ExecuteCommand('mis_kick ' .. command)
        -- If not in the list
    else
        g_gameRules.game:SendTextMessage(4, playerId,
                                         'You do not have permission to use this command!');
    end
end

ChatCommands['!base_owner'] = function(playerId, command)
    Log('>> !base_owner - %s', command);

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then

        local plotSignId = player.player:GetActivePlotSignId()

        plotSignId = player.player:GetActivePlotSignId()
        b = System.GetEntity(plotSignId)
    end

    if b then ownerID = b.plotsign:GetOwnerSteam64Id() end
    g_gameRules.game:SendTextMessage(4, playerId, b.plotsign:GetOwnerSteam64Id());

end

ChatCommands['!bases_dump'] = function(playerId, command)
    Log('>> !bases_dump - %s', command);

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        local bases = BaseBuildingSystem.GetPlotSigns()

        for i, b in pairs(bases) do

            local numParts = b.plotsign:GetPartCount()
            Log('Base - index: %d, numParts: %d', i, numParts)

            if numParts > 0 then
                for p = 0, numParts - 1 do
                    local partId = b.plotsign:GetPartId(p)

                    local canPackUp = 1
                    if (not b.plotsign:CanPackUp(partId)) then
                        canPackUp = 0;
                    end

                    Log(
                        'Id: %d, TypeId: %d, ClassName: %s, CanPackUp: %d, MaxHealth: %f, Damage: %f',
                        partId, b.plotsign:GetPartTypeId(partId),
                        b.plotsign:GetPartClassName(partId), canPackUp,
                        b.plotsign:GetMaxHealth(partId),
                        b.plotsign:GetDamage(partId))
                end
            end
        end
    end
end

ChatCommands['!base_delete'] = function(playerId, command)
    Log('>> !base_delete - %s', command);

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        local plotSignId = player.player:GetActivePlotSignId()

        if plotSignId then
            local b = BaseBuildingSystem.GetPlotSign(plotSignId)

            if b then
                -- Iterate through all the parts and delete them
                while b.plotsign:GetPartCount() > 0 do
                    local partId = b.plotsign:GetPartId(0)
                    b.plotsign:DeletePart(partId)
                end

                -- Delete the actual plot sign
                b.plotsign:DeletePart(-1)
            end
        end
    end
end

--[[
    ! Updated: 27/01/2021 12:19:57 [Theros]
    ? Implemented handling multiple items and item sets using mSpawnTools
]]

-- !give <item_name>
-- Gives the <item_name> to the invoking player and it will appear in their inventory
-- <item_name> can be any valid item name in the game -ex. AT15
ChatCommands['!give'] = function(playerId, command)
    Log('>> !give - %s', command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        local allGiven, result = mSpawnTools:GiveItemSet(playerId, command)
        if not allGiven then
            if result then
                g_gameRules.game:SendTextMessage(4, playerId, result);
            end
        end
    end
    g_gameRules.game:SendTextMessage(4, playerId, command);
end

-- !givestack <item_name>
-- Gives the <item_name> as a full stack if stackable or magazine
-- <item_name> can be any valid item name in the game -ex. Lumber
-- you can spawn multiple stacks by delimiteing classnames with `;`
-- eg: !givestack Lumber;Lumber;Lumber
ChatCommands["!givestack"] = function(playerId, command)
    local player = System.GetEntity(playerId)
    local steamId = player.player:GetSteam64Id()
    if IsAdminPlayer(steamId) then

        -- Assign `;` delimited command to a table
        local items = {}
        for c in (command .. ";"):gmatch("([^;]*);") do
            table.insert(items, c)
        end
        for i, v in pairs(items) do
            g_gameRules.game:SendTextMessage(4, playerId, v);
            -- Add the item requested to the invoking players inventory
            local item = ISM.GiveItem(playerId, v, false)
            if item then
                if item.item:IsStackable() or item.item:IsMagazine() then
                    item.item:SetStackCount(item.item:GetMaxStackSize())
                end
                if item.item:IsDestroyable() then
                    item.item:SetHealth(item.item:GetMaxHealth())
                end
            end
        end
    end
end

-- !heal
-- Heals the player to full health
ChatCommands['!heal'] = function(playerId, command)
    Log('>> !heal - %s', command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then player.actor:SetHealth(100.0); end
    g_gameRules.game:SendTextMessage(4, playerId, command);
end

-- Sends the message <message> to the entire server in the chat window
ChatCommands['!wmsg'] = function(playerId, command)
    Log('>> !wmsg - %s', command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        g_gameRules.game:SendTextMessage(4, 0, command);
    end
end

-- Sends the message <message> to the entire server at the top of the screen
ChatCommands['!wann'] = function(playerId, command)
    Log('>> !wann - %s', command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        g_gameRules.game:SendTextMessage(0, 0, command);
    end
end

-- Send the player's position back to them via chat
ChatCommands['!mypos'] = function(playerId, command)
    Log('>> !mypos - %s', command);
    -- Change Faction to what ever faction can use this command
    -- local allowCommand = 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)
    local player = System.GetEntity(playerId)
    local pos = player:GetWorldPos()
    -- end
    g_gameRules.game:SendTextMessage(4, playerId, string.format(
                                         'Your position is: %.1f %.1f %.1f',
                                         pos.x, pos.y, pos.z));
end

-- !jf | Joins a faction without the need of a restart
ChatCommands['!jf'] = function(playerId, command)
    Log('>> !jf - %s', command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        player.actor:SetFaction(tonumber(command), true)
    end
end

-- !rcon
-- Execute console command on server
ChatCommands['!rcon'] = function(playerId, command)
    Log('>> !rcon - %s', command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then System.ExecuteCommand(command) end
end

ChatCommands['!spawn'] = function(playerId, command)
    Log('>> !spawn - %s', command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        local vForwardOffset = {x = 0, y = 0, z = 0}
        FastScaleVector(vForwardOffset, player:GetDirectionVector(), 2.0)

        local vSpawnPos = {x = 0, y = 0, z = 0}
        FastSumVectors(vSpawnPos, vForwardOffset, player:GetWorldPos())

        ISM.SpawnItem(command, vSpawnPos)
    end
end

ChatCommands['!spawnent'] = function(playerId, command)
    Log('>> !spawnent - %s', command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        local vForwardOffset = {x = 0, y = 0, z = 0}
        FastScaleVector(vForwardOffset, player:GetDirectionVector(), 2.0)

        local vSpawnPos = {x = 0, y = 0, z = 0}
        FastSumVectors(vSpawnPos, vForwardOffset, player:GetWorldPos())

        local spawnParams = {}

        spawnParams.class = command

        spawnParams.name = spawnParams.class
        spawnParams.position = vSpawnPos

        Log('Spawning - %s', command)

        local spawnedEntity = System.SpawnEntity(spawnParams)

        if not spawnedEntity then Log('could not be spawned') end
    end
end

-- Summon a player by SteamId to your position
ChatCommands['!summon'] = function(playerId, command)
    Log('>> !summon - %s', command);

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        -- Performing a generic entity search is very expensive - use sparingly
        local players = System.GetEntitiesByClass('Player')

        for i, p in pairs(players) do
            if p.player:GetSteam64Id() == command then
                p.player:TeleportTo(playerId)
                return;
            end
        end
    end
    g_gameRules.game:SendTextMessage(4, playerId,
                                     'A player with the SteamID does not exist on the server.');
end

-- Moderator To Player
ChatCommands["!tplayer"] = function(playerId, command)
	
    Log(">> !tplayer - %s", command);

	local player = System.GetEntity(playerId)
  
    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
    
        local players = System.GetEntitiesByClass("Player")

        for i,p in pairs(players) do 
            if p.player:GetSteam64Id() == command then
                --p.player:TeleportTo(playerId)
                local vForwardOffset = {x=0,y=0,z=0}
                FastScaleVector(vForwardOffset, p:GetDirectionVector(), -2.0)

                local vSpawnPos = {x=0,y=0,z=0}
                FastSumVectors(vSpawnPos, vForwardOffset, p:GetWorldPos())


                player.player:TeleportTo(vSpawnPos);
                return;
            end
        end
	g_gameRules.game:SendTextMessage(4, playerId, "A player with the SteamId does not exist on the server.");
    end
end

-- Teleport to a position
ChatCommands['!tp'] = function(playerId, command)
    Log('>> !tp - %s', command);

    local player = System.GetEntity(playerId)

    local steamId = player.player:GetSteam64Id()

    if IsAdminPlayer(steamId) then
        local steamid = player.player:GetSteam64Id();

        if command == 'base' then
            local bases = BaseBuildingSystem.GetPlotSigns();

            for i, b in pairs(bases) do
                if b.plotsign:GetOwnerSteam64Id() == steamId then
                    player.player:TeleportTo(b:GetWorldPos());
                    return;
                end
            end
            g_gameRules.game:SendTextMessage(4, playerId,
                                             'You do not have a base on this server.');
        else
            player.player:TeleportTo(command);
        end
    end
end

-- !time
-- Changes Time of Day/Night on the server (by number)
ChatCommands['!time'] = function(playerId, command)
    Log('>> !time - %s', command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        System.ExecuteCommand('wm_forceTime ' .. command)
        -- g_gameRules.game:SendTextMessage(0, 0, playerid, command);
        -- g_gameRules.game:SendTextMessage(4, playerId, string.format("Your position is: %.1f %.1f %.1f", pos.x, pos.y, pos.z));
    end
end

-- !weather
-- Starts any of the weather pattern on the server (by number or name)
ChatCommands['!weather'] = function(playerId, command)
    Log('>> !weather - %s', command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        System.ExecuteCommand('wm_startPattern ' .. command)
    end
end

-- !ufo | Spawns UFO crash event
ChatCommands['!ufo'] = function(playerId, command)

    local player = System.GetEntity(playerId)
    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        local spawnParams = {}
        spawnParams.class = 'UFOCrash'
        spawnParams.name = spawnParams.class

        local vForwardOffset = {x = 0, y = 0, z = 0}
        FastScaleVector(vForwardOffset, player:GetDirectionVector(), 2.0)

        local vSpawnPos = {x = 0, y = 0, z = 0}
        FastSumVectors(vSpawnPos, vForwardOffset, player:GetWorldPos())
        spawnParams.position = vSpawnPos

        --- try to spawn the entity
        local spawnedEntity = System.SpawnEntity(spawnParams)
        if not spawnedEntity then
            g_gameRules.game:SendTextMessage(0, 0, playerId, string.format(
                                                 'Failed to spawn: %s',
                                                 spawnParams.class));
        else
            local pos = spawnedEntity:GetPos()
            g_gameRules.game:SendTextMessage(4, playerId,
                                             string.format(
                                                 'Success spawning %s @ %.1f %.1f %.1f',
                                                 spawnParams.class, pos.x,
                                                 pos.y, pos.z));
        end
    end
end

-- !planecrash | Spawns a plane crash event
ChatCommands['!planecrash'] = function(playerId, command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        local spawnParams = {}
        spawnParams.class = 'AirPlaneCrash'
        spawnParams.name = spawnParams.class

        local vForwardOffset = {x = 0, y = 0, z = 0}
        FastScaleVector(vForwardOffset, player:GetDirectionVector(), 2.0)

        local vSpawnPos = {x = 0, y = 0, z = 0}
        FastSumVectors(vSpawnPos, vForwardOffset, player:GetWorldPos())
        spawnParams.position = vSpawnPos

        --- try to spawn the entity
        local spawnedEntity = System.SpawnEntity(spawnParams)
        if not spawnedEntity then
            g_gameRules.game:SendTextMessage(0, 0, playerId, string.format(
                                                 'Failed to spawn: %s',
                                                 spawnParams.class));
        else
            local pos = spawnedEntity:GetPos()
            g_gameRules.game:SendTextMessage(4, playerId,
                                             string.format(
                                                 'Success spawning %s @ %.1f %.1f %.1f',
                                                 spawnParams.class, pos.x,
                                                 pos.y, pos.z));
        end
    end
end

-- !airdrop | Spawns airdrop
ChatCommands['!airdrop'] = function(playerId, command)

    local player = System.GetEntity(playerId)

    local steamid = player.player:GetSteam64Id()

    if IsAdminPlayer(steamid) then
        local spawnParams = {}
        spawnParams.class = 'AirDropPlane'
        spawnParams.name = spawnParams.class

        local vForwardOffset = {x = 0, y = 0, z = 0}
        FastScaleVector(vForwardOffset, player:GetDirectionVector(), 2.0)

        local vSpawnPos = {x = 0, y = 0, z = 0}
        FastSumVectors(vSpawnPos, vForwardOffset, player:GetWorldPos())
        spawnParams.position = vSpawnPos

        --- try to spawn the entity
        local spawnedEntity = System.SpawnEntity(spawnParams)
        local msg
        if not spawnedEntity then
            msg = string.format('Failed to spawn: %s', spawnParams.class)
            g_gameRules.game:SendTextMessage(0, playerId, msg)
        else
            local pos = spawnedEntity:GetPos()
            msg = string.format('Success spawning %s @ %.1f %.1f %.1f',
                                spawnParams.class, pos.x, pos.y, pos.z)

            g_gameRules.game:SendTextMessage(4, playerId, msg)
        end

    end
end


-- Teleport to a position
ChatCommands["!tele"] = function(playerId, command)
    Log(">> !tele - %s", command);
    local airfield = "2400 725 35" 
    local brightmoore = "5375 2250 25" 
    local bunkerbig = "1686 5369 370" 
    local bunkersmall = "5142 3297 30" 
    local capebay = "7322 4877 47" 
    local clydehill = "4742 4746 140" 
    local dam = "5855 4600 195" 
    local hayward = "3806 6075 25" 
    local horseshoe = "1053 2217 38" 
    local hospital = "1653 7058 29" 
    local paint = "1800 6530 43" 
    local pinecrest = "3845 1575 30" 
    local podunk = "2747 6999 28" 
    local rockyripple = "1411 1560 35" 
	local safezone = "4913 4717 142" 
    local suburbs = "3950 5350 19" 
    local sultan = "2155 2000 38" 
    local turtlebay = "425 4156 25" 
    local woodhaven = "1770 3470 39" 
    local player = System.GetEntity(playerId);
    local steamid = player.player:GetSteam64Id()
	

    if IsAdminPlayer(steamid) then
        local steamid = player.player:GetSteam64Id();

        if command == "base" then
            local bases = BaseBuildingSystem.GetPlotSigns();

            for i,b in pairs(bases) do 
                if b.plotsign:GetOwnerSteam64Id() == steamId then
                    player.player:TeleportTo(b:GetWorldPos());
                    return;
                end
            end
            g_gameRules.game:SendTextMessage(4, playerId, "You do not have a base on this server.");

        elseif command == "aeropuerto" then
            player.player:TeleportTo(airfield);
        elseif command == "brightmoore" then
            player.player:TeleportTo(brightmoore);
        elseif command == "bunkerbig" then
            player.player:TeleportTo(bunkerbig);
        elseif command == "bunkersmall" then
            player.player:TeleportTo(bunkersmall);
        elseif command == "capebay" then
            player.player:TeleportTo(capebay);
        elseif command == "clydehill" then
            player.player:TeleportTo(clydehill);
        elseif command == "dam" then
            player.player:TeleportTo(dam);
        elseif command == "hayward" then
            player.player:TeleportTo(hayward);
        elseif command == "horseshoe" then
            player.player:TeleportTo(horseshoe);
        elseif command == "hospital" then
            player.player:TeleportTo(hospital);
        elseif command == "paint" then
            player.player:TeleportTo(paint);
        elseif command == "pinecrest" then
            player.player:TeleportTo(pinecrest);
        elseif command == "podunk" then
            player.player:TeleportTo(podunk);
        elseif command == "rockyripple" then
            player.player:TeleportTo(rockyripple);
		elseif command == "safezone" then
            player.player:TeleportTo(safezone);
        elseif command == "suburbs" then
            player.player:TeleportTo(suburbs);
        elseif command == "sultan" then
            player.player:TeleportTo(sultan);
        elseif command == "turtlebay" then
            player.player:TeleportTo(turtlebay);
        elseif command == "woodhaven" then
            player.player:TeleportTo(woodhaven);
        else
            player.player:TeleportTo(command);
        end
    end
end
--[[
    ! Updated: 27/01/2021 12:19:57 [Theros]
    ? Implemented SpawnVehical Command [based on Cuartas method, updated to handle skin name not crc32str]
]]

ChatCommands["!spawnvehicle"] = function(playerId, command)
    local player = System.GetEntity(playerId);
    local steamid = player.player:GetSteam64Id()
    if IsAdminPlayer(steamid) then
        local vehiclename = ""
        local skin = ""
        -- Determines if the command has a skin
        -- you must provide a valid skin name, just don't type the skin
        local cmd = string.split(command)
        if cmd and table_size(cmd) == 2 then
            vehiclename = cmd[1]
            skin = cmd[2]
        else
            vehiclename = command
        end
        -- convert the skin name to Crc32str
        if skin ~= "" and (not isSkinCrc32(skin)) then
            skin = getSkinCrc32(skin) or ""
        end

        -- Get a coordinate 5m in front of the player
        local vForwardOffset = {x = 0, y = 0, z = 0};
        local vPointingPosition = {x = 0, y = 0, z = 0};
        FastScaleVector(vForwardOffset, player:GetDirectionVector(), 5.0);
        FastSumVectors(vPointingPosition, vForwardOffset, player:GetWorldPos());

        -- Set the vehicle parameters
        local spawnParams = {};
        spawnParams.class = vehiclename;
        spawnParams.orientation = player:GetDirectionVector();
        spawnParams.position = vPointingPosition;

        -- Spawn the vehicle, it wont persist through server restarts though
        vehicle = System.SpawnEntity(spawnParams);

        -- Set oil and fuel to 100% and the skin in case one was provided
        vehicle.vehicle:ReadOrRestoreJSON(true, '{"skin":"' .. skin ..
                                              '","dieselfuel":1000000,"oil":600000,"is":{"cats":[{"carbattery":[{"slot":0,"name":"CarBattery","health":100}]},{"drivebelt":[{"slot":0,"name":"DriveBelt","health":100}]},{"sparkplugs":[{"slot":0,"name":"SparkPlugs","health":100}]},{"wheel":[{"slot":0,"name":"Wheel"},{"slot":1,"name":"Wheel"},{"slot":2,"name":"Wheel"},{"slot":3,"name":"Wheel"}]}]}}',
                                          false);
        -- Give some extra items to the vehicle's inventory, Oil and a Jerry can
        ISM.GiveItem(vehicle.id, 'Oil');
        local gas = ISM.GiveItem(vehicle.id, 'JerryCanDiesel');
        gas.item:SetConsumablePercent(100);
        gas.item:SetConsumableType(0);
    end
end
--
-- ─── END CHATCOMMANDS ───────────────────────────────────────────────────────────
--
