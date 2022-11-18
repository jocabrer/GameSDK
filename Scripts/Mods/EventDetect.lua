Log('>> SeasonalEvents : Loading EventDetect.lua...') 

RegisterCallback(_G, 
	'OnInitPreLoaded', 
	nil, 
	function()
		CurrentMonth = os.date('%m')
		CurrentDay = os.date('%d')
		Log('>> SeasonalEvents : Current System Date : ' .. CurrentDay .. '-' .. CurrentMonth)
		
	-- Halloween lasts from octobre 15 to november 5
		if CurrentMonth == '10' then
			if tonumber(CurrentDay) >= 15 then 
				-- deploy Halloween
				Log('>> SeasonalEvents : Halloween Event')
				Script.ReloadScript('Scripts/ModUtils/HalloweenEvent.lua')
			end
		elseif CurrentMonth == '11' then
			if tonumber(CurrentDay) <= 3 then
				-- deploy Halloween
				Log('>> SeasonalEvents : Halloween Event')
				Script.ReloadScript('Scripts/ModUtils/HalloweenEvent.lua')
			end
			
	-- Christmas lasts from december 15 to december 31
		elseif CurrentMonth == '12' then
			if tonumber(CurrentDay) >= 15 then
				-- deploy Christmas
				Log('>> SeasonalEvents : Christmas Event')
				Script.ReloadScript('Scripts/ModUtils/ChristmasEvent.lua')
			end
			
	-- Valentine lasts from february 10 to february 24
		elseif CurrentMonth == '02' then
			if tonumber(CurrentDay) >= 10 and tonumber(CurrentDay) <= 24 then
				-- deploy Valentine
				Log('>> SeasonalEvents : Valentine Event')
				Script.ReloadScript('Scripts/ModUtils/ValentineEvent.lua')
			end
			
	-- Easter lasts from april 10 to april 30
		elseif CurrentMonth == '04' then
			if tonumber(CurrentDay) >= 10 then
				-- deploy Easter
				Log('>> SeasonalEvents : Easter Event')
				Script.ReloadScript('Scripts/ModUtils/EasterEvent.lua')
			end
		-- disable easter crafting recipes on may 1
		elseif CurrentMonth == '05' then
			if tonumber(CurrentDay) == 01 then
				Log('>> SeasonalEvents : Removing Easter recipes')
				Script.ReloadScript('Scripts/ModUtils/ClearEvents.lua')
			end
		else
			Log('>> SeasonalEvents : no scheduled event, skipping')
		end
	end)