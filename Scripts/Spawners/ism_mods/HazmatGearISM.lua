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
-- **********************
-- * ALL NEW CATEGORIES *
-- **********************
-- This section contains all new ISM categories for spawning hazmat items
----------------------------
-- Hazmat Item Categories --
----------------------------
--[[
   Most commonly used categories here will be:
   1) RandomHazmatMaskWrath		- Random color hazmat mask
   2) RandomHazmatSuitWrath		- Random color hazmat suit
   3) RandomGasCanisterPackWrath	- Random full hazmat set
   4) RandomFullHazmatSet			- Random full hazmat set
--]]
-- Category for spawning a random hazmat suit
local newItem = {
    category = "RandomHazmatMaskWrath",
	classes = 
	{
		{class = "HazmatMask", percent = 12.5 },
		{class = "HazmatMaskBlack", percent = 12.5 },
		{class = "HazmatMaskBlue", percent = 12.5 },
		{class = "HazmatMaskGreen", percent = 12.5 },
		{class = "HazmatMaskPink", percent = 12.5 },
		{class = "HazmatMaskOrange", percent = 12.5 },
		{class = "HazmatMaskWhite", percent = 12.5 },
		{class = "HazmatMaskYellow", percent = 12.5 },
	},	
 }
table.insert(ItemSpawnerManager.itemCategories, newItem)
-- Category for spawning a random hazmat suit
local newItem = {
    category = "RandomHazmatSuitWrath",
	classes = 
	{
		{class = "HazmatSuitBlack", percent = 15 },
		{class = "HazmatSuitBlue", percent = 14 },
		{class = "HazmatSuitGreen", percent = 14 },
		{class = "HazmatSuitPink", percent = 14 },
		{class = "HazmatSuitOrange", percent = 14 },
		{class = "HazmatSuitWhite", percent = 15 },
		{class = "HazmatSuitYellow", percent = 14 },
	},	
 }
table.insert(ItemSpawnerManager.itemCategories, newItem)
-- Category for spawning a random hazmat suit
local newItem = {
    category = "RandomGasCanisterPackWrath",
	classes = 
	{
		{class = "GasCanisterPack", percent = 12.5 },
		{class = "GasCanisterPackBlack", percent = 12.5 },
		{class = "GasCanisterPackBlue", percent = 12.5 },
		{class = "GasCanisterPackGreen", percent = 12.5 },
		{class = "GasCanisterPackPink", percent = 12.5 },
		{class = "GasCanisterPackOrange", percent = 12.5 },
		{class = "GasCanisterPackWhite", percent = 12.5 },
		{class = "GasCanisterPackYellow", percent = 12.5 },
	},	
 }
table.insert(ItemSpawnerManager.itemCategories, newItem)
-- Category for spawning a random full hazmat set
local newItem = {
    category = "RandomFullHazmatSet",
	group = 
	{
		{ category = "RandomHazmatSuitWrath", percent = 100 },
		{ category = "RandomHazmatMaskWrath", percent = 100 },
		{ category = "RandomGasCanisterPackWrath", percent = 100 },
	},	
 }
table.insert(ItemSpawnerManager.itemCategories, newItem)
--------------------------------
-- * DEV CREATED CATEGORIES * --
--------------------------------
--[[
   This category is the main item spawning category in the Dev ISM
--]]
-- Remove and replace the Dev category to spawn our items
RemoveItemFromTable(ItemSpawnerManager.itemCategories, "category", "RandomHazmatSuit")
local newItem = {
    category = "RandomHazmatSuit",
	classes = 
	{
		{category = "RandomHazmatSuitWrath", percent = 35 },
		{category = "RandomHazmatMaskWrath", percent = 40 },
		{category = "RandomGasCanisterPackWrath", percent = 20 },
		{category = "RandomFullHazmatSet", percent = 5 },
	},	
 }
table.insert(ItemSpawnerManager.itemCategories, newItem)
-- Remove and replace the Dev category to spawn our items
RemoveItemFromTable(ItemSpawnerManager.itemCategories, "category", "RandomHospitalClothesSmall")
local newItem = {
	category = "RandomHospitalClothesSmall",
	classes =
	{
		{ class = "DustMask", percent = 15 },
		{ category = "RandomHazmatMaskWrath", percent = 20 },
		{ class = "GasMask", percent = 5 },
		{ category = "RandomEyes", percent = 5 },
		{ class = "FannyPackGray", percent = 5 },
		{ class = "FannyPackRed", percent = 10 },
		{ class = "FannyPackRedBlue", percent = 5 },
		{ class = "TshirtAmalgamatedBlue", percent = 10 },
		{ class = "SneakersWhite", percent = 10 },
		{ class = "HitopsBlue", percent = 5 },
		{ class = "WoolGlovesBlue", percent = 5 },
		{ class = "WoolGlovesWhite", percent = 5 },
	},
}
table.insert(ItemSpawnerManager.itemCategories, newItem)
-- Remove and replace the Dev category to spawn our items
RemoveItemFromTable(ItemSpawnerManager.itemCategories, "category", "RandomHospitalClothes")
local newItem = {
	category = "RandomHospitalClothes",
	classes =
	{
		{ category = "RandomHospitalClothesSmall", percent = 23 },
		{ category = "RandomClothes", percent = 14 },
		{ category = "RandomHazmatSuitWrath", percent = 14 },
		{ category = "RandomGasCanisterPackWrath", percent = 14 },
		{ class = "RainJacketOrangeBlue", percent = 5},
		{ class = "RainJacketYellow", percent = 5},
		{ class = "RainJacketRed", percent = 5},
		{ class = "ButtonUpShirtBlue", percent = 5},
		{ class = "ButtonUpShirtGrey", percent = 5},
		{ class = "CottonShirtBlue", percent = 5 },
		{ class = "CottonShirtTan", percent = 5 },
	},
}
table.insert(ItemSpawnerManager.itemCategories, newItem)