
RegisterCallback(_G,
    'OnInitPreLoaded',
    nil,
    function ()
        ELPPreInitModules();
        SCAAMATPreInitModules();
        BIOHZMKPreInitModules();
       
    end
);

RegisterCallback(_G,
    'OnInitAllLoaded',
    nil,
    function ()
        BIOHZMKInitModules();
        ELPInitModules();
        APOCCompassInitModules();
        SCAAMATInitModules();
    end
);