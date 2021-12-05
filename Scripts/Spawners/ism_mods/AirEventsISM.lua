-- --------------------------------------------------------------------
-- Wrath added Function 
-- --------------------------------------------------------------------
-- I use this function to remove an entire category from a table based on the category name.
local function RemoveItemFromTable(tbl, keyname, keyvalue)
	for i,v in ipairs(tbl) do
	    if (v[keyname] == keyvalue) then
			-- If the current table category name is the one we are looking for then
			-- remove the category from the table.
	        table.remove(tbl, i);
	        break;
	   end
	end
end
--------------------------------
-- * DEV CREATED CATEGORIES * --
--------------------------------
--[[
   This category is the main item spawning category in the Dev ISM
--]]
---------------------------
-- Random Air Drop Crate --
---------------------------
-- Remove and replace the Dev category to spawn our items
RemoveItemFromTable(ItemSpawnerManager.itemCategories, "category", "RandomAirDropCrateRadiation")
local newItem = {
	category = "RandomAirDropCrateRadiation",
	group =
	{
		{ category = "RandomRangedMilitaryPure", percent = 100 },
		{ class = "AUMP45", percent = 100 },
		{ class = "acp_45x30", percent = 100 },
		{ class = "acp_45x30", percent = 100 },
		{ class = "Pile_45ACP", percent = 100, min = 30, max = 30 },
		{ class = "Pile_45ACP", percent = 100, min = 30, max = 30 },
		-- Changed the Hazmat Gear to Random New Colored Pieces (The following categories can be found in HazmatGearISM.lua)
		{ category = "RandomHazmatMaskWrath", percent = 100 },
		{ category = "RandomHazmatSuitWrath", percent = 100 },
		{ category = "RandomGasCanisterPackWrath", percent = 100 },
		-- End of new item categories
		{ class = "AntiradiationPills", percent = 100, min = 3, max = 3 },
		{ class = "AntiradiationPills", percent = 100, min = 3, max = 3 },
		{ class = "MushroomAntiRad", percent = 100, min = 5, max = 5 },
		{ class = "PotassiumIodidePills", percent = 100, min = 3, max = 3 },
		{ class = "PotassiumIodidePills", percent = 100, min = 3, max = 3 },
		{ class = "WaterPurificationTablets", percent = 100, min = 3, max = 3 },
		{ class = "MRE", percent = 100 },
		{ class = "MRE", percent = 100 },
		{ class = "MRE", percent = 100 },
		{ class = "MRE", percent = 100 },
		{ class = "MRE", percent = 100 },
	},
}
table.insert(ItemSpawnerManager.itemCategories, newItem)
