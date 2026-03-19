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
				-- props comunes (30–40%)
				{ class = "office_desk_tow_packed",      percent = 30 },
				{ class = "umbrella_open_tow_packed",    percent = 30 },
				{ class = "mapsign_tow_packed",          percent = 25 },
				{ class = "gnome_giant_c",               percent = 25 },
				{ class = "arcade_cabinet",              percent = 20 },
				{ class = "oil_rack_storage_packed",     percent = 25 },
				{ class = "toilet_tow_packed",           percent = 25 },
				{ class = "icemachine_tow_packed",       percent = 25 },
				{ class = "vendingmachine_2_tow_packed", percent = 25 },
				{ class = "vendingmachine_1_tow_packed", percent = 25 },
				{ class = "mailbox_storage_packed",      percent = 20 },
				{ class = "whiteboard_tow_packed",       percent = 20 },
				{ class = "payphone_tow_packed",         percent = 20 },

				-- raros / valiosos
				{ class = "metal_safe",                  percent = 5 },
				{ class = "safe_large",                  percent = 2 },
				{ class = "safedoor_large2",             percent = 1 },
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
