-- Calling OnInitPreLoaded function to reload the UI on the client
RegisterCallback(_G,
    'OnInitPreLoaded',
    nil,
    function ()
        Log("SCAAMClanRespawner >> PreLoading Clan respawner Config");
        SCAAMClanRespawnerPreInitModules();
    end
);


-- Calling OnInitAllLoaded function to register the Clan Respawner config on level load
RegisterCallback(_G,
    'OnInitAllLoaded',
    nil,
    function ()
        Log("SCAAMClanRespawner >> Loading Clan Respawner Config");
        SCAAMClanRespawnerInitModules();
    end
);