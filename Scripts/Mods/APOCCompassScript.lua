-- APOC Compass Mod v1.0
-- Created by Lucy https://steamcommunity.com/profiles/76561198854231156/ ,Copyright 2020

-- Calling OnInitAllLoaded function to register the compass config on level load
RegisterCallback(_G,
    'OnInitAllLoaded',
    nil,
    function ()
        Log("APOCCompassMod >> Loading Compass Config");
        APOCCompassInitModules();
    end
);