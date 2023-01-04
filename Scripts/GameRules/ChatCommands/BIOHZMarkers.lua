-- BIOHZ Markers v1.0
-- Created by Cuartas, property of BioHazard

-- MisDB and JSON variables
BIOHZMKJSON = nil;
BIOHZMKDatabase = nil;

-- Client marker tag counter
BIOHZMKMarkerTagsLength = 0;

-- Client marker update toggler
BIOHZMKMarkerUpdater = true;

-- Corpses positions
BIOHZMKCorpses = {};

-- Validating if Miscreated:RevivePlayer is set
if not (Miscreated.RevivePlayer) then
    Log("BIOHZMarkers >> Setting a generic Miscreated:RevivePlayer to make it exist");
    Miscreated.RevivePlayer = function (self, playerId)
        Log("BIOHZMarkers >> This is the generic Miscreated:RevivePlayer call");
    end
end

-- BIOHZMKPreInitModules
-- Manages UI reload stuff
function BIOHZMKPreInitModules()
    if (not CryAction.IsDedicatedServer()) then
        Log('BIOHZMarkers >> Called client UI init from not IsDedicatedServer');
        ReloadModUIOnlyOnce();
    end
end


-- BIOHZMKInitModules
-- Manage storage stuff (Based on Theros' mFramework)
function BIOHZMKInitModules()
    BIOHZMKJSON = require('JSON');
    BIOHZMKDatabase = mFramework.PersistantStorage:Collection('BIOHZMarkersCollection');
end

-- BIOHZMKShowMarkers
-- Checks for all the available markers
function BIOHZMKShowMarkers()
    local myPlayer = System.GetEntity(g_localActorId);

    if (not myPlayer:IsDead() and myPlayer.BIOHZMKMarkerList) then
        if (ActionMapManager.IsFilterEnabled('only_ui') == false and ActionMapManager.IsFilterEnabled('inventory') == false and BIOHZMKMarkerUpdater == true) then
            local myPlayerPos = myPlayer:GetWorldPos();
            local index = 1;
            local currentMarkerLength = 0;
            local validMarkers = {};
            local removedMarkers = {};

            for key, marker in pairs(myPlayer.BIOHZMKMarkerList) do
                local correctedPos = new(marker[3]);

                if (DistanceVectors(myPlayerPos, correctedPos) > 200) then
                    local moveToDirection = {x=0, y=0, z=0};
                    local sumVectors = {x=0, y=0, z=0};
                    SubVectors(moveToDirection, correctedPos, myPlayerPos);
                    NormalizeVector(moveToDirection);
                    FastScaleVector(sumVectors, moveToDirection, 200);
                    FastSumVectors(correctedPos, sumVectors, myPlayerPos);
                end

                local pos, offset = UIAction.GetScreenPosFromWorld('mod_BIOHZMarkersDummyUI', 200, correctedPos, {x = 0, y = 0, z = 0}, true);

                if (offset.x == 0 and offset.y == 0 and DistanceVectors(myPlayerPos, correctedPos) > 2) then
                    table.insert(validMarkers, {
                        marker[1],
                        marker[2],
                        marker[3],
                        correctedPos
                    });

                    if (marker[2] == 4 and DistanceVectors(myPlayerPos, correctedPos) < 3) then
                        table.insert(removedMarkers, table.getn(validMarkers));
                        table.remove(validMarkers, table.getn(validMarkers));

                        if (myPlayer.BIOHZMKCorpseTimerId) then
                            Script.KillTimer(myPlayer.BIOHZMKCorpseTimerId);
                            myPlayer.BIOHZMKCorpseTimerId = nil;
                        end
                    end
                end
            end

            for key, marker in pairs(removedMarkers) do
                table.remove(myPlayer.BIOHZMKMarkerList, marker);
            end

            currentMarkerLength = table.getn(validMarkers);

            for key, marker in pairs(validMarkers) do
                if (index > BIOHZMKMarkerTagsLength) then
                    UIAction.ShowElement('mod_BIOHZMarkersUI', index);
                end

                local pos, offset = UIAction.GetScreenPosFromWorld('mod_BIOHZMarkersUI', index, marker[4], {x = 0, y = 0, z = 0}, false);
                local markerDistance = tostring(math.floor(DistanceVectors(myPlayerPos, marker[3]))) .. 'm';

                pos.x = pos.x - (100 - (DistanceVectors(myPlayerPos, marker[4]) / 3));

                UIAction.CallFunction('mod_BIOHZMarkersUI', index, 'setMarkerInfo', marker[1], marker[2], markerDistance);
                UIAction.SetPos('mod_BIOHZMarkersUI', index, '_root', pos);

                index = index + 1;
            end

            if (BIOHZMKMarkerTagsLength - currentMarkerLength > 0) then
                for i = BIOHZMKMarkerTagsLength, currentMarkerLength + 1, -1 do
                    UIAction.UnloadElement('mod_BIOHZMarkersUI', i);
                end
            end

            BIOHZMKMarkerTagsLength = currentMarkerLength;
        else
            BIOHZMKMarkerTagsLength = 0;
            UIAction.UnloadElement('mod_BIOHZMarkersUI', -1);
        end

        Script.SetTimerForFunction(10, 'BIOHZMKShowMarkersAfterDelay', {});
    else
        BIOHZMKMarkerTagsLength = 0;
        UIAction.UnloadElement('mod_BIOHZMarkersUI', -1);
        UIAction.UnloadElement('mod_BIOHZMarkersDummyUI', 200);
    end
end

-- BIOHZMKShowMarkersAfterDelay
-- Recalls the function to show names after a delay
function BIOHZMKShowMarkersAfterDelay(dummy)
    BIOHZMKShowMarkers();
end

-- BIOHZMKRemoveCorpseMarker
-- Removes the player corpse marker due to time expired
function BIOHZMKRemoveCorpseMarker(player)
    for key, marker in pairs(player.BIOHZMKMarkerList) do
        if (marker[2] == 4) then
            table.remove(player.BIOHZMKMarkerList, key);
            break;
        end
    end
end

-- BIOHZMKManageMenu
-- Manages the menu custom keybinds
function BIOHZMKManageMenu(keyString)
    local player = System.GetEntity(g_localActorId);

    if (keyString == 'tilde') then
        if (BIOHZMKMarkerUpdater == true) then
            BIOHZMKMarkerUpdater = false;
        else
            BIOHZMKMarkerUpdater = true;
        end
    end
end

-- Calling the Miscreated Revive player function to initialize the player names script
RegisterCallbackReturnAware(
    Miscreated,
    'RevivePlayer',
    function (self, ret, playerId)
        local player = System.GetEntity(playerId);
        local steamId = player.player:GetSteam64Id();
        local positionsTable = {};

        local corpseData = BIOHZMKCorpses[steamId];

        if (corpseData) then
            table.insert(positionsTable, {
                'Corpse',
                4,
                corpseData
            });

            BIOHZMKCorpses[steamId] = nil;
        end

        local bases = BaseBuildingSystem.GetPlotSigns();

        for i, b in pairs(bases) do
            if (b.plotsign:GetOwnerSteam64Id() == steamId) then
                table.insert(positionsTable, {
                    'Base',
                    3,
                    b:GetWorldPos(),
                });
                break;
            end
        end

        local adminMarkers = BIOHZMKDatabase:GetPage('adminMarkers');

        if (adminMarkers) then
            for key, marker in pairs(adminMarkers) do
                table.insert(positionsTable, {
                    marker.name,
                    2,
                    marker.pos
                });
            end
        end

        local playerMarkers = BIOHZMKDatabase:GetPage(steamId);

        if (playerMarkers) then
            if (table.getn(playerMarkers) > 1 and not string.match(System.GetCVar('g_gameRules_faction6_steamids'), steamId)) then
                for i = table.getn(playerMarkers), 2, -1 do
                    table.remove(playerMarkers, i);
                end

                BIOHZMKDatabase:SetPage(steamId, playerMarkers);
            end

            for key, marker in pairs(playerMarkers) do
                table.insert(positionsTable, {
                    marker.name,
                    1,
                    marker.pos
                });
            end
        end

        mSendEvent(
            playerId,
            {
                Type = 'BIOHZMKInitUI',
                Data = {
                    markers = BIOHZMKJSON.stringify(positionsTable)
                }
            },
            false,
            false
        );

        return ret;
    end,
    nil
);

-- Calling the Player Kill function to register a marker and counter to the body
RegisterCallback(
    Player.Server,
    'OnHit',
    nil,
    function (player, hit)
        local playerKilled = hit.target;

        if (playerKilled:IsDead() or playerKilled.lastHealth <= 0) then
            local steamId = playerKilled.player:GetSteam64Id();
            BIOHZMKCorpses[steamId] = playerKilled:GetWorldPos();

            mSendEvent(
                playerKilled.id,
                {
                    Type = 'BIOHZMKKillCorpseTimer',
                    Data = {dummyData = ''}
                },
                false,
                false
            );
        end
    end
);

-- !setmarker <subcommand>
-- Uses the !setmarker command with a subcommand to set a marker
ChatCommands["!setmarker"] = function(playerId, command)
    if (string.len(command) > 0 and string.len(command) <= 20) then
        local player = System.GetEntity(playerId);
        local steamId = player.player:GetSteam64Id();
        local maxMarkers = 2;

        -- Checks if the player has donator state
        if (string.match(System.GetCVar('g_gameRules_faction6_steamids'), steamId)) then
            maxMarkers = 3;
        end

        local playerMarkers = BIOHZMKDatabase:GetPage(steamId);

        if (not playerMarkers or table.getn(playerMarkers) < maxMarkers) then
            if (playerMarkers) then
                for key, marker in pairs(playerMarkers) do
                    if (marker.name == command) then
                        g_gameRules.game:SendTextMessage(0, playerId, 'The tagname already exists');
                        return;
                    end
                end
            else
                playerMarkers = {};
            end

            local markerPos = player:GetWorldPos();
            markerPos.z = markerPos.z + 1;

            local newMarker = {
                name = command,
                pos = markerPos
            };

            table.insert(playerMarkers, newMarker);
            BIOHZMKDatabase:SetPage(steamId, playerMarkers);

            mSendEvent(
                playerId,
                {
                    Type = 'BIOHZMKAddMarker',
                    Data = {
                        marker = BIOHZMKJSON.stringify(newMarker)
                    }
                },
                false,
                false
            );

            g_gameRules.game:SendTextMessage(0, playerId, 'Set flag successfully');
        else
            g_gameRules.game:SendTextMessage(0, playerId, "You cannot set more flags");
        end
    else
        g_gameRules.game:SendTextMessage(0, playerId, 'A name not exceeding 20 characters is required');
    end
end

-- !removemarker <subcommand>
-- Uses the !removemarker command with a subcommand to remove a marker
ChatCommands["!removemarker"] = function(playerId, command)
    if (string.len(command) > 0) then
        local player = System.GetEntity(playerId);
        local steamId = player.player:GetSteam64Id();

        local playerMarkers = BIOHZMKDatabase:GetPage(steamId);

        if (playerMarkers and table.getn(playerMarkers) > 0) then
            for key, marker in pairs(playerMarkers) do
                if (marker.name == command) then
                    table.remove(playerMarkers, key);
                    BIOHZMKDatabase:SetPage(steamId, playerMarkers);

                    mSendEvent(
                        playerId,
                        {
                            Type = 'BIOHZMKRemoveMarker',
                            Data = {
                                markerName = command
                            }
                        },
                        false,
                        false
                    );

                    g_gameRules.game:SendTextMessage(0, playerId, 'Delete mark successfully');
                    return;
                end
            end

            g_gameRules.game:SendTextMessage(0, playerId, "There is no tag with that name");
        else
            g_gameRules.game:SendTextMessage(0, playerId, "There is no mark to delete");
        end
    else
        g_gameRules.game:SendTextMessage(0, playerId, 'The marked name is required to delete it');
    end
end

-- !basemarker <subcommand>
-- Uses the !basemarker command with a subcommand update the base marker
ChatCommands["!basemarker"] = function(playerId, command)
    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();
    local basePos = {'noBase'};

    local bases = BaseBuildingSystem.GetPlotSigns();

    for i, b in pairs(bases) do
        if (b.plotsign:GetOwnerSteam64Id() == steamId) then
            basePos = b:GetWorldPos();
            break;
        end
    end

    mSendEvent(
        playerId,
        {
            Type = 'BIOHZMKUpdateBase',
            Data = {
                marker = BIOHZMKJSON.stringify(basePos)
            }
        },
        false,
        false
    );

    g_gameRules.game:SendTextMessage(0, playerId, 'Successfully updated the base tag');
end

-- !removecorpse <subcommand>
-- Uses the !removecorpse command to remove the player corpse if it has one
ChatCommands["!removecorpse"] = function(playerId, command)
    local player = System.GetEntity(playerId);

    mSendEvent(
        player.id,
        {
            Type = 'BIOHZMKKillCorpseTimer',
            Data = {dummyData = ''}
        },
        false,
        false
    );

    g_gameRules.game:SendTextMessage(0, playerId, 'Corpse mark removed successfully');
end

-- !setmarkerall <subcommand>
-- Uses the !setmarkerall command with a subcommand to set a global marker
ChatCommands["!setmarkerall"] = function(playerId, command)
    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    if (string.match(System.GetCVar('g_gameRules_faction6_steamids'), steamId)) then
        if (string.len(command) > 0 and string.len(command) <= 15) then
            local maxMarkers = 9;

            local adminMarkers = BIOHZMKDatabase:GetPage('adminMarkers');

            if (not adminMarkers or table.getn(adminMarkers) < maxMarkers) then
                if (adminMarkers) then
                    for key, marker in pairs(adminMarkers) do
                        if (marker.name == command) then
                            g_gameRules.game:SendTextMessage(0, playerId, 'The tagname already exists');
                            return;
                        end
                    end
                else
                    adminMarkers = {};
                end

                local markerPos = player:GetWorldPos();
                markerPos.z = markerPos.z + 1;

                local newMarker = {
                    name = command,
                    pos = markerPos
                };

                table.insert(adminMarkers, newMarker);
                BIOHZMKDatabase:SetPage('adminMarkers', adminMarkers);

                local listOfPlayers = CryAction.GetPlayerList();

                for key, player2 in pairs(listOfPlayers) do
                    mSendEvent(
                        player2.id,
                        {
                            Type = 'BIOHZMKAddMarkerAll',
                            Data = {
                                marker = BIOHZMKJSON.stringify(newMarker)
                            }
                        },
                        false,
                        false
                    );
                end

                g_gameRules.game:SendTextMessage(0, playerId, 'Global flag set successfully');
            else
                g_gameRules.game:SendTextMessage(0, playerId, "You cannot set more flags");
            end
        else
            g_gameRules.game:SendTextMessage(0, playerId, 'Requires a name of 15 characters or less');
        end
    end
end

-- !removemarkerall <subcommand>
-- Uses the !removemarkerall command with a subcommand to remove a global marker
ChatCommands["!removemarkerall"] = function(playerId, command)
    local player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    if (string.match(System.GetCVar('g_gameRules_faction6_steamids'), steamId)) then
        if (string.len(command) > 0) then
            local adminMarkers = BIOHZMKDatabase:GetPage('adminMarkers');

            if (adminMarkers and table.getn(adminMarkers) > 0) then
                for key, marker in pairs(adminMarkers) do
                    if (marker.name == command) then
                        table.remove(adminMarkers, key);
                        BIOHZMKDatabase:SetPage('adminMarkers', adminMarkers);

                        local listOfPlayers = CryAction.GetPlayerList();

                        for key, player2 in pairs(listOfPlayers) do
                            mSendEvent(
                                player2.id,
                                {
                                    Type = 'BIOHZMKRemoveMarkerAll',
                                    Data = {
                                        markerName = command
                                    }
                                },
                                false,
                                false
                            );
                        end

                        g_gameRules.game:SendTextMessage(0, playerId, 'Global mark deleted successfully');
                        return;
                    end
                end

                g_gameRules.game:SendTextMessage(0, playerId, "There is no tag with that name");
            else
                g_gameRules.game:SendTextMessage(0, playerId, "There is no mark to delete");
            end
        else
            g_gameRules.game:SendTextMessage(0, playerId, 'The marked name is required to delete it');
        end
    end
end