
-- clear recipes after Easter Event

local EasterFile = io.open('GameSDK/Scripts/Recipes/mods/AutoEasterEvent.xml', 'w')

local EmptyRecipeFile = [[<recipes></recipes>]]

if EasterFile then
	EasterFile:write(EmptyRecipeFile)
	EasterFile:close();
end