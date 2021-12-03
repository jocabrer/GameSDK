-- APOC Compass Mod v1.0
-- Created by Lucy https://steamcommunity.com/profiles/76561198854231156/ ,Copyright 2020

local APOCCompassCustomPlayer = {
    Methods = {
        Client = {
            APOCCompassInit = function(self)
                ReloadModUIOnlyOnce();

                System.AddCCommand('APOCCompass', 'APOCToggleCompass(%1)', '');
                System.AddKeyBind('delete', 'APOCCompass delete');
                
                self.APOCIsDead = false;
                self.APOCCompassToggle = true;

                UIAction.ShowElement('mod_APOCCompassUI', 0);

                APOCCompassStartPlayerGeneralUpdate();
            end,

            APOCCompassToggleUI = function(self, toggle, isDead)
                self.APOCIsDead = isDead;
                APOCCompassUIFunctions:ToggleTheCompass(toggle);
            end
        },
        Server = {
        }
    },
    Expose = {
        ClientMethods = {
            APOCCompassInit = { RELIABLE_ORDERED, POST_ATTACH },
            APOCCompassToggleUI = { RELIABLE_ORDERED, POST_ATTACH, BOOL, BOOL }
        },
        ServerMethods = {},
        ServerProperties = {}
    }
}

Log(">> Loading mFramework APOCCompassCustomPlayer");
local _status, _result = mReExpose('Player', APOCCompassCustomPlayer.Methods, APOCCompassCustomPlayer.Expose);
Log(">> Result: " .. tostring(_status or "Failed") .. " " .. tostring(_result or "No Message"));