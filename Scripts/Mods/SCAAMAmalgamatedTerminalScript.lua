-- Calling OnInitPreLoaded function to reload the UI on the client
RegisterCallback(_G,
    'OnInitPreLoaded',
    nil,
    function ()
        Log("SCAAMAT >> PreLoading Amalgamated Terminal Config");
        SCAAMATPreInitModules();
    end
);

-- Calling OnInitAllLoaded function to register the amalgamated terminal DB function on Level load
RegisterCallback(_G,
    'OnInitAllLoaded',
    nil,
    function ()
        Log("SCAAMAT >> Loading Amalgamated Terminal Config");
        SCAAMATInitModules();
    end
);