SCAAMAmalgamatedTerminal = {
    Properties = {
		bPickable = 1,
		eiPhysicsType = 2, -- not physicalized by default
		bMounted = 0,
		bUsable = 0,
		bSpecialSelect = 0,
		soclasses_SmartObjectClass = "",
        initialSetup = "",
	},
	
	Client = {},
	Server = {},
	
	Editor = {
		Icon = "Item.bmp",
		IconOnTop = 1,
    },
}

function SCAAMAmalgamatedTerminal:Expose()
    Net.Expose {
        Class = self,
        ClientMethods = {
            RestoreActions = { RELIABLE_ORDERED, POST_ATTACH, STRING }
        },
        ServerMethods = {
            GetTerminalState = { RELIABLE_ORDERED, POST_ATTACH, ENTITYID, ENTITYID },
            AccessTerminal = { RELIABLE_ORDERED, POST_ATTACH, ENTITYID, ENTITYID },
            ToggleAccessStorage = { RELIABLE_ORDERED, POST_ATTACH, ENTITYID, ENTITYID, STRING }
        },
        ServerProperties = {
		}
    };
end

local Physics_DX9MP_Simple = {
    bPhysicalize = 1, -- True if object should be physicalized at all.
    bPushableByPlayers = 0,

    Density = -1,
    Mass = -1,
    bStaticInDX9Multiplayer = 1
}

function SCAAMAmalgamatedTerminal.Server:GetTerminalState(itemId, playerId)
    SCAAMATGetState(itemId, playerId);
end

function SCAAMAmalgamatedTerminal.Server:AccessTerminal(itemId, playerId)
    SCAAMATAccessTerminal(itemId, playerId);
end

function SCAAMAmalgamatedTerminal.Server:ToggleAccessStorage(itemId, playerId, toggle)
    SCAAMATToggleAccessStorage(itemId, playerId, toggle);
end

function SCAAMAmalgamatedTerminal.Client:RestoreActions(state)
    self.SCAAMLockState = state;
    Script.SetTimerForFunction(10, 'SCAAMAmalgamatedTerminal.ResetActionsAfterDelay', self);
end

function SCAAMAmalgamatedTerminal:ResetActionsAfterDelay()
    local player = System.GetEntity(g_localActorId);
    player.player:ResetActionable();
end

function SCAAMAmalgamatedTerminal:OnPropertyChange()
    self:OnReset();
end

function SCAAMAmalgamatedTerminal:OnEditorSetGameMode(gameMode)

end

function SCAAMAmalgamatedTerminal:OnReset()

end

function SCAAMAmalgamatedTerminal.Server:OnShutdown()

end

function SCAAMAmalgamatedTerminal:OnShutdown()

end

function SCAAMAmalgamatedTerminal:OnDestroy()

end

function SCAAMAmalgamatedTerminal:PhysicalizeThis(slot)
    if (self.Properties.Physics.MP.bDontSyncPos == 1) then
        CryAction.DontSyncPhysics(self.id);
    end

    local physics = self.Properties.Physics;
    if (CryAction.IsImmersivenessEnabled() == 0) then
        physics = Physics_DX9MP_Simple;
    end
    EntityCommon.PhysicalizeRigid(self, slot, physics, 1);

    if (physics.Buoyancy) then
        self:SetPhysicParams(PHYSICPARAM_BUOYANCY, physics.Buoyancy);
    end
end

function SCAAMAmalgamatedTerminal.Server:OnHit(hit)

end

function SCAAMAmalgamatedTerminal.Client:OnHit(hit, remote)

end

-- EI Begin

function SCAAMAmalgamatedTerminal:IsActionable(user)
    return 1;
end

function SCAAMAmalgamatedTerminal:GetActions(user)
    local actions = {};

    if (self.SCAAMLockState) then
        ActionMapManager.EnableActionFilter('incapacitated_partial', false);

        if (self.SCAAMLockState == 'inuse') then
            table.insert(actions, 'This device is in use');
            ActionMapManager.EnableActionFilter('incapacitated_partial', true);
            self:CheckForActionableUI();
        else
            actions = self.item:GetActions(user.id, actions);
            table.insert(actions, 1, 'Examine drives');
            table.insert(actions, 1, 'Access terminal');

            for key, value in pairs(actions) do
                if (value == '@item_open_inventory') then
                    table.remove(actions, key);
                    break;
                end
            end
            ActionMapManager.EnableActionFilter('incapacitated_partial', true);
            self:CheckForActionableUI();
        end

        self.SCAAMLockState = nil;
    else
        ActionMapManager.EnableActionFilter('incapacitated_partial', false);
        self.server:GetTerminalState(self.id, user.id);
    end

    return actions;
end

function SCAAMAmalgamatedTerminal:CheckForActionableUI()
    Script.SetTimerForFunction(50, 'SCAAMAmalgamatedTerminal.CheckForActionableUIAfterDelay', self);
end

function SCAAMAmalgamatedTerminal:CheckForActionableUIAfterDelay()
    local player = System.GetEntity(g_localActorId);

    if (player.player:GetActionableEntityId() == self.id) then
        self:CheckForActionableUI();
    else
        ActionMapManager.EnableActionFilter('incapacitated_partial', false);
    end
end

function SCAAMAmalgamatedTerminal:PerformAction(user, action)
    if (action == 'Access terminal') then
        self.server:AccessTerminal(self.id, user.id);
        SCAAMATAccessedTerminalId = self.id;
    elseif (action == 'Examine drives') then
        self.server:ToggleAccessStorage(self.id, user.id, 'true');
        self:CheckForReleasedStorage();
        ActionMapManager.EnableActionFilter('inventory', true);
        return self.item:PerformAction(user.id, '@item_open_inventory');
    else
        return self.item:PerformAction(user.id, action);
    end
end

function SCAAMAmalgamatedTerminal:CheckForReleasedStorage()
    Script.SetTimerForFunction(50, 'SCAAMAmalgamatedTerminal.CheckForReleasedStorageAfterDelay', self);
end

function SCAAMAmalgamatedTerminal:CheckForReleasedStorageAfterDelay()
    if (ActionMapManager.IsFilterEnabled('inventory') == true) then
        self:CheckForReleasedStorage();
    else
        self.server:ToggleAccessStorage(self.id, g_localActorId, 'false');
    end
end

function SCAAMAmalgamatedTerminal:SaveValue()
	return "";
end

function SCAAMAmalgamatedTerminal:RestoreValue(value)

end

function SCAAMAmalgamatedTerminal.Server:OnInit()
    
end

----------------------------------------------------------------------------------------------------
function SCAAMAmalgamatedTerminal.Client:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
    self:CacheResources();
end

----------------------------------------------------------------------------------
function SCAAMAmalgamatedTerminal:CacheResources()

end

-- EI End
AddInteractLargeObjectProperty(SCAAMAmalgamatedTerminal);
SCAAMAmalgamatedTerminal:Expose();

local function CreateSCAAMAmalgamatedTerminalTable()
    Log('creating table SCAAMAmalgamatedTerminal');
    _G['SCAAMAmalgamatedTerminal'] = new(SCAAMAmalgamatedTerminal);
end

CreateSCAAMAmalgamatedTerminalTable();