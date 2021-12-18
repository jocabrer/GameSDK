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
    ['AKVal'] = {'762x20_Akval', 'ext_762x30', 'Pile_762x39'},
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
    ['VSS'] = {'762x20_Akval', 'ext_762x30', 'Pile_762x39'},
    ['Wasteland22'] = {'Pile_22'},
    ['m14ebr'] = {'mag_m14', 'Pile_762x51'},
    ['m14'] = {'mag_m14', 'Pile_762x51'},
    ['G36C'] = {'g36c_mag', 'Pile_556x45'},
    ['SCAR-H'] = {'STANAGx30', 'STANAGx50', 'ext_556x75', 'Pile_556x45'},
    ['Subjugator'] = {'mag_m14', 'Pile_762x51'}
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

-- ELPInitModules
-- Initializes some server stuff
function ELPInitModules()
    ELPJSON = require('JSON');
end


-- ELPPlayerGeneralUpdate
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

-- ELPPlayerGeneralUpdateAfterDelay
-- Updates the player data after a delay
function ELPPlayerGeneralUpdateAfterDelay(dummyData)
    ELPPlayerGeneralUpdate();
end


-- Calling the Miscreated Revive player function to initialize the player names script
RegisterCallbackReturnAware(
    Miscreated,
    'RevivePlayer',
    function (self, ret, playerId)

        mSendEvent(
            playerId,
            {
                Type = 'ELPInitUI',
                Data = {
                    playerCount = 0,
                    playerTotal = 0
                }
            },
            false,
            false
        );

        return ret;
    end,
    nil
);