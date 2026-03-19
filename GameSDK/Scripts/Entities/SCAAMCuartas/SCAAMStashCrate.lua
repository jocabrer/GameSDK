SCAAMStashCrate = {
    type = "SCAAMStashCrate",

    Properties = {
        fileModel = "Objects/SCAAMCuartas/IronSonsStash/ironsonsstash.cgf",
        ModelSubObject = "",
		bPickable = 1,
		bMounted = 0,
		bUsable = 0,
		bSpecialSelect = 0,
		soclasses_SmartObjectClass = "",
        initialSetup = "",

        Physics = {
            bRigidBody = 0,
            bRigidBodyActive = 0,
            bResting = 0,
            Density = -1,
            Mass = -1,
            Buoyancy = {
                water_density = 0,
                water_damping = 0,
                water_resistance = 0
            },
            bStaticInDX9Multiplayer = 1,
            MP = {bDontSyncPos = 0}
        }
    },
	
	Client = {},
	Server = {},
	
	Editor = {
		Icon = "Item.bmp",
		IconOnTop = 1,
    },
}

function SCAAMStashCrate:Expose()
    Net.Expose {
        Class = self,
        ClientMethods = {
        },
        ServerMethods = {
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

function SCAAMStashCrate:OnPropertyChange()
    self:OnReset();
end

function SCAAMStashCrate:OnEditorSetGameMode(gameMode)

end

function SCAAMStashCrate:OnReset()
    local props = self.Properties;
    if (not EmptyString(props.fileModel)) then
        self:LoadSubObject(0, props.fileModel, props.ModelSubObject);
    end

    self:PhysicalizeThis(0);
end

function SCAAMStashCrate:PhysicalizeThis(slot)
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

function SCAAMStashCrate.Server:OnHit(hit)

end

function SCAAMStashCrate.Client:OnHit(hit, remote)

end

-- EI Begin

function SCAAMStashCrate:IsActionable(user)
    if (self.item:CanPickUp(user.id) or self.item:CanUse(user.id) or self.item:IsActionable(user.id)) then
		return 1;
	else
		return 0;
	end
end

function SCAAMStashCrate:GetActions(user)
    local actions = {};
    table.insert(actions, '@item_open_inventory');
    return actions;
end

function SCAAMStashCrate:PerformAction(user, action)
    return self.item:PerformAction(user.id, action);
end

function SCAAMStashCrate.Server:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
end

----------------------------------------------------------------------------------------------------
function SCAAMStashCrate.Client:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
    self:CacheResources();
end

----------------------------------------------------------------------------------
function SCAAMStashCrate:CacheResources()

end

-- EI End
AddInteractLargeObjectProperty(SCAAMStashCrate);
SCAAMStashCrate:Expose();

local function CreateSCAAMStashCrateTable()
    _G['SCAAMStashCrate'] = new(SCAAMStashCrate);
end

CreateSCAAMStashCrateTable();