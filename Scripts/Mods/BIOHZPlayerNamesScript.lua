-- Calling OnInitPreLoaded function to reload the UI on the client
RegisterCallback(_G,
    'OnInitPreLoaded',
    nil,
    function ()
        Log("BIOHZPlayerNames >> PreLoading Player info Config");
        BIOHZPNPreInitModules();
    end
);