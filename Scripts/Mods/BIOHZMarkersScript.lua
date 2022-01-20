-- Calling OnInitPreLoaded function to reload the UI on the client
RegisterCallback(_G,
    'OnInitPreLoaded',
    nil,
    function ()
        Log("BIOHZMarkers >> PreLoading Player info Config");
        BIOHZMKPreInitModules();
    end
);

RegisterCallback(_G,
    'OnInitAllLoaded',
    nil,
    function ()
        Log("BIOHZMarkers >> Loading Player info Config");
        BIOHZMKInitModules();
    end
);