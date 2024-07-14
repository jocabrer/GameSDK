-- EL Car Info v1.0.0
-- Created by Cuartas, property of End of Living | RobocopHD community PvP

-- JSON variable
APOCCIJSON = nil;

-- Gas and Oil timer
APOCCIGasOilTimer = 1000;

-- Gas and Oil values
APOCCIGas = -1;
APOCCIOil = -1;

-- Is player inside vehicle
APOCCIVehicleActive = false;

-- Validating if Miscreated:RevivePlayer is set
if not (Miscreated.RevivePlayer) then
    Log("APOCCarInfo >> Setting a generic Miscreated:RevivePlayer to make it exist");
    Miscreated.RevivePlayer = function (self, playerId)
        Log("APOCCarInfo >> This is the generic Miscreated:RevivePlayer call");
    end
end

-- APOCCIPreInitModules
-- Manages UI reload stuff
function APOCCIPreInitModules()
    if (not CryAction.IsDedicatedServer()) then
        Log('APOCCarInfo >> Called client UI init from not IsDedicatedServer');
        ReloadModUIOnlyOnce();
    end
end

-- APOCCIInitModules
-- Initializes some client stuff
function APOCCIInitModules()
    APOCCIJSON = require('JSON');

    if (CryAction.IsDedicatedServer()) then
        RegisterCallbackReturnAware(
        Miscreated,
        'RevivePlayer',
        function (self, ret, playerId)
            mSendEvent(
                playerId,
                {
                    Type = 'APOCCIInitUI',
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
end

-- APOCCIRestartValues
-- Restarts this script values
function APOCCIRestartValues()
    APOCCIVehicleActive = false;
    APOCCIGasOilTimer = 0;
    APOCCIGas = -1;
    APOCCIOil = -1;
end

-- APOCCIShowCarInfo
-- Shows the car info if a player is in a car
function APOCCIShowCarInfo()
    Log("APOCCarInfo >> APOCCIShowCarInfo");
    local player = System.GetEntity(g_localActorId);

    if (not player:IsDead()) then

        -- Vehicle data
        if (UIAction.IsVisible('ChatWindow', -1, 'chatWindow') == true and APOCCIVehicleActive == true) then
            UIAction.HideElement('mod_APOCCarUI', 1);
            APOCCIRestartValues()
        elseif (UIAction.IsVisible('ChatWindow', -1, 'chatWindow') == false) then
            local vehicleId = player.actor:GetLinkedVehicleId();

            if (vehicleId) then
                if (APOCCIVehicleActive == false) then
                    UIAction.ShowElement('mod_APOCCarUI', 1);
                    APOCCIVehicleActive = true;
                end
                local vehicle = System.GetEntity(vehicleId);
                local speed = (vehicle:GetSpeed() * 55) / 17;

                if (APOCCIGasOilTimer <= 0) then
                    if (APOCCIJSON == nil) then
                        APOCCIJSON = require('JSON');
                    end
                    local vehicleInfo = APOCCIJSON.parse(vehicle.vehicle:ReadOrRestoreJSON(false, '', false));
                    APOCCIGas = math.floor(tonumber(vehicleInfo.dieselfuel));
                    APOCCIOil = math.floor(tonumber(vehicleInfo.oil));
                    APOCCIGasOilTimer = 1000;
                end
                APOCCIGasOilTimer = APOCCIGasOilTimer - 10;

                local health = (1 - vehicle.vehicle:GetComponentDamageRatio('hull')) * 100;
                UIAction.CallFunction('mod_APOCCarUI', 1, 'setCarInfo', APOCCIGas, APOCCIOil, speed, health);
            else
                UIAction.HideElement('mod_APOCCarUI', 1);
                APOCCIRestartValues()
            end
        end

        Script.SetTimerForFunction(10, 'APOCCIShowCarInfoAfterDelay', {});
    else
        UIAction.HideElement('mod_APOCCarUI', 1);
        APOCCIRestartValues()
    end
end

-- APOCCIShowCarInfoAfterDelay
-- Recalls the function to show car info after a delay
function APOCCIShowCarInfoAfterDelay(dummy)
    APOCCIShowCarInfo();
end