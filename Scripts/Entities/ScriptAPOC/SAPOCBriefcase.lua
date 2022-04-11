SAPOCBriefcase = {
    Properties = {
        fileModel = "Objects/Lekka/scifipc/scifipc.cgf",
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

function SAPOCBriefcase:Expose()
    Net.Expose {
        Class = self,
        ClientMethods = {
            DeployAirdrop = { RELIABLE_ORDERED, POST_ATTACH }
        },
        ServerMethods = {
            CallAirdrop = { RELIABLE_ORDERED, POST_ATTACH, ENTITYID },
            PackUpBriefcase = { RELIABLE_ORDERED, POST_ATTACH, ENTITYID }
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

function SAPOCBriefcase.Client:DeployAirdrop()
    local soundTriggerID = AudioUtils.LookupTriggerID('Play_microwave_food_done');

    if (soundTriggerID ~= nil) then
        self:ExecuteAudioTrigger(soundTriggerID, self:GetDefaultAuxAudioProxyID());
    end
end

function SAPOCBriefcase.Server:CallAirdrop(playerId)

    local player = System.GetEntity(playerId);
    local playerName = player:GetName();

    if (self and APOCBriefcaseCooldownActive == false) then
        APOCBriefcasePreventDupe();
        local position = self:GetWorldPos();
        self:DeleteThis();

        local airdropPos = {};

        local waterElevation = System.GetCVar('e_OceanLevelOffset2');

        local isValidPosition = false;

        while (isValidPosition == false) do
            airdropPos = new(position);

            local terrainElevation = System.GetTerrainElevation(airdropPos);

            if (terrainElevation > waterElevation) then
                airdropPos.z = terrainElevation + 250;

                Physics.RayWorldIntersection(airdropPos, {x = 0, y = 0, z = (-1 * 260)}, 1, ent_all, nil, nil, g_HitTable);

                if (g_HitTable[1].dist >= 119) then
                    isValidPosition = true;
                    airdropPos.z = terrainElevation + 500;
                end
            end
        end

        ISM.SpawnItem('SuitCaseCrate', airdropPos);

        if (System.IsEditor()) then
            g_gameRules.game:SendTextMessage(0, g_localActorId, "A Player has called in an Airdrop");
        else
            g_gameRules.game:SendTextMessage(0, 0, "El jugador " ..playerName.. " solicitó un Airdrop");
            g_gameRules.game:SendTextMessage(4, 0, "El jugador " ..playerName.. " solicitó una entrega de Airdrop");
            g_gameRules.game:SendTextMessage(4, 0, "The player " ..playerName.. " requested an airdrop delivery");
        end
    end
end

function SAPOCBriefcase.Server:PackUpBriefcase(playerId)
    if (self and APOCBriefcaseCooldownActive == false) then
        APOCBriefcasePreventDupe();
        local position = self:GetWorldPos();
        local player = System.GetEntity(playerId);
        local playerRotation = player:GetDirectionVector();

        self:DeleteThis();
        local briefcase = ISM.SpawnItem('SAPOCBriefcaseClosed', position);
        briefcase:SetDirectionVector(playerRotation);
    end
end

function SAPOCBriefcase:OnPropertyChange()
    self:OnReset();
end

function SAPOCBriefcase:OnEditorSetGameMode(gameMode)

end

function SAPOCBriefcase:OnReset()

end

function SAPOCBriefcase:PhysicalizeThis(slot)
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

function SAPOCBriefcase.Server:OnHit(hit)

end

function SAPOCBriefcase.Client:OnHit(hit, remote)

end

-- EI Begin

function SAPOCBriefcase:IsActionable(user)
    return 1;
end

function SAPOCBriefcase:GetActions(user)
    local actions = {};
    table.insert(actions, "Llamar AirDrop / Call AirDrop");
    table.insert(actions, "Cerrar / Close");

    return actions;
end

function SAPOCBriefcase:PerformAction(user, action)
    if (self) then
        if (action == "Llamar AirDrop / Call AirDrop") then
            self.server:CallAirdrop(user.id);
        elseif (action == "Cerrar / Close") then
            self.server:PackUpBriefcase(user.id);
        else
            return self.item:PerformAction(user.id, action);
        end
    end
end

function SAPOCBriefcase.Server:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
end

----------------------------------------------------------------------------------------------------
function SAPOCBriefcase.Client:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
    self:CacheResources();
end

----------------------------------------------------------------------------------
function SAPOCBriefcase:CacheResources()

end

-- EI End
AddInteractLargeObjectProperty(SAPOCBriefcase);
SAPOCBriefcase:Expose();

local function CreateSAPOCBriefcaseTable()
    _G['SAPOCBriefcase'] = new(SAPOCBriefcase);
end

CreateSAPOCBriefcaseTable();