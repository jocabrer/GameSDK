-- APOC Compass Mod v1.0
-- Created by Cuartas, Property of Apocalypse comunity (discord.gg/apocalypse)

-- Validating if Miscreated:RevivePlayer is set
if not (Miscreated.RevivePlayer) then
    Miscreated.RevivePlayer = function (self, playerId)
        Log('APOCCompassMod >> Setting a generic Miscreated:RevivePlayer to make it exist');
    end
end

-- APOCCompassPreInitModules
-- Manage UI reload stuff
function APOCCompassPreInitModules()
    if (not CryAction.IsDedicatedServer()) then
        Log('APOCCompassMod >> Called client UI init from not IsDedicatedServer');
        ReloadModUIOnlyOnce();
    end
end

-- APOCCompassInitModules
-- Manage JSON stuff (Based on Theros' mFramework)
function APOCCompassInitModules()
    APOCCompassJSON = require('JSON');
end

--------------------------------------------------------------------------
---------------------------- CUSTOM UI SCRIPTS ---------------------------
--------------------------------------------------------------------------

APOCCompassUIFunctions = {};

-- APOCCompassUIFunctions:ToggleTheCompass
-- Updates the player indicator position and rotation on the map game
function APOCCompassUIFunctions:ToggleTheCompass(toggle)
    local player = System.GetEntity(g_localActorId);
    player.APOCCompassToggle = toggle;

    if (toggle == true) then
        UIAction.ShowElement('mod_APOCCompassUI', 0);
    else
        UIAction.HideElement('mod_APOCCompassUI', 0);
    end
end

-- APOCCompassUIFunctions:UpdatePlayerCompass
-- Updates the player direction in the compass
function APOCCompassUIFunctions:UpdatePlayerCompass(playerData)
    UIAction.CallFunction('mod_APOCCompassUI', 0, 'UpdatePlayerCompass', APOCCompassJSON.stringify(playerData));
end

--------------------------------------------------------------------------
-------------------------- CUSTOM UI SCRIPTS END -------------------------
--------------------------------------------------------------------------

-- APOCToggleCompass
-- Toggles the compass by key
function APOCToggleCompass(keybind)
    local player = System.GetEntity(g_localActorId);

    if (player.APOCIsDead == false) then
        local oppositeToggle = player.APOCCompassToggle;

        if (oppositeToggle == true) then
            oppositeToggle = false;
        else
            oppositeToggle = true;
        end

        APOCCompassUIFunctions:ToggleTheCompass(oppositeToggle);
    end
end

-- APOCCompassPlayerGeneralUpdate
-- Updates the player's compass direction
function APOCCompassPlayerGeneralUpdate(dummyVar)
    local player = System.GetEntity(g_localActorId);

    -- Checks if the UI is active
    if (player.APOCCompassToggle == true) then
        local entityToGetData = nil;
        local position = {};
        local angles = {};

        local vehicleId = player.actor:GetLinkedVehicleId();

        if (vehicleId) then
            local vehicle = System.GetEntity(vehicleId);
            position = vehicle:GetWorldPos();
            angles = vehicle:GetAngles();
        else
            position = player:GetWorldPos();
            angles = player:GetAngles();
        end

        local playerData = {
            Position = position,
            Rotation = angles.z * 180/g_Pi
        }

        APOCCompassUIFunctions:UpdatePlayerCompass(playerData);
    end

    -- Calls the timer function again
    APOCCompassStartPlayerGeneralUpdate();
end

-- APOCCompassStartPlayerGeneralUpdate
-- Starts the timer to update the player's direction in the compass
function APOCCompassStartPlayerGeneralUpdate()
    Script.SetTimerForFunction(10, 'APOCCompassPlayerGeneralUpdate', {});
end

-- Calling the Miscreated Revive player function to initialize the compass script
RegisterCallbackReturnAware(
    Miscreated,
    'RevivePlayer',
    function (self, ret, playerId)
        local player = System.GetEntity(playerId);

        if (player and player.player) then

            -- Inits the custom UI support for players and keybinds
            mSendEvent(
                player.id,
                {
                    Type = 'APOCCompassInit',
                    Data = {dummyData = ''}
                },
                false,
                false
            );
        end

        return ret;
    end,
    nil
);

-- Calling the Player hit function to close the compass UI in case it's opened while killed
RegisterCallback(
    Player.Server,
    'OnHit',
    nil,
    function (player, hit)
        local playerKilled = hit.target;

        if (playerKilled and playerKilled.player) then
            if (playerKilled.lastHealth <= 0) then
                mSendEvent(
                    playerKilled.id,
                    {
                        Type = 'APOCCompassToggleUI',
                        Data = {toggle = false, isDead = true}
                    },
                    false,
                    false
                );
            end
        end
    end
);