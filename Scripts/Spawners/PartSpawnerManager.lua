PartSpawnerManager = {

--[[
	We should make the spawn percents match about what would be used on a real base:
	Walls being very common, doors not as much, gatehouse rare (only used once or twice per base)
--]]

	categories =
	{
		{
			category = "metal_part",
			classes =
			{
				-- doors (7)
				--{ class = "metal_door_lockable_1m_2m", percent = 5 },

				-- walls (55.99)
				--{ class = "metal_aframe_3m_4m", percent = 2 },
				--{ class = "metal_wall_1_3m_2m", percent = 2 },
				--{ class = "metal_wall_1_3m_4m", percent = 2 }, 
				--{ class = "metal_wall_2m_2m", percent = 2 },
				--{ class = "metal_wall_2m_4m", percent = 2 },
				--{ class = "metal_wall_3m_2m", percent = 2 },
				

				{ class = "office_desk_tow_packed"                , percent = 6 },
				{ class = "umbrella_open_tow_packed"              , percent = 5 }, 
				{ class = "mapsign_tow_packed"                    , percent = 5 },
				{ class = "green_tent_tow_packed"                 , percent = 5 },
				{ class = "electric_stove_storage_packed"         , percent = 6 },
				{ class = "gnome_giant_c"                         , percent = 10 },
				{ class = "arcade_cabinet"                        , percent = 10 },
                { class = "fridge_modern_tow_packed"			  , percent = 6 }, 
				{ class = "oil_rack_storage_packed"				  , percent = 5 },
				{ class = "toilet_tow_packed"   				  , percent = 6 },
				{ class = "icemachine_tow_packed"				  , percent = 6 },
				{ class = "vendingmachine_2_tow_packed"	  	      , percent = 6 },
				{ class = "vendingmachine_1_tow_packed"			  , percent = 6 },
				{ class = "mailbox_storage_packed"   			  , percent = 6 },
				{ class = "whiteboard_tow_packed"   			  , percent = 6 },
				--{ class = "christmas_tree", percent = 15 }, 
			},
		},   
	},
}

--------------------------------------------------------------------------
-- Functions called from C++
--------------------------------------------------------------------------
function PartSpawnerManager:OnInit()
	--Log("PartSpawnerManager:OnInit");

	self:OnReset();
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function PartSpawnerManager:OnPropertyChange()
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function PartSpawnerManager:OnReset()
	--Log("PartSpawnerManager:OnReset");
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnSpawn called Editor/Game.
------------------------------------------------------------------------------------------------------
function PartSpawnerManager:OnSpawn()
	self:Reset();
end

function PartSpawnerManager:Reset()
	--Log("PartSpawnerManager:Reset");
end

-- Load mods
Script.LoadScriptFolder("scripts/spawners/part_mods", true, true)