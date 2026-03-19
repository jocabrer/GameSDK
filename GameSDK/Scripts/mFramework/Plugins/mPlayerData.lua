local Object = require("Object")
local PlayerDataManager = Object:extend()

PlayerDataManager.__DataStore = mFramework.PersistantStorage:Collection("PlayerData")
PlayerDataManager.Properties = {
            PlayerName = nil,
            SteamId = nil
        }
PlayerDataManager.PlayerData = nil

function PlayerDataManager:Sync(u)
    local steamId = self.Properties.SteamId
    if self.PlayerData then
        if u then
            self.PlayerData = self.__DataStore:SetPage(steamId,self.PlayerData)
        else
            self.PlayerData = self.__DataStore:GetPage(steamId)
        end
    end
end


function PlayerDataManager:new(player)
    if (not MisDB) or (not mFramework.PersistantStorage) then
        Log("   [FAIL] PlayerDataManager Requires mFramework.PersistantStorage")
        return nil
    else
        local steamId = player.player:GetSteam64Id()
        self.Properties = {
            PlayerName = player:GetName(),
            SteamId = steamId
        }
        self.PlayerData = self.__DataStore:GetPage(steamId) or {}
    end
end

function PlayerDataManager:Get(k)
    self:Sync()
    return self.PlayerData[k]
end

function PlayerDataManager:Set(k,v)
    self.PlayerData[k] = v
    self:Sync(true)
    return self.PlayerData[k]
end

_G['PlayerDataManager'] = PlayerDataManager