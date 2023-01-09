-- SCAAM Clan Respawner Mod v1.0.7
-- Created by Cuartas

-- Flag to determine if the UI is open or not
SCAAMClanRespawnerInitialized = false;

-- Repawner timers for players
SCAAMClanRespawnerPlayers = {};

-- Respawner timer config
SCAAMClanRespawnerTimer = nil;

-- Validating if Miscreated:RevivePlayer is set
if not (Miscreated.RevivePlayer) then
    Miscreated.RevivePlayer = function (self, playerId)
        Log('SCAAMClanRespawnerMod >> Setting a generic Miscreated:RevivePlayer to make it exist');
    end
end

-- SCAAMClanRespawnerPreInitModules
-- Manage UI reload stuff
function SCAAMClanRespawnerPreInitModules()
    if (not CryAction.IsDedicatedServer()) then
        Log('SCAAMClanRespawnerMod >> Called client UI init from not IsDedicatedServer');
        ReloadModUIOnlyOnce();
    end
end

-- SCAAMClanRespawnerInitModules
-- Manage storage stuff (Based on Theros' mFramework)
function SCAAMClanRespawnerInitModules()
    SCAAMClanRespawnerJSON = require('JSON');
    SCAAMClanRespawnerPlayerDatabase = mFramework.PersistantStorage:Collection('SCAAMClanRespawnerPlayerCollection');
    SCAAMClanRespawnerConfigDatabase = mFramework.PersistantStorage:Collection('SCAAMClanRespawnerConfigCollection');

    -- Sets the config a first time if there's none
    SCAAMClanRespawnerTimer = SCAAMClanRespawnerConfigDatabase:GetPage('respawn_timer', 180);

    if (SCAAMClanRespawnerTimer == nil) then
        SCAAMClanRespawnerTimer = SCAAMClanRespawnerConfigDatabase:SetPage('respawn_timer', 180);
    end
end

--------------------------------------------------------------------------
---------------------------- CUSTOM UI SCRIPTS ---------------------------
--------------------------------------------------------------------------

SCAAMClanRespawnerUIFunctions = {};

-- SCAAMClanRespawnerUIFunctions:ToggleTheClanRespawner
-- Toggles the respawn UI when the player dies
function SCAAMClanRespawnerUIFunctions:ToggleTheClanRespawner(toggle, data)
    local player = System.GetEntity(g_localActorId);

    if (toggle == true) then
        self.SCAAMClanRespawnerData = data;
        Script.SetTimerForFunction(3000, 'SCAAMClanRespawnerUIFunctions.ToggleTheClanRespawnerAfterDelay', self);
        SCAAMClanRespawnerInitialized = true;
    else
        if (SCAAMClanRespawnerInitialized and SCAAMClanRespawnerInitialized == true) then
            UIAction.ReloadElement('mod_SCAAMClanRespawnerUI', 0)
            UIAction.HideElement('mod_SCAAMClanRespawnerUI', 0);
            UIAction.UnregisterElementListener(self, 'mod_SCAAMClanRespawnerUI', 0, 'onRespawnClanmate', 'RespawnInClanmate');
            SCAAMClanRespawnerInitialized = false;
        end
    end
end

-- SCAAMClanRespawnerUIFunctions:ToggleTheClanRespawnerAfterDelay
-- Toggles the respawn UI when the player dies after a delay
function SCAAMClanRespawnerUIFunctions:ToggleTheClanRespawnerAfterDelay()
    UIAction.ShowElement('mod_SCAAMClanRespawnerUI', 0);
    UIAction.CallFunction('mod_SCAAMClanRespawnerUI', 0, 'FillRespawnData', self.SCAAMClanRespawnerData);
    UIAction.RegisterElementListener(self, 'mod_SCAAMClanRespawnerUI', 0, 'onRespawnClanmate', 'RespawnInClanmate');
end

-- SCAAMClanRespawnerUIFunctions:RespawnInClanmate
-- Sets the spawner to a clanmate's bed
function SCAAMClanRespawnerUIFunctions:RespawnInClanmate()
    local player = System.GetEntity(g_localActorId);
    local theClanmateSteamId = UIAction.GetVariable('mod_SCAAMClanRespawnerUI', 0, 'SteamIdSelected');
    mSendEvent(
        'Server',
        {
            Type = 'SCAAMCRSetRespawn',
            Data = {clanmateSteamId = theClanmateSteamId}
        },
        false,
        false
    );
end

--------------------------------------------------------------------------
-------------------------- CUSTOM UI SCRIPTS END -------------------------
--------------------------------------------------------------------------

-- SCAAMClanRespawnerSetRespawn
-- Sets the player's respawn to a clanmate's bed
function SCAAMClanRespawnerSetRespawn(playerId, clanmateSteamId)
    local player = System.GetEntity(playerId);
    local playerChannel = player.actor:GetChannel();
    local steamId = player.player:GetSteam64Id();

    -- Checks if a clanmate bed spawn was selected
    if (clanmateSteamId ~= '') then

        -- Checks if the player spawned previously and the waiting timer expired, if not, players can't pick
        -- A clanmate's bed spawn
        if (SCAAMClanRespawnerPlayers[steamId] and SCAAMClanRespawnerPlayers[steamId].SpawnedTime) then
            local timeDifference = os.clock() - SCAAMClanRespawnerPlayers[steamId].SpawnedTime;

            if (timeDifference < SCAAMClanRespawnerTimer) then

                -- Deselects the selected option in the UI
                mSendEvent(
                    player.id,
                    {
                        Type = 'SCAAMCRDisableSelected',
                        Data = {dummyData = ''}
                    },
                    false,
                    false
                );

                if (System.IsEditor()) then
                    g_gameRules.game:SendTextMessage(0, g_localActorId, "You must wait " .. tostring(math.floor(SCAAMClanRespawnerTimer - timeDifference)) .. " seconds before spawning in a clanmate's bed");
                else
                    g_gameRules.game:SendTextMessage(0, playerId, "You must wait " .. tostring(math.floor(SCAAMClanRespawnerTimer - timeDifference)) .. " seconds before spawning in a clanmate's bed");
                end
                return;
            end
        end

        -- Get the bases in the server
        local bases = BaseBuildingSystem.GetPlotSigns();

        -- Loops through the bases in the server
        for i, b in pairs(bases) do 
            if (b.plotsign:GetOwnerSteam64Id() == clanmateSteamId) then
                local numParts = b.plotsign:GetPartCount();

                if (numParts > 0) then
                    for p = 0, numParts - 1, 1 do
                        local partId = b.plotsign:GetPartId(p);

                        -- Crafted bed for the spawn
                        if (b.plotsign:GetPartTypeId(partId) == 5070) then
                            if (SCAAMClanRespawnerPlayers[steamId] == nil) then
                                local respawnData = {
                                    SpawnSelected = clanmateSteamId
                                };
                    
                                SCAAMClanRespawnerPlayers[steamId] = respawnData;
                            else
                                SCAAMClanRespawnerPlayers[steamId].SpawnSelected = clanmateSteamId;
                            end

                            if (System.IsEditor()) then
                                g_gameRules.game:SendTextMessage(0, g_localActorId, "Your spawn point has been set to this clanmate's bed");
                            else
                                g_gameRules.game:SendTextMessage(0, playerId, "Your spawn point has been set to this clanmate's bed");
                            end
                            return;
                        end
                    end
                end

                -- Deselects the selected option in the UI
                mSendEvent(
                    player.id,
                    {
                        Type = 'SCAAMCRDisableSelected',
                        Data = {dummyData = ''}
                    },
                    false,
                    false
                );

                if (System.IsEditor()) then
                    g_gameRules.game:SendTextMessage(0, g_localActorId, 'A bed was not found in the base');
                else
                    g_gameRules.game:SendTextMessage(0, playerId, 'A bed was not found in the base');
                end
                return;
            end
        end

        -- Deselects the selected option in the UI
        mSendEvent(
            player.id,
            {
                Type = 'SCAAMCRDisableSelected',
                Data = {dummyData = ''}
            },
            false,
            false
        );

        if (System.IsEditor()) then
            g_gameRules.game:SendTextMessage(0, g_localActorId, "There's no base to respawn in");
        else
            g_gameRules.game:SendTextMessage(0, playerId, "There's no base to respawn in");
        end
    else

        -- Unsets a clanmate's bed spawn
        SCAAMClanRespawnerPlayers[steamId].SpawnSelected = nil;

        if (System.IsEditor()) then
            g_gameRules.game:SendTextMessage(0, g_localActorId, 'Spawn point unset');
        else
            g_gameRules.game:SendTextMessage(0, playerId, 'Spawn point unset');
        end
    end
end

-- !SCAAMCRchangetimer <subcommand>
-- Uses the !SCAAMCRchangetimer command to change the timer to be able to respawn in a clanmate's bed
ChatCommands["!SCAAMCRchangetimer"] = function(playerId, command)
    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    if (string.match(System.GetCVar('g_gameRules_faction6_steamids'), steamId)) then
        SCAAMClanRespawnerTimer = tonumber(command);
        SCAAMClanRespawnerConfigDatabase:SetPage('respawn_timer', SCAAMClanRespawnerTimer);

        if (System.IsEditor()) then
            g_gameRules.game:SendTextMessage(0, g_localActorId, "Timer for respawning in clanmate's beds set to " .. tonumber(command) .. " seconds");
        else
            g_gameRules.game:SendTextMessage(0, playerId, "Timer for respawning in clanmate's beds set to " .. tonumber(command) .. " seconds");
        end
    end
end

-- Calling the Miscreated Respawn player on editor to test the respawner
RegisterCallbackReturnAware(
    Miscreated,
    'RevivePlayer',
    function (self, ret, playerId)
        local player = System.GetEntity(playerId);
        local steamId = player.player:GetSteam64Id();
        local playerChannel = player.actor:GetChannel();
        local playerName = player:GetName():gsub('%%', '');

        SCAAMClanRespawnerPlayerDatabase:SetPage(steamId, playerName);

        -- Editor or server specific actions
        if (System.IsEditor()) then

            -- Checks if there's a spawn point set for this player
            if (SCAAMClanRespawnerPlayers[steamId] and SCAAMClanRespawnerPlayers[steamId].SpawnSelected) then
                local bases = BaseBuildingSystem.GetPlotSigns();

                -- Loops through the bases in the server
                for i, b in pairs(bases) do 
                    if (b.plotsign:GetOwnerSteam64Id() == SCAAMClanRespawnerPlayers[steamId].SpawnSelected) then
                        local numParts = b.plotsign:GetPartCount();

                        if (numParts > 0) then
                            for p = 0, numParts - 1, 1 do
                                local partId = b.plotsign:GetPartId(p);

                                -- Crafted bed for the spawn
                                if (b.plotsign:GetPartTypeId(partId) == 5070) then

                                    -- Respawn the player in a clanmate's bed
                                    SCAAMClanRespawnerPlayers[steamId].SpawnSelected = nil;
                                    SCAAMClanRespawnerPlayers[steamId].SpawnedTime = os.clock();

                                    local bedPos = b.plotsign:GetPartWorldPos(partId);
                                    bedPos.z = bedPos.z + 0.2;
                                    player:SetWorldPos(bedPos);
                                    return ret;
                                end
                            end
                        end
                    end
                end
            end

            -- Inits the custom UI support for players
            player.onClient:SCCRToggleTheUI(playerChannel, false, '', '', '', '');
        else
            if (player and player.player) then

                -- Inits the custom UI support for players
                player.onClient:SCCRToggleTheUI(playerChannel, false, '', '', '', '');
            end
        end
        return ret;
    end,
    nil
);

-- Calling the Miscreated Init player function to respawn the player on the chosen selection
RegisterCallbackReturnAware(
    Miscreated,
    'InitPlayer',
    function (self, ret, playerId)
        local player = System.GetEntity(playerId);
        local steamId = player.player:GetSteam64Id();
        local playerChannel = player.actor:GetChannel();

        -- Checks if there's a spawn point set for this player
        if (SCAAMClanRespawnerPlayers[steamId] and SCAAMClanRespawnerPlayers[steamId].SpawnSelected) then
            local bases = BaseBuildingSystem.GetPlotSigns();

            -- Loops through the bases in the server
            for i, b in pairs(bases) do 
                if (b.plotsign:GetOwnerSteam64Id() == SCAAMClanRespawnerPlayers[steamId].SpawnSelected) then
                    local numParts = b.plotsign:GetPartCount();

                    if (numParts > 0) then
                        for p = 0, numParts - 1, 1 do
                            local partId = b.plotsign:GetPartId(p);

                            -- Crafted bed for the spawn
                            if (b.plotsign:GetPartTypeId(partId) == 5070) then

                                -- Respawn the player in a clanmate's bed
                                SCAAMClanRespawnerPlayers[steamId].SpawnSelected = nil;
                                SCAAMClanRespawnerPlayers[steamId].SpawnedTime = os.clock();

                                local bedPos = b.plotsign:GetPartWorldPos(partId);
                                bedPos.z = bedPos.z + 0.2;
                                player:SetWorldPos(bedPos);
                                return ret;
                            end
                        end
                    end
                end
            end
        end

        return ret;
    end,
    nil
);

-- Calling the Player hit function to open the respawn UI
RegisterCallback(
    Player.Server,
    'OnHit',
    nil,
    function (player, hit)
        local playerKilled = hit.target;

        if (playerKilled and playerKilled.player) then

            -- Checks if the player died
            if (playerKilled.lastHealth <= 0) then
                local clanId = playerKilled.player:GetClanId();
                local steamId = playerKilled.player:GetSteam64Id();
                local playerChannel = playerKilled.actor:GetChannel();

                -- Checks if the player has a clan
                if (clanId and clanId ~= 0) then
                    local clanBasesData = {};
                    local bases = BaseBuildingSystem.GetPlotSigns();

                    -- Loops through the bases in the server
                    for i, b in pairs(bases) do 
                        if (b.plotsign:GetClanId() and b.plotsign:GetClanId() == clanId) then

                            -- Checks if the steam id owner of the base is not one self
                            if (b.plotsign:GetOwnerSteam64Id() ~= steamId) then
                                local numParts = b.plotsign:GetPartCount();

                                if (numParts > 0) then
                                    for p = 0, numParts - 1, 1 do
                                        local partId = b.plotsign:GetPartId(p);

                                        -- Crafted bed for the spawn
                                        if (b.plotsign:GetPartTypeId(partId) == 5070) then
                                            local bedPos = b.plotsign:GetPartWorldPos(partId);
                                            bedPos.z = bedPos.z + 0.2;

                                            local playerName = SCAAMClanRespawnerPlayerDatabase:GetPage(b.plotsign:GetOwnerSteam64Id());

                                            if (playerName == nil) then
                                                playerName = 'undefined';
                                            end

                                            -- Adds the spawn point to the table
                                            local spawnPointData = {
                                                playerName,
                                                'x = ' .. bedPos.x .. ', y = ' .. bedPos.y .. ', z = ' .. bedPos.z,
                                                b.plotsign:GetOwnerSteam64Id()
                                            };

                                            -- Inserts the spawn data in the final table
                                            table.insert(clanBasesData, spawnPointData);
                                        end
                                    end
                                end
                            end
                        end
                    end

                    -- Calls the function on the UI to fill it with the respawn data
                    if (table.getn(clanBasesData) > 0) then

                        -- Sends the JSON string in small chunks
                        local JSONText = SCAAMClanRespawnerJSON.stringify(clanBasesData);

                        local JSONLength = string.len(JSONText);
                        local textChunk = math.ceil(JSONLength / 1000);
                        local chunkData = {};

                        for i = 1, textChunk, 1 do
                            if (i == 1) then
                                table.insert(chunkData, string.sub(JSONText, 1, 1000));
                            else
                                table.insert(chunkData, string.sub(JSONText, ((i - 1) * 1000 + 1), (i * 1000)));
                            end
                        end

                        -- Grabs the first 4 chunks of the table and calls the function to fill data
                        local chunksToRemove = 4;
                        local chunksToGrab = {};

                        while (chunksToRemove > 0) do

                            -- Checks if the table has chunks
                            if (table.getn(chunkData) > 0) then
                                table.insert(chunksToGrab, table.remove(chunkData, 1));
                            else
                                table.insert(chunksToGrab, '');
                            end
                    
                            chunksToRemove = chunksToRemove - 1;
                        end

                        playerKilled.onClient:SCCRToggleTheUI(playerChannel, true, chunksToGrab[1], chunksToGrab[2], chunksToGrab[3], chunksToGrab[4]);
                    else
                        playerKilled.onClient:SCCRToggleTheUI(playerChannel, true, '', '', '', '');
                    end
                else

                    -- Calls the function on the UI to fill it with empty data to notify about not being able
                    -- to respawn elsewhere
                    playerKilled.onClient:SCCRToggleTheUI(playerChannel, true, '', '', '', '');
                end
            end
        end
    end
);