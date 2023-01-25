
-- EL Project v1.0.2
-- Created by Cuartas, property of End of Living | RobocopHD community PvP

-- JSON variable
ELPJSON = nil;

-- Kills counter
ELPKillCounter = {};

-- Player counter
ELPPlayerCounterStarted = false;
ELPPlayerCounter = 0;

-- Hidden functions
ELPCountPlayers = nil;
ELPCountPlayersAfterDelay = nil;

-- Guns vs mags vs ammo table
ELPAmmoTable = {
    ['AA12'] = {'12Gaugex8_Beanbag_AA12', '12Gaugex8_Pellet_AA12', '12Gaugex8_Slug_AA12', 'Pile_12GaugeBeanbag', 'Pile_12GaugePellet', 'Pile_12GaugeSlug'},
    ['ACAW'] = {'762x5', 'Pile_762x51'},
    ['AK5D'] = {'556x30_ak5d', 'ext_556x75', 'Pile_556x45'},
    ['AK74U'] = {'545x30', 'Pile_545x39'},
    ['AKM'] = {'762x30', 'ext_762x75', 'Pile_762x39'},
    ['AKMGold'] = {'762x30', 'ext_762x75', 'Pile_762x39'},
    ['AKVal'] = {'762x20_Akval', 'ext_762x30', 'Pile_762x39', 'akval_drummag_75rnd'},
    ['AP85'] = {'9mmx19_ap85', 'Pile_9mm'},
    ['AT15'] = {'STANAGx30', 'STANAGx50','ext_556x75', 'Pile_556x45'},
    ['AUMP45'] = {'acp_45x30', 'Pile_45ACP'},
    ['Bulldog'] = {'STANAGx30', 'STANAGx50', 'ext_556x75', 'Pile_556x45'},
    ['ColtPython'] = {'Pile_357'},
    ['ColtPythonGrimeyRick'] = {'Pile_357'},
    ['CraftedBow'] = {'Arrowx8', 'Arrowx8_000P', 'Arrowx8_00R0', 'Arrowx8_00RP', 'Arrowx8_0B00', 'Arrowx8_0B0P', 'Arrowx8_0BR0', 'Arrowx8_0BRP', 'Arrowx8_F000', 'CraftedArrowx8_0000', 'CraftedArrowx8_000P', 'CraftedArrowx8_00R0', 'CraftedArrowx8_00RP', 'CraftedArrowx8_0B00', 'CraftedArrowx8_0B0P', 'CraftedArrowx8_0BR0', 'CraftedArrowx8_0BRP', 'CraftedArrowx8_F000', 'ExplosiveArrowx8_0000', 'CraftedExplosiveArrowx8_0000', 'CupidArrowx8'},
    ['CraftedLongPistol'] = {'9mmx10', '9mmx19', '9mmx33', 'Pile_9mm'},
    ['CraftedPistol'] = {'9mmx10', '9mmx19', '9mmx33', 'Pile_9mm'},
    ['CraftedPistol556'] = {'STANAGx30', 'Pile_556x45'},
    ['CraftedRifle9mm'] = {'9mmx10', '9mmx19', '9mmx33', 'Pile_9mm'},
    ['CraftedRifleLong'] = {'STANAGx30', 'Pile_556x45'},
    ['CraftedShortRifle556'] = {'STANAGx30', 'Pile_556x45'},
    ['CraftedShortShotgun'] = {'Pile_12GaugeBeanbag', 'Pile_12GaugePellet', 'Pile_12GaugeSlug'},
    ['CraftedShotgun'] = {'Pile_12GaugeBeanbag', 'Pile_12GaugePellet', 'Pile_12GaugeSlug'},
    ['CraftedSMG'] = {'9mmx10', '9mmx19', '9mmx33', 'Pile_9mm'},
    ['Crossbow'] = {'Boltx5_F000', 'Boltx5_0BRP', 'Boltx5_0BR0', 'Boltx5_0B0P', 'Boltx5_0B00', 'Boltx5_00RP', 'Boltx5_00R0', 'Boltx5_000P', 'Boltx5_0000'},
    ['CX4Storm'] = {'acp_45x20', 'Pile_45ACP'},
    ['FlareGun'] = {'Pile_Flare'},
    ['G18Pistol'] = {'9mmx10', '9mmx19', '9mmx33', 'Pile_9mm'},
    ['hk45'] = {'acp_45x10_hk', 'Pile_45ACP'},
    ['KrissV'] = {'10mmx15', 'Pile_10mm'},
    ['M4A1'] = {'STANAGx30', 'STANAGx50','ext_556x75', 'Pile_556x45'},
    ['M4V5'] = {'STANAGx30', 'STANAGx50','ext_556x75', 'Pile_556x45'},
    ['M9A1'] = {'9mmx15_m9a1', 'Pile_9mm'},
    ['M16'] = {'STANAGx30', 'STANAGx50','ext_556x75', 'Pile_556x45'},
    ['M16Vietnam'] = {'STANAGx30', 'STANAGx50','ext_556x75', 'Pile_556x45'},
    ['M40A5'] = {'M40x5', 'Pile_762x51'},
    ['M97'] = {'Pile_40mmGrenade'},
    ['M249'] = {'556x100', 'Pile_556x45'},
    ['m1911a1'] = {'acp_45x7', 'Pile_45ACP'},
    ['MAK10'] = {'9x19_mac10', 'Pile_9mm'},
    ['Makarov'] = {'9mmx10_makarov', 'Pile_9mm'},
    ['Mk18'] = {'STANAGx30', 'ext_556x75', 'Pile_556x45'},
    ['Mk18Reaver'] = {'STANAGx30', 'STANAGx50','ext_556x75', 'Pile_556x45'},
    ['Model70'] = {'Pile_223'},
    ['Model1873'] = {'Pile_357'},
    ['MP5'] = {'10mmx30', 'Pile_10mm'},
    ['NoWeapon'] = {},
    ['P350'] = {'357x14', 'Pile_357'},
    ['Peacemaker'] = {'Pile_357'},
    ['PX4'] = {'acp_45x10_hk', 'Pile_45ACP'},
    ['R90'] = {'57x50', 'Pile_57x28'},
    ['RecurveBow'] = {'Arrowx8', 'Arrowx8_000P', 'Arrowx8_00R0', 'Arrowx8_00RP', 'Arrowx8_0B00', 'Arrowx8_0B0P', 'Arrowx8_0BR0', 'Arrowx8_0BRP', 'Arrowx8_F000', 'CraftedArrowx8_0000', 'CraftedArrowx8_000P', 'CraftedArrowx8_00R0', 'CraftedArrowx8_00RP', 'CraftedArrowx8_0B00', 'CraftedArrowx8_0B0P', 'CraftedArrowx8_0BR0', 'CraftedArrowx8_0BRP', 'CraftedArrowx8_F000', 'ExplosiveArrowx8_0000', 'CraftedExplosiveArrowx8_0000', 'CupidArrowx8'},
    ['Rem700'] = {'Pile_308'},
    ['Rem870'] = {'Pile_12GaugeBeanbag', 'Pile_12GaugePellet', 'Pile_12GaugeSlug'},
    ['RPK'] = {'762x30', 'ext_762x75', 'Pile_762x39'},
    ['ruger22'] = {'22x10_ruger', 'Pile_22'},
    ['Sako_85'] = {'Pile_308'},
    ['SAS12'] = {'Pile_12GaugeBeanbag', 'Pile_12GaugePellet', 'Pile_12GaugeSlug'},
    ['SawedShotgun'] = {'Pile_12GaugeBeanbag', 'Pile_12GaugePellet', 'Pile_12GaugeSlug'},
    ['Shotgun870Tactical'] = {'Pile_12GaugeBeanbag', 'Pile_12GaugePellet', 'Pile_12GaugeSlug'},
    ['TranquilizerGun'] = {'Pile_TranquilizerDart'},
    ['VSS'] = {'762x20_Akval', 'ext_762x30', 'Pile_762x39', 'akval_drummag_75rnd'},
    ['Wasteland22'] = {'Pile_22'},
    ['m14ebr'] = {'mag_m14', 'Pile_762x51'},
    ['m14'] = {'mag_m14', 'Pile_762x51'},
    ['G36C'] = {'g36c_mag', 'g36cx50', 'Pile_556x45'},
    ['SCAR-H'] = {'STANAGx30', 'STANAGx50', 'ext_556x75', 'Pile_556x45'},
    ['Subjugator'] = {'mag_m14', 'Pile_762x51'},
    ['PlasmaRifle'] = {'Pile_Plasma', 'Pile_Plasma_yellow', 'Pile_Plasma_green', 'Pile_Plasma_red'},
    ['RocketLauncherNew'] = {'Pile_Rocket', 'Pile_Rocket_AP', 'Pile_Rocket_HE'},
    ['mutantsilencer'] = {'Pile_357'}
};

-- Validating if Miscreated:RevivePlayer is set
if not (Miscreated.RevivePlayer) then
    Log('ELProject >> Setting a generic Miscreated:RevivePlayer to make it exist');
    Miscreated.RevivePlayer = function (self, playerId)
        Log('ELProject >> This is the generic Miscreated:RevivePlayer call');
    end
end

-- ELPPreInitModules
-- Manages UI reload stuff
function ELPPreInitModules()
    if (not CryAction.IsDedicatedServer()) then
        Log('ELProject >> Called client UI init from not IsDedicatedServer');
        ReloadModUIOnlyOnce();
    end
end

-- Initializes some server stuff
function ELPInitModules()

    -- Calling the Miscreated Revive player function to initialize the player names script
    RegisterCallbackReturnAware(
        Miscreated,
        'RevivePlayer',
        function (self, ret, playerId)
            mSendEvent(
                playerId,
                {
                    Type = 'ELPInitUI',
                    Data = {}
                },
                false,
                false
            );
            return ret;
        end,
        nil
    );

   
    Script.SetTimerForFunction(3600, 'PVETopAfterDelay');

    -- Calling the Miscreated Revive player function to initialize the player names script
    RegisterCallbackReturnAware(
        Miscreated,
        'RevivePlayer',
        function (self, ret, playerId)
            if (ELPPlayerCounterStarted == false) then
                ELPPlayerCounterStarted = true;
                Script.SetTimerForFunction(1000, 'PVECountPlayersAfterDelay', {});
            end
            mSendEvent(
                playerId,
                {
                    Type = 'PVEInitUI',
                    Data = {}
                },
                false,
                false
            );
            return ret;
        end,
        nil
    );
end



-- Updates the player's data in a regular basis
function ELPPlayerGeneralUpdate()
    local player = System.GetEntity(g_localActorId);

    if (not player:IsDead()) then
        -- Ammo data
        local currentGun = player.inventory:GetCurrentItem();

        if (currentGun and currentGun.weapon and currentGun.weapon:GetAmmoCount() ~= nil and currentGun.weapon:GetClipSize() ~= nil) then
            if (ELPAmmoTable[currentGun.class]) then
                local ammoTypes = ELPAmmoTable[currentGun.class];
                local totalAmmo = 0;

                for key, ammoTypeName in pairs(ammoTypes) do
                    local foundAmmos = g_gameRules.game:GetStorageContent(player.id, ammoTypeName);

                    for key, ammoTypeId in pairs(foundAmmos) do
                        local ammoType = System.GetEntity(ammoTypeId);

                        if (ammoType and ammoType.item and ammoType.item:IsMagazine()) then
                            totalAmmo = totalAmmo + ammoType.item:GetStackCount();
                        end
                    end
                end

                if (currentGun.weapon:GetClipSize() ~= -1) then
                    UIAction.CallFunction('mod_ELAmmoCounterUI', 1, 'SetAmmo', tostring(currentGun.weapon:GetAmmoCount()), tostring(currentGun.weapon:GetClipSize()), tostring(totalAmmo));
                else
                    UIAction.CallFunction('mod_ELAmmoCounterUI', 1, 'SetAmmo', '0', '0', tostring(totalAmmo));
                end
            else
                UIAction.CallFunction('mod_ELAmmoCounterUI', 1, 'SetAmmo', 'undefined', '', '');
            end
        else
            UIAction.CallFunction('mod_ELAmmoCounterUI', 1, 'SetAmmo', 'undefined', '', '');
        end

        Script.SetTimerForFunction(10, 'ELPPlayerGeneralUpdateAfterDelay', {});
    else
        UIAction.UnloadElement('mod_ELAmmoCounterUI', 1);
    end

    
end

-- Updates the player data after a delay
function ELPPlayerGeneralUpdateAfterDelay(dummyData)
    ELPPlayerGeneralUpdate();
end

-- Counts the number of players connected to the server
function PVECountPlayers()
    
    
    local listOfPlayers = CryAction.GetPlayerList();
    local playersConnected = table.getn(listOfPlayers);
    local playerKills = 0;
    
    if (ELPPlayerCounter ~= playersConnected) then
        ELPPlayerCounter = playersConnected;

        for key, player in pairs(listOfPlayers) do
            mSendEvent(
                player.id,
                {
                    Type = 'PVEUpdatePlayerCount',
                    Data = {
                        playerCount = playersConnected
                    }
                },
                false,
                false
            );
        end
    end
    
    Script.SetTimerForFunction(10000, 'PVECountPlayersAfterDelay', {});
    
end

-- Counts the number of players connected to the server after a delay
function PVECountPlayersAfterDelay(dummy)
    PVECountPlayers();
end


function UpdateMiniMapCounters()

    local player = System.GetEntity(g_localActorId);

    if (not player:IsDead()) then

        Script.SetTimerForFunction(30, 'UpdateMiniMapCountersAfterDelay', {});

        -- Position data
        local position = {};
        local playerAngles = {};
        local vehicleId = player.actor:GetLinkedVehicleId();
        if (vehicleId) then
            local vehicle = System.GetEntity(vehicleId);
            position = vehicle:GetWorldPos();
            playerAngles = vehicle:GetAngles();
        else
            position = player:GetWorldPos();
            playerAngles = player:GetAngles();
        end
        local playerData = {
            Position = position,
            Rotation = playerAngles.z * 180/g_Pi
        };
        if (not ELPJSON) then
            ELPJSON = require('JSON');
        end

        --local steamId = player.player:GetSteam64Id();
        --local killerPersistentData = DBCollection:GetPage(steamId);
        local playerKills = 0 ;

        --if (killerPersistentData and killerPersistentData['mkills']) then
        --    playerKills = killerPersistentData['mkills'];
        --end

        --mSendEvent(
        --    player.id,
        --    {
        --        Type = 'ELPUpdateKills',
        --        Data = {
        --           playerKills = playerKills
        --        }
        --    },
        --    false,
        --    false
        --);

        UIAction.CallFunction('mod_ELMinimapUI', 1, 'UpdatePlayerPosAndRotation', ELPJSON.stringify(playerData), tostring(player.ELPPlayerCount), tostring(playerKills));

    else
        UIAction.UnloadElement('mod_ELMinimapUI', 1);
    end
    
    
end

function UpdateMiniMapCountersAfterDelay(dummy)
    UpdateMiniMapCounters();
end


function PVETop()
    
    local rnd = random(1, 16);
    
    local mensaje = 'Use Command !help / Usa el comando !Ayuda';

    if rnd == 1 then
        mensaje = 'Remember Survivors must set a name on the server or be Kicked';
    elseif rnd == 2 then
        mensaje = '!zone command allows you to go to the safe zone';
    elseif rnd == 3 then
        mensaje = 'PVE STORE menu has speed mods to buy';
    elseif rnd == 4 then
        mensaje = 'Deactivate the locations with the "¬" keyboard key ';
    elseif rnd == 5 then
        mensaje = 'Disable locations with the "¬" key';
    elseif rnd == 6 then
        mensaje = 'Command !help for more info'
    elseif rnd == 7 then
        mensaje = 'Comando !Ayuda para más información'
    elseif rnd == 8 then
        mensaje = 'Desactiva las ubicaciones con la tecla "¬"'
    elseif rnd == 9 then
        mensaje = 'El menú PVE STORE tiene mods con velocidad extra para comprar'
    elseif rnd == 10 then
        mensaje = 'Comando !zona te permite ir a la zona segura'
    elseif rnd == 11 then
        mensaje = 'command !discord [message] send discord message'        
    elseif rnd == 12 then
        mensaje = 'Comando !discord [mensaje] envíar mensaje en Discord'           
    elseif rnd == 13 then
        mensaje = 'Leave stuff at community base, dont take everything'    
    elseif rnd == 14 then
        mensaje = 'Deja cosas para otras jugadores, no te lleves todo'
    elseif rnd == 15 then
        mensaje = 'Survivor named players are not allowed, identify yourself'
    elseif rnd == 16 then
        mensaje = 'Survivor named players are not allowed, identify yourself'
    end

    g_gameRules.game:SendTextMessage(0, 0, mensaje );
    g_gameRules.game:SendTextMessage(4, 0, mensaje );

    Script.SetTimerForFunction(1200000, 'PVETopAfterDelay');
end 


function PVETopAfterDelay()
    PVETop();
end