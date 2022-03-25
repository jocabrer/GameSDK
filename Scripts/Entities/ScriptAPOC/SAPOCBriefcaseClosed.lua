SAPOCBriefcaseClosed = {
    Properties = {
        fileModel = "Objects/Lekka/scifipc/scifipcclosed.cgf",
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

function SAPOCBriefcaseClosed:Expose()
    Net.Expose {
        Class = self,
        ClientMethods = {
        },
        ServerMethods = {
            PlaceBriefcase = { RELIABLE_ORDERED, POST_ATTACH, ENTITYID }
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

function SAPOCBriefcaseClosed.Server:PlaceBriefcase(playerId)
    if (self and APOCBriefcaseCooldownActive == false) then
        APOCBriefcasePreventDupe()
        local position = self:GetWorldPos();
        local player = System.GetEntity(playerId);
        local playerRotation = player:GetDirectionVector();

        self:DeleteThis();
        local briefcase = ISM.SpawnItem('SAPOCBriefcase', position);
        briefcase:SetDirectionVector(playerRotation);
    end
end

function SAPOCBriefcaseClosed:OnPropertyChange()
    self:OnReset();
end

function SAPOCBriefcaseClosed:OnEditorSetGameMode(gameMode)

end

function SAPOCBriefcaseClosed:OnReset()

end

function SAPOCBriefcaseClosed:PhysicalizeThis(slot)
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

function SAPOCBriefcaseClosed.Server:OnHit(hit)

end

function SAPOCBriefcaseClosed.Client:OnHit(hit, remote)

end

-- EI Begin

function SAPOCBriefcaseClosed:IsActionable(user)
    if (self.item:CanPickUp(user.id) or self.item:CanUse(user.id) or self.item:IsActionable(user.id)) then
		return 1;
	else
		return 0;
	end
end

function SAPOCBriefcaseClosed:GetActions(user)
    local actions = {};
    actions = self.item:GetActions(user.id, actions);
    table.insert(actions, "Abrir / Open");

    return actions;
end

function SAPOCBriefcaseClosed:PerformAction(user, action)
    if (self) then
        if (action == "Abrir / Open") then
            self.server:PlaceBriefcase(user.id);
        else
            return self.item:PerformAction(user.id, action);
        end
    end
end

function SAPOCBriefcaseClosed.Server:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
end

----------------------------------------------------------------------------------------------------
function SAPOCBriefcaseClosed.Client:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
    self:CacheResources();
end

----------------------------------------------------------------------------------
function SAPOCBriefcaseClosed:CacheResources()

end

-- EI End
AddInteractLargeObjectProperty(SAPOCBriefcaseClosed);
SAPOCBriefcaseClosed:Expose();

local function CreateSAPOCBriefcaseClosedTable()
    _G['SAPOCBriefcaseClosed'] = new(SAPOCBriefcaseClosed);
end

CreateSAPOCBriefcaseClosedTable();