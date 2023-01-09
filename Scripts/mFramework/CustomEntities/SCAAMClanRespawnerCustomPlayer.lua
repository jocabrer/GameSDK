local SCAAMClanRespawnerCustomPlayer = {
    Methods = {
        Client = {
            SCCRToggleTheUI = function(self, toggle, chunkOne, chunkTwo, chunkThree, chunkFour)
                local builtChunk = chunkOne .. chunkTwo .. chunkThree .. chunkFour;

                SCAAMClanRespawnerUIFunctions:ToggleTheClanRespawner(toggle, builtChunk);
            end
        },
        Server = {}
    },
    Expose = {
        ClientMethods = {
            SCCRToggleTheUI = { RELIABLE_ORDERED, POST_ATTACH, BOOL, STRING, STRING, STRING, STRING }
        },
        ServerMethods = {},
        ServerProperties = {}
    }
}

Log(">> Loading mFramework SCAAMClanRespawnerCustomPlayer");
local _status, _result = mReExpose('Player', SCAAMClanRespawnerCustomPlayer.Methods, SCAAMClanRespawnerCustomPlayer.Expose);
Log(">> Result: " .. tostring(_status or "Failed") .. " " .. tostring(_result or "No Message"));