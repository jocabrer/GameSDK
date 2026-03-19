SCAAMAppFloppyDisk = {
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

function SCAAMAppFloppyDisk:Expose()
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

function SCAAMAppFloppyDisk.Server:GetFloppyData(itemId, playerId)
    SCAAMATGetFloppyData(itemId, playerId);
end

function SCAAMAppFloppyDisk:OnPropertyChange()
    self:OnReset();
end

function SCAAMAppFloppyDisk:OnEditorSetGameMode(gameMode)

end

function SCAAMAppFloppyDisk:OnReset()

end

function SCAAMAppFloppyDisk.Server:OnShutdown()

end

function SCAAMAppFloppyDisk:OnShutdown()

end

function SCAAMAppFloppyDisk:OnDestroy()

end

function SCAAMAppFloppyDisk:PhysicalizeThis(slot)
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

function SCAAMAppFloppyDisk.Server:OnHit(hit)

end

function SCAAMAppFloppyDisk.Client:OnHit(hit, remote)

end

-- EI Begin

function SCAAMAppFloppyDisk:IsActionable(user)
    if (self.item:CanPickUp(user.id) or self.item:CanUse(user.id) or self.item:IsActionable(user.id)) then
		return 1;
	else
		return 0;
	end
end

function SCAAMAppFloppyDisk:GetActions(user)
    local actions = {};
	actions = self.item:GetActions(user.id, actions);
    return actions;
end

function SCAAMAppFloppyDisk:PerformAction(user, action)
    return self.item:PerformAction(user.id, action);
end

function SCAAMAppFloppyDisk:GetContextActions(item2, actions, targetId, targetPartId)
    table.insert(actions, 1, 'Read label');

    return actions;
end

function SCAAMAppFloppyDisk:PerformContextAction(action, targetId, targetPartId)
    if (action == 'Read label') then
        self.server:GetFloppyData(self.id, g_localActorId);
    else
        local handled = false;
        local keep = true;

        return handled, keep;
    end
end

function SCAAMAppFloppyDisk:SaveValue()
	if (self.SCAAMATAppName == nil) then
        self.SCAAMATAppName = SCAAMATGetRandomApp();
    end

    return self.SCAAMATAppName;
end

function SCAAMAppFloppyDisk:RestoreValue(value)
    self.SCAAMATAppName = value;
end

function SCAAMAppFloppyDisk.Server:OnInit()
    self.SCAAMATAppName = nil;
end

----------------------------------------------------------------------------------------------------
function SCAAMAppFloppyDisk.Client:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
    self:CacheResources();
end

----------------------------------------------------------------------------------
function SCAAMAppFloppyDisk:CacheResources()

end

-- EI End
AddInteractLargeObjectProperty(SCAAMAppFloppyDisk);
SCAAMAppFloppyDisk:Expose();

local function CreateSCAAMAppFloppyDiskTable()
    Log('creating table SCAAMAppFloppyDisk');
    _G['SCAAMAppFloppyDisk'] = new(SCAAMAppFloppyDisk);
end

CreateSCAAMAppFloppyDiskTable();