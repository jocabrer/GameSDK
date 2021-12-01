SCAAMGameFloppyDisk = {
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

function SCAAMGameFloppyDisk:Expose()
    Net.Expose {
        Class = self,
        ClientMethods = {
        },
        ServerMethods = {
            GetFloppyData = { RELIABLE_ORDERED, POST_ATTACH, ENTITYID, ENTITYID }
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

function SCAAMGameFloppyDisk.Server:GetFloppyData(itemId, playerId)
    SCAAMATGetFloppyData(itemId, playerId);
end

function SCAAMGameFloppyDisk:OnPropertyChange()
    self:OnReset();
end

function SCAAMGameFloppyDisk:OnEditorSetGameMode(gameMode)

end

function SCAAMGameFloppyDisk:OnReset()

end

function SCAAMGameFloppyDisk.Server:OnShutdown()

end

function SCAAMGameFloppyDisk:OnShutdown()

end

function SCAAMGameFloppyDisk:OnDestroy()

end

function SCAAMGameFloppyDisk:PhysicalizeThis(slot)
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

function SCAAMGameFloppyDisk.Server:OnHit(hit)

end

function SCAAMGameFloppyDisk.Client:OnHit(hit, remote)

end

-- EI Begin

function SCAAMGameFloppyDisk:IsActionable(user)
    if (self.item:CanPickUp(user.id) or self.item:CanUse(user.id) or self.item:IsActionable(user.id)) then
		return 1;
	else
		return 0;
	end
end

function SCAAMGameFloppyDisk:GetActions(user)
    local actions = {};
	actions = self.item:GetActions(user.id, actions);
    return actions;
end

function SCAAMGameFloppyDisk:PerformAction(user, action)
    return self.item:PerformAction(user.id, action);
end

function SCAAMGameFloppyDisk:GetContextActions(item2, actions, targetId, targetPartId)
    table.insert(actions, 1, 'Read label');

    return actions;
end

function SCAAMGameFloppyDisk:PerformContextAction(action, targetId, targetPartId)
    if (action == 'Read label') then
        self.server:GetFloppyData(self.id, g_localActorId);
    else
        local handled = false;
        local keep = true;

        return handled, keep;
    end
end

function SCAAMGameFloppyDisk:SaveValue()
	if (self.SCAAMATAppName == nil) then
        self.SCAAMATAppName = SCAAMATGetRandomGame();
    end

    return self.SCAAMATAppName;
end

function SCAAMGameFloppyDisk:RestoreValue(value)
    self.SCAAMATAppName = value;
end

function SCAAMGameFloppyDisk.Server:OnInit()
    self.SCAAMATAppName = nil;
end

----------------------------------------------------------------------------------------------------
function SCAAMGameFloppyDisk.Client:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
    self:CacheResources();
end

----------------------------------------------------------------------------------
function SCAAMGameFloppyDisk:CacheResources()

end

-- EI End
AddInteractLargeObjectProperty(SCAAMGameFloppyDisk);
SCAAMGameFloppyDisk:Expose();

local function CreateSCAAMGameFloppyDiskTable()
    Log('creating table SCAAMGameFloppyDisk');
    _G['SCAAMGameFloppyDisk'] = new(SCAAMGameFloppyDisk);
end

CreateSCAAMGameFloppyDiskTable();