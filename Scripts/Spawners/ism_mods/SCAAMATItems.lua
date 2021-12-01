-------------------------------------------------------
-- CUSTOM SPAWNER BY MNEWRATH --
-------------------------------------------------------
-- Function to find items in a table
function FindInTable(tbl, keyname, keyvalue)
	for i,v in ipairs(tbl) do
		if (v[keyname] == keyvalue) then
			return v
		end
	end
end
-- Function to store the names of items to adjust
function GetItemsToAdjust(tbl, keyname, arr)
    local a = {}
    if (arr ~= nil) then
        a = arr
    end
	for i,v in ipairs(tbl) do
	    if (v[keyname] ~= nil) then
	        table.insert(a, v[keyname])
	    end
	end
	return a
end
-- Function to get table length
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
-- Function to round a number to the desired decimal
function round(number, decimals)
    local power = 10^decimals
    return math.floor(number * power) / power
end
-- ------------------------------------------------------------------
-- MAIN LUA USED TO ADD YOUR NEW ITEM AND ADJUST VALUES IN THE ISM --
-- ------------------------------------------------------------------
local newItem = {
    class = "SCAAMShovel",
    percent = 6,
}

local categoryToAdjust = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomMelee")
local itemtype = nil
local itemcount = 0

if categoryToAdjust.group then
    itemtype = categoryToAdjust.group
elseif categoryToAdjust.classes then
    itemtype = categoryToAdjust.classes
end

local itemnamestoadjust = {}
local highpercentname = nil
local highpercent = 0

for i,v in pairs(itemtype) do
    if v.category then
        table.insert(itemnamestoadjust, v.category)
    elseif v.class then
        table.insert(itemnamestoadjust, v.class)
	end

    if v.percent > highpercent then
        if v.category then 
            highpercentname = v.category
        elseif v.class then 
            highpercentname = v.class
		end

        highpercent = v.percent
    end
end

itemcount = tablelength(itemnamestoadjust)
table.insert(itemtype, newItem)
local percentperitem = round(newItem.percent / itemcount, 2)
local leftover = newItem.percent - percentperitem * itemcount
local categoryItemToAdjust = nil

for i,v in pairs(itemnamestoadjust) do
    if FindInTable(itemtype, "category", v) then
        categoryItemToAdjust = FindInTable(itemtype, "category", v)
    elseif FindInTable(itemtype, "class", v) then
        categoryItemToAdjust = FindInTable(itemtype, "class", v)
    end
    if categoryItemToAdjust.percent > percentperitem then
        categoryItemToAdjust.percent = categoryItemToAdjust.percent - percentperitem
    else
        leftover = leftover + percentperitem
    end
end

if FindInTable(itemtype, "category", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "category", highpercentname)
elseif FindInTable(itemtype, "class", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "class", highpercentname)
end

categoryItemToAdjust.percent = categoryItemToAdjust.percent - leftover

-- Floppy disk game
newItem = {
    class = "SCAAMGameFloppyDisk",
    percent = 1,
}

categoryToAdjust = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomElectronicsContent")
itemtype = nil
itemcount = 0

if categoryToAdjust.group then
    itemtype = categoryToAdjust.group
elseif categoryToAdjust.classes then
    itemtype = categoryToAdjust.classes
end

itemnamestoadjust = {}
highpercentname = nil
highpercent = 0

for i,v in pairs(itemtype) do
    if v.category then
        table.insert(itemnamestoadjust, v.category)
    elseif v.class then
        table.insert(itemnamestoadjust, v.class)
	end

    if v.percent > highpercent then
        if v.category then 
            highpercentname = v.category
        elseif v.class then 
            highpercentname = v.class
		end

        highpercent = v.percent
    end
end

itemcount = tablelength(itemnamestoadjust)
table.insert(itemtype, newItem)
percentperitem = round(newItem.percent / itemcount, 2)
leftover = newItem.percent - percentperitem * itemcount
categoryItemToAdjust = nil

for i,v in pairs(itemnamestoadjust) do
    if FindInTable(itemtype, "category", v) then
        categoryItemToAdjust = FindInTable(itemtype, "category", v)
    elseif FindInTable(itemtype, "class", v) then
        categoryItemToAdjust = FindInTable(itemtype, "class", v)
    end
    if categoryItemToAdjust.percent > percentperitem then
        categoryItemToAdjust.percent = categoryItemToAdjust.percent - percentperitem
    else
        leftover = leftover + percentperitem
    end
end

if FindInTable(itemtype, "category", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "category", highpercentname)
elseif FindInTable(itemtype, "class", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "class", highpercentname)
end

categoryItemToAdjust.percent = categoryItemToAdjust.percent - leftover

newItem = {
    class = "SCAAMGameFloppyDisk",
    percent = 1,
}

categoryToAdjust = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomDeskContent")
itemtype = nil
itemcount = 0

if categoryToAdjust.group then
    itemtype = categoryToAdjust.group
elseif categoryToAdjust.classes then
    itemtype = categoryToAdjust.classes
end

itemnamestoadjust = {}
highpercentname = nil
highpercent = 0

for i,v in pairs(itemtype) do
    if v.category then
        table.insert(itemnamestoadjust, v.category)
    elseif v.class then
        table.insert(itemnamestoadjust, v.class)
	end

    if v.percent > highpercent then
        if v.category then 
            highpercentname = v.category
        elseif v.class then 
            highpercentname = v.class
		end

        highpercent = v.percent
    end
end

itemcount = tablelength(itemnamestoadjust)
table.insert(itemtype, newItem)
percentperitem = round(newItem.percent / itemcount, 2)
leftover = newItem.percent - percentperitem * itemcount
categoryItemToAdjust = nil

for i,v in pairs(itemnamestoadjust) do
    if FindInTable(itemtype, "category", v) then
        categoryItemToAdjust = FindInTable(itemtype, "category", v)
    elseif FindInTable(itemtype, "class", v) then
        categoryItemToAdjust = FindInTable(itemtype, "class", v)
    end
    if categoryItemToAdjust.percent > percentperitem then
        categoryItemToAdjust.percent = categoryItemToAdjust.percent - percentperitem
    else
        leftover = leftover + percentperitem
    end
end

if FindInTable(itemtype, "category", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "category", highpercentname)
elseif FindInTable(itemtype, "class", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "class", highpercentname)
end

categoryItemToAdjust.percent = categoryItemToAdjust.percent - leftover

-- Floppy disk app
newItem = {
    class = "SCAAMAppFloppyDisk",
    percent = 1,
}

categoryToAdjust = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomElectronicsContent")
itemtype = nil
itemcount = 0

if categoryToAdjust.group then
    itemtype = categoryToAdjust.group
elseif categoryToAdjust.classes then
    itemtype = categoryToAdjust.classes
end

itemnamestoadjust = {}
highpercentname = nil
highpercent = 0

for i,v in pairs(itemtype) do
    if v.category then
        table.insert(itemnamestoadjust, v.category)
    elseif v.class then
        table.insert(itemnamestoadjust, v.class)
	end

    if v.percent > highpercent then
        if v.category then 
            highpercentname = v.category
        elseif v.class then 
            highpercentname = v.class
		end

        highpercent = v.percent
    end
end

itemcount = tablelength(itemnamestoadjust)
table.insert(itemtype, newItem)
percentperitem = round(newItem.percent / itemcount, 2)
leftover = newItem.percent - percentperitem * itemcount
categoryItemToAdjust = nil

for i,v in pairs(itemnamestoadjust) do
    if FindInTable(itemtype, "category", v) then
        categoryItemToAdjust = FindInTable(itemtype, "category", v)
    elseif FindInTable(itemtype, "class", v) then
        categoryItemToAdjust = FindInTable(itemtype, "class", v)
    end
    if categoryItemToAdjust.percent > percentperitem then
        categoryItemToAdjust.percent = categoryItemToAdjust.percent - percentperitem
    else
        leftover = leftover + percentperitem
    end
end

if FindInTable(itemtype, "category", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "category", highpercentname)
elseif FindInTable(itemtype, "class", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "class", highpercentname)
end

categoryItemToAdjust.percent = categoryItemToAdjust.percent - leftover

newItem = {
    class = "SCAAMAppFloppyDisk",
    percent = 1,
}

categoryToAdjust = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomDeskContent")
itemtype = nil
itemcount = 0

if categoryToAdjust.group then
    itemtype = categoryToAdjust.group
elseif categoryToAdjust.classes then
    itemtype = categoryToAdjust.classes
end

itemnamestoadjust = {}
highpercentname = nil
highpercent = 0

for i,v in pairs(itemtype) do
    if v.category then
        table.insert(itemnamestoadjust, v.category)
    elseif v.class then
        table.insert(itemnamestoadjust, v.class)
	end

    if v.percent > highpercent then
        if v.category then 
            highpercentname = v.category
        elseif v.class then 
            highpercentname = v.class
		end

        highpercent = v.percent
    end
end

itemcount = tablelength(itemnamestoadjust)
table.insert(itemtype, newItem)
percentperitem = round(newItem.percent / itemcount, 2)
leftover = newItem.percent - percentperitem * itemcount
categoryItemToAdjust = nil

for i,v in pairs(itemnamestoadjust) do
    if FindInTable(itemtype, "category", v) then
        categoryItemToAdjust = FindInTable(itemtype, "category", v)
    elseif FindInTable(itemtype, "class", v) then
        categoryItemToAdjust = FindInTable(itemtype, "class", v)
    end
    if categoryItemToAdjust.percent > percentperitem then
        categoryItemToAdjust.percent = categoryItemToAdjust.percent - percentperitem
    else
        leftover = leftover + percentperitem
    end
end

if FindInTable(itemtype, "category", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "category", highpercentname)
elseif FindInTable(itemtype, "class", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "class", highpercentname)
end

categoryItemToAdjust.percent = categoryItemToAdjust.percent - leftover

-- Floppy disk encrypted
newItem = {
    class = "SCAAMEncryptedFloppyDisk",
    percent = 1,
}

categoryToAdjust = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomElectronicsContent")
itemtype = nil
itemcount = 0

if categoryToAdjust.group then
    itemtype = categoryToAdjust.group
elseif categoryToAdjust.classes then
    itemtype = categoryToAdjust.classes
end

itemnamestoadjust = {}
highpercentname = nil
highpercent = 0

for i,v in pairs(itemtype) do
    if v.category then
        table.insert(itemnamestoadjust, v.category)
    elseif v.class then
        table.insert(itemnamestoadjust, v.class)
	end

    if v.percent > highpercent then
        if v.category then 
            highpercentname = v.category
        elseif v.class then 
            highpercentname = v.class
		end

        highpercent = v.percent
    end
end

itemcount = tablelength(itemnamestoadjust)
table.insert(itemtype, newItem)
percentperitem = round(newItem.percent / itemcount, 2)
leftover = newItem.percent - percentperitem * itemcount
categoryItemToAdjust = nil

for i,v in pairs(itemnamestoadjust) do
    if FindInTable(itemtype, "category", v) then
        categoryItemToAdjust = FindInTable(itemtype, "category", v)
    elseif FindInTable(itemtype, "class", v) then
        categoryItemToAdjust = FindInTable(itemtype, "class", v)
    end
    if categoryItemToAdjust.percent > percentperitem then
        categoryItemToAdjust.percent = categoryItemToAdjust.percent - percentperitem
    else
        leftover = leftover + percentperitem
    end
end

if FindInTable(itemtype, "category", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "category", highpercentname)
elseif FindInTable(itemtype, "class", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "class", highpercentname)
end

categoryItemToAdjust.percent = categoryItemToAdjust.percent - leftover

newItem = {
    class = "SCAAMEncryptedFloppyDisk",
    percent = 1,
}

categoryToAdjust = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomDeskContent")
itemtype = nil
itemcount = 0

if categoryToAdjust.group then
    itemtype = categoryToAdjust.group
elseif categoryToAdjust.classes then
    itemtype = categoryToAdjust.classes
end

itemnamestoadjust = {}
highpercentname = nil
highpercent = 0

for i,v in pairs(itemtype) do
    if v.category then
        table.insert(itemnamestoadjust, v.category)
    elseif v.class then
        table.insert(itemnamestoadjust, v.class)
	end

    if v.percent > highpercent then
        if v.category then 
            highpercentname = v.category
        elseif v.class then 
            highpercentname = v.class
		end

        highpercent = v.percent
    end
end

itemcount = tablelength(itemnamestoadjust)
table.insert(itemtype, newItem)
percentperitem = round(newItem.percent / itemcount, 2)
leftover = newItem.percent - percentperitem * itemcount
categoryItemToAdjust = nil

for i,v in pairs(itemnamestoadjust) do
    if FindInTable(itemtype, "category", v) then
        categoryItemToAdjust = FindInTable(itemtype, "category", v)
    elseif FindInTable(itemtype, "class", v) then
        categoryItemToAdjust = FindInTable(itemtype, "class", v)
    end
    if categoryItemToAdjust.percent > percentperitem then
        categoryItemToAdjust.percent = categoryItemToAdjust.percent - percentperitem
    else
        leftover = leftover + percentperitem
    end
end

if FindInTable(itemtype, "category", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "category", highpercentname)
elseif FindInTable(itemtype, "class", highpercentname) then
    categoryItemToAdjust = FindInTable(itemtype, "class", highpercentname)
end

categoryItemToAdjust.percent = categoryItemToAdjust.percent - leftover