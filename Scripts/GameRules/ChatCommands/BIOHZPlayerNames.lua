-- BIOHZ Player names v1.1
-- Created by Cuartas, property of BioHazard

-- Validating if Miscreated:RevivePlayer is set
if not (Miscreated.RevivePlayer) then
    Log("BIOHZPlayerNames >> Setting a generic Miscreated:RevivePlayer to make it exist");
    Miscreated.RevivePlayer = function (self, playerId)
        Log("BIOHZPlayerNames >> This is the generic Miscreated:RevivePlayer call");
    end
end

BIOHZPNMaxDistance = 15;
BIOHZPNMaxDistanceAdmin = 200;
BIOHZLogoServerCap = 100;
BIOHZLogoPlayerCounterStarted = false;
BIOHZLogoPlayerCounter = 0;

-- Client player tag counter
BIOHZPNPlayerTagsLength = 0;

-- BIOHZPNPreInitModules
-- Manages UI reload stuff
function BIOHZPNPreInitModules()
    if (not CryAction.IsDedicatedServer()) then
        Log('BIOHZPlayerNames >> Called client UI init from not IsDedicatedServer');
        ReloadModUIOnlyOnce();
    end
end


-- BIOHZPNInitModules
-- Initializes some server stuff and patches the player
function BIOHZPNInitModules()
    if (not CryAction.IsDedicatedServer()) then
        Log('BIOHZPlayerNames >> Patching player from BIOHZPNInitModules');
        BIOHZPNPatchPlayer();
    end
end

-- BIOHZPNPatchPlayer
-- Modifies the Init function to retrieve the player's faction
function BIOHZPNPatchPlayer()
    if (_G['Player']) then
        local player = _G['Player'];

        player.OnInit = function(self, bIsReload)
            if (not CryAction.IsDedicatedServer()) then
                mSendEvent(
                    'Server',
                    {
                        Type = 'BIOHZPNGetAdminState',
                        Data = {dummyData = ''}
                    },
                    self.id,
                    false
                );
            end

            self:SetAIName(self:GetName());
            self:OnReset(true, bIsReload);
        end
    end
end

-- BIOHZPNGetAdminState
-- Returns the player's admin faction state to the requesting player
function BIOHZPNGetAdminState(playerId, targetId)
    player = System.GetEntity(playerId);
    local steamId = player.player:GetSteam64Id();

    if (string.match(System.GetCVar('g_gameRules_faction6_steamids'), steamId)) then
        
        mSendEvent(
            playerId,
            {
                Type = 'BIOHZPNSetAdminState',
                Data = {
                    isAdmin = true
                }
            },
            targetId,
            false
        );
    end
end

-- BIOHZPNShowPlayerNames
-- Checks for players at 3m around the player and displays their name if there's nothing
-- in between them
function BIOHZPNShowPlayerNames()
    
    local myPlayer = System.GetEntity(g_localActorId);

    if (not myPlayer:IsDead()) then
        if (ActionMapManager.IsFilterEnabled('only_ui') == false and ActionMapManager.IsFilterEnabled('inventory') == false) then
            local index = 1;
            local myPlayerPos = myPlayer:GetWorldPos();
            myPlayerPos.z = myPlayerPos.z + 1.4;
            local players = System.GetEntitiesInSphereByClass(myPlayerPos, BIOHZPNMaxDistanceAdmin, 'Player');
            local currentPlayerLength = table.getn(players);

            for key, player in pairs(players) do
                if (player:GetName() ~= myPlayer:GetName()) then
                    local playerPos = player:GetWorldPos();
                    playerPos.z = playerPos.z + 1;
                    local moveToDirection = {x=0, y=0, z=0};
                    local isAdmin = false;
                    local MaxDistance = 100;

                    if (player.BIOHZIsAdmin) then
                        isAdmin = true;
                    end

                    if (player.BIOHZIsAdmin or myPlayer.BIOHZIsAdmin) then
                        MaxDistance = 200;
                    end

                    SubVectors(moveToDirection, playerPos, myPlayerPos);
                    NormalizeVector(moveToDirection);

                    local distanceBetweenPlayers = DistanceVectors(myPlayerPos, playerPos);

                    if (((isAdmin == true or myPlayer.BIOHZIsAdmin) and distanceBetweenPlayers <= 200) or distanceBetweenPlayers <= 15) then
                        moveToDirection = vecScale(moveToDirection, distanceBetweenPlayers);
                        distanceBetweenPlayers = distanceBetweenPlayers - 0.5;

                        g_HitTable = {{},{},{},{},{},{},{},{},{},{}};
                        local hits = Physics.RayWorldIntersection(myPlayerPos, moveToDirection, 1, ent_all + 0x200, myPlayer.id, player.id, g_HitTable);
                        local obstruction = g_HitTable[1];

                        if (hits <= 0 or (obstruction.dist and obstruction.dist >= distanceBetweenPlayers)) then
                            playerPos.z = playerPos.z + 0.9;

                            local pos, offset = UIAction.GetScreenPosFromWorld('mod_BIOHZPlayerNamesDummyUI', 200, playerPos, {x = 0, y = 0, z = 0}, false);

                            if (offset.x == 0 and offset.y == 0) then
                                if (index > BIOHZPNPlayerTagsLength) then
                                    UIAction.ShowElement('mod_BIOHZPlayerNamesUI', index);
                                end

                                if (MaxDistance > 15) then
                                    if (pos.z > 200) then
                                        pos.z = 200;
                                    end

                                    UIAction.SetScale('mod_BIOHZPlayerNamesUI', index, '_root', {x = (100 - pos.z / 2), y = (100 - pos.z / 2), z = 100});
                                    pos.x = pos.x - ((400 * ((100 - pos.z / 2) / 100)) / 2);
                                    pos.y = pos.y - ((50 * ((100 - pos.z / 2) / 100)) / 2) - 10;
                                else
                                    if (pos.z > MaxDistance) then
                                        pos.z = MaxDistance;
                                    end
                                    if (pos.z > 100) then
                                        pos.z = 100;
                                    end

                                    UIAction.SetScale('mod_BIOHZPlayerNamesUI', index, '_root', {x = (100 - pos.z * 3), y = (100 - pos.z * 3), z = 100});
                                    pos.x = pos.x - ((400 * ((100 - pos.z * 3) / 100)) / 2);
                                    pos.y = pos.y - ((50 * ((100 - pos.z * 3) / 100)) / 2) - 10;
                                end

                                UIAction.CallFunction('mod_BIOHZPlayerNamesUI', index, 'setPlayerInfo', player:GetName(), isAdmin);
                                UIAction.SetPos('mod_BIOHZPlayerNamesUI', index, '_root', pos);

                                index = index + 1;
                            else
                                currentPlayerLength = currentPlayerLength - 1;
                            end
                        else
                            currentPlayerLength = currentPlayerLength - 1;
                        end
                    else
                        currentPlayerLength = currentPlayerLength - 1;
                    end
                else
                    currentPlayerLength = currentPlayerLength - 1;
                end
            end

            if (BIOHZPNPlayerTagsLength - currentPlayerLength > 0) then
                for i = BIOHZPNPlayerTagsLength, currentPlayerLength + 1, -1 do
                    UIAction.UnloadElement('mod_BIOHZPlayerNamesUI', i);
                end
            end

            BIOHZPNPlayerTagsLength = currentPlayerLength;
        else
            BIOHZPNPlayerTagsLength = 0;
            UIAction.UnloadElement('mod_BIOHZPlayerNamesUI', -1);
        end

        Script.SetTimerForFunction(10, 'BIOHZPNShowPlayerNamesAfterDelay', {});
    else
        BIOHZPNPlayerTagsLength = 0;
        UIAction.UnloadElement('mod_BIOHZPlayerNamesUI', -1);
        UIAction.UnloadElement('mod_BIOHZPlayerNamesDummyUI', 200);
    end
end

-- BIOHZPNShowPlayerNamesAfterDelay
-- Recalls the function to show names after a delay
function BIOHZPNShowPlayerNamesAfterDelay(dummy)
    BIOHZPNShowPlayerNames();
end


-- Calling the Miscreated Revive player function to initialize the player names script
RegisterCallbackReturnAware(
    Miscreated,
    'RevivePlayer',
    function (self, ret, playerId)

        mSendEvent(
            playerId,
            {
                Type = 'BIOHZPNInitUI',
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