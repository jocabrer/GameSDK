SCAAMShovel = {
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

function SCAAMShovel:Expose()
    Net.Expose {
        Class = self,
        ClientMethods = {
        },
        ServerMethods = {
            DigPatch = { RELIABLE_ORDERED, POST_ATTACH, ENTITYID, ENTITYID }
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

function SCAAMShovel.Server:DigPatch(itemId, playerId)
    SCAAMATDigPatch(itemId, playerId);
end

function SCAAMShovel:OnPropertyChange()
    self:OnReset();
end

function SCAAMShovel:OnEditorSetGameMode(gameMode)

end

function SCAAMShovel:OnReset()

end

function SCAAMShovel.Server:OnShutdown()

end

function SCAAMShovel:OnShutdown()

end

function SCAAMShovel:OnDestroy()

end

function SCAAMShovel:PhysicalizeThis(slot)
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

function SCAAMShovel.Server:OnHit(hit)

end

function SCAAMShovel.Client:OnHit(hit, remote)

end

-- EI Begin

function SCAAMShovel:IsActionable(user)
    if (self.item:CanPickUp(user.id) or self.item:CanUse(user.id) or self.item:IsActionable(user.id)) then
		return 1;
	else
		return 0;
	end
end

function SCAAMShovel:GetActions(user)
    local actions = {};
	actions = self.item:GetActions(user.id, actions);
    return actions;
end

function SCAAMShovel:PerformAction(user, action)
    return self.item:PerformAction(user.id, action);
end

function SCAAMShovel:GetContextActions(item2, actions, targetId, targetPartId)
    table.insert(actions, 1, 'Dig here');

    return actions;
end

function SCAAMShovel:PerformContextAction(action, targetId, targetPartId)
    if (action == 'Dig here') then
        local player = System.GetEntity(g_localActorId);
        local shovel = player.inventory:GetCurrentItem();

        if (shovel and shovel.weapon and shovel.class == 'SCAAMShovel') then
            self.server:DigPatch(self.id, g_localActorId);
        else
            mSendEvent(
                'Server',
                {
                    Type = 'SCAAMATSendMessage',
                    Data = {
                        message = 'Es necesario tener la pala en la mano'
                    }
                },
                false,
                false
            );
        end
    else
        local handled = false;
        local keep = true;

        return handled, keep;
    end
end

function SCAAMShovel:SaveValue()
	return "";
end

function SCAAMShovel:RestoreValue(value)

end

function SCAAMShovel.Server:OnInit()

end

----------------------------------------------------------------------------------------------------
function SCAAMShovel.Client:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
    self:CacheResources();
end

----------------------------------------------------------------------------------
function SCAAMShovel:CacheResources()

end

-- EI End
AddInteractLargeObjectProperty(SCAAMShovel);
SCAAMShovel:Expose();

local function CreateSCAAMShovelTable()
    Log('creating table SCAAMShovel');
    _G['SCAAMShovel'] = new(SCAAMShovel);
end

CreateSCAAMShovelTable();