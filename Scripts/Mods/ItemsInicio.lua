function itemPlace()
    local spawnPos = {x=1714, y=2195, z=32} -- replace with the position you want your item to appear
    ISM.SpawnCategory("AirPlaneCrashCrateMilitary", spawnPos);

end


function itemSpawn()
    if CryAction.IsDedicatedServer() then -- ensure we only act server side
    Script.SetTimerForFunction(10000, 'itemPlace', self) -- delay the placement by 10s to ensure everything is loaded properly first
    end
end

RegisterCallback(_G, 'OnInitAllLoaded', nil, function() itemSpawn() end ) -- RegisterCallback to fire the script at the correct time