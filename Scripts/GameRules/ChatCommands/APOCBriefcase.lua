-- Apocalypse briefcase v1.0
-- Created by Cuartas property of Apocalypse Now

Log('APOC >> Loading briefcase items')
Script.LoadScript('Scripts/Entities/ScriptAPOC/SAPOCBriefcase.lua');
Script.LoadScript('Scripts/Entities/ScriptAPOC/SAPOCBriefcaseClosed.lua');

APOCBriefcaseCooldownActive = false;

function APOCBriefcasePreventDupe()
    APOCBriefcaseCooldownActive = true;

    Script.SetTimerForFunction(1000, 'APOCBriefcaseEnableFunctions', {});
end

function APOCBriefcaseEnableFunctions(dummyData)
    APOCBriefcaseCooldownActive = false;
end