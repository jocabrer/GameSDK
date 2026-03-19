-- Calling OnInitPreLoaded function to reload the UI on the client
RegisterCallback(_G,
    'OnInitPreLoaded',
    nil,
    function ()
        ELPPreInitModules();
        APOCCIPreInitModules();
    end
);

-- Calling OnInitAllLoaded function to load the hidden code
RegisterCallback(_G,
    'OnInitAllLoaded',
    nil,
    function ()
        Log("ELProject >> Loading hidden code");
        ELPInitModules();
        APOCCIInitModules();
    end
);


