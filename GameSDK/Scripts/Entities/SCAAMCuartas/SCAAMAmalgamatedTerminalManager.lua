SCAAMAmalgamatedTerminalManager = {
    Properties = {
		bPickable = 1,
		eiPhysicsType = 2, -- not physicalized by default
		bMounted = 0,
		bUsable = 0,
		bSpecialSelect = 0,
		soclasses_SmartObjectClass = "",
        initialSetup = "",
	},

    BuiltChunkCounter = 0,
    BuiltJSON = '',
	
	Client = {},
	Server = {},
	
	Editor = {
		Icon = "Item.bmp",
		IconOnTop = 1,
    },
}

function SCAAMAmalgamatedTerminalManager:Expose()
    Net.Expose {
        Class = self,
        ClientMethods = {
            BuildTheDataUI = { RELIABLE_ORDERED, PRE_ATTACH, STRING, BOOL, INT16, INT16, STRING, STRING, STRING, STRING }
        },
        ServerMethods = {
            RequestData = { RELIABLE_ORDERED, PRE_ATTACH, ENTITYID, INT16, STRING },
            SendLongData = { RELIABLE_ORDERED, PRE_ATTACH, ENTITYID, STRING, STRING, STRING, STRING, STRING }
        },
        ServerProperties = {
		}
    };
end

-- BuildTheDataUI
-- Builds the UI data based on small chunks, due to RMI limitations a string
-- can't be greater than 1030 characters, so it needs to be constructed on multiple
-- RMI calls
function SCAAMAmalgamatedTerminalManager.Client:BuildTheDataUI(operation, stillHasChunks, insertedChunks, totalChunks, chunkOne, chunkTwo, chunkThree, chunkFour)
    local builtChunk = chunkOne .. chunkTwo .. chunkThree .. chunkFour;

    self.BuiltJSON = self.BuiltJSON .. builtChunk;
    self.BuiltChunkCounter = self.BuiltChunkCounter + insertedChunks;

    -- Checks if there's still chunks that need to be grabbed
    if (stillHasChunks == true) then
        self.server:RequestData(g_localActorId, totalChunks, operation);
    else
        self:PerformFinalOperation(operation, totalChunks);
    end
end

-- RequestData
-- Reaches to the server to grab the information left needed
function SCAAMAmalgamatedTerminalManager.Server:RequestData(playerId, totalChunks, operation)
    SCAAMATRequestMoreData(playerId, totalChunks, operation);
end

-- SendLongData
-- Sends a long portion of string data to the server
function SCAAMAmalgamatedTerminalManager.Server:SendLongData(playerId, operation, chunkOne, chunkTwo, chunkThree, chunkFour)
    SCAAMATGetLongData(playerId, operation, chunkOne, chunkTwo, chunkThree, chunkFour);
end

-- PerformFinalOperation
-- Changes the state from idle to active on the menu and populates the sections with info
function SCAAMAmalgamatedTerminalManager:PerformFinalOperation(operation, totalChunks)

    -- Checks if all the chunks were added to the final built string, this to validate
    -- integrity of data because it may happen that some RMI call won't make it
    if (self.BuiltChunkCounter == totalChunks) then
        SCAAMATUIFunctions[operation](SCAAMATUIFunctions, self.BuiltJSON);
    else
        g_gameRules.game:SendTextMessage(0, g_localActorId, 'Failed opening menu, please try again');
    end

    self.BuiltJSON = '';
    self.BuiltChunkCounter = 0;
end

function SCAAMAmalgamatedTerminalManager:OnPropertyChange()
    self:OnReset();
end

function SCAAMAmalgamatedTerminalManager:OnEditorSetGameMode(gameMode)

end

function SCAAMAmalgamatedTerminalManager:OnReset()

end

function SCAAMAmalgamatedTerminalManager.Server:OnHit(hit)

end

function SCAAMAmalgamatedTerminalManager.Client:OnHit(hit, remote)

end

-- EI Begin

function SCAAMAmalgamatedTerminalManager:IsActionable(user)
    return 0;
end

function SCAAMAmalgamatedTerminalManager:GetActions(user)
    local actions = {};

    return actions;
end

function SCAAMAmalgamatedTerminalManager:PerformAction(user, action)

end

function SCAAMAmalgamatedTerminalManager:GetContextActions(item2, actions, targetId, targetPartId)
	return actions;
end

function SCAAMAmalgamatedTerminalManager:PerformContextAction(action, targetId, targetPartId)

end

function SCAAMAmalgamatedTerminalManager.Server:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
end

----------------------------------------------------------------------------------------------------
function SCAAMAmalgamatedTerminalManager.Client:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
    self:CacheResources();
end

----------------------------------------------------------------------------------
function SCAAMAmalgamatedTerminalManager:CacheResources()

end

-- EI End
SCAAMAmalgamatedTerminalManager:Expose();

local function CreateSCAAMAmalgamatedTerminalManagerTable()
    _G['SCAAMAmalgamatedTerminalManager'] = new(SCAAMAmalgamatedTerminalManager);
end

CreateSCAAMAmalgamatedTerminalManagerTable();