-- ---------------------------------------------------------------------------------------------- --
--                                            ~ MisDB ~                                           --
-- ---------------------------------------------------------------------------------------------- --

--[[
MisDB Provides Mods With a Method for "Data Persistance"
Via JSON File Backed "Pages" and "Collections".
Based on a Module to Providing a "Pure Lua" implementation
'Similar' to flatDB/NoDB

MisDB Takes a Lua Table Converts it to JSON, and we call that a "Page"
These "Pages" are Grouped into Named "Collections" and Stored as Seperate Files,
One for Each Different Collection in a Folder with this "MisDB Objects" Name
And Placed in the Specified Base Directory (Relative to Your Server Root)
eg:

For a MisDB Called "MyModsData" with a Collection Named "Settings"
and Stored in the BaseDir "MisDBdata" :
    [ServerRoot]>{BaseDir}/{MisDB Name}/{Collection Name}
        ServerRoot>/MisDBdata/MyModsData/Settings


Methods:

*    MisDB:Create(BaseDir, Name) ~> TableObject(Your Main MisDB Object)
        Creates a New MisDB Object to Store Collections Backed by files in
        [ServerRoot]>{BaseDir}/{Name}

With the Returned {Object} then:
*    {Object}:Collection(Name) ~> CollectionObject(Table/Object defining this Collection)
        Create/Fetch a New Collection in this MisDB (Non Existant Collections Are autoCreated)

the Returned {Collection} then provides the following Methods:
*    {Collection}:GetPage(pageId)
        Fetch The Contents of a "Page" from this "Collection" By Specified PageID
        ! This Will return nil, with a message as the Second return var if the Page Does Not Exist
*    {Collection}:SetPage(pageId,data)
        Set The Contents of a "Page" from this "Collection" By Specified PageID
        ? Returns the "written to disk" Copy of the Page Content you Set
        ? Use this to save your page data and use the return to verify against your data
*    {Collection}:PurgePage(pageId)
        Remove a "Page" from this "Collection" By Specified PageID
        ? returns true/nil and a message with the result

]]
--! You "Should" be Using the GetPage/SetPage functions and Editing your
--! Collection a Page at a Time  using Local Copies, helps Performance(less I/O Calls)
--! Provides some Protection from any invalid Writes if you allways check the pagedata

MisDB = {Utils = {}}
Script.ReloadScript("scripts/MisDB/utils.lua")
Script.LoadScriptFolder("scripts/MisDB/Modules")
Script.ReloadScript("scripts/MisDB/dbcontroller.lua")

--* Creates a New MisDB Object
--? MisDB Object data Stored in ServerRoot>/{BaseDir}/{Name}
--@Name     string  Name for this MisDB Object
--@BaseDir  string  Base Directory for MisDB Data
--! Allways include the final "/" in your Path
function MisDB:Create(BaseDir, Name)
    local this = {
        Log = function(self, Message)
            local Log = (Log or print)
            Log("--->[" .. self.__NAME__ .. "]-> " .. Message)
        end
    }
    if (type(Name) == "string") and (Name ~= "") then
        this.__NAME__ = Name
    else
        return nil, "You Must give the MisDB a Name"
    end
    if (type(BaseDir) ~= "string") or (BaseDir == "") then
        return nil, "You Must provide the Base Directory to store your MisDB data"
    end
    if not MisDB.Utils.isDir(BaseDir) then
        MisDB.Utils.mkDir(BaseDir)
    end
    if not MisDB.Utils.isDir(BaseDir .. this.__NAME__) then
        MisDB.Utils.mkDir(BaseDir .. this.__NAME__)
    end
    for k, v in pairs(MisDB) do
        this[k] = v
    end
    this.db = MisDB.dbcontroller(BaseDir .. this.__NAME__)
    return this
end

--* Saves The data Linked to this MisDB Object
function MisDB:Save()
    self.db:save()
end

--* Returns a MisDB Collection Object With Get/Set methods for accessing it
--? MisDB Collection are Stored @ ServerRoot/{BaseDir}/{MisDB Name}/{TableName}
--? As a JSON file with no file ext
--! if a table does not exist its automaticaly created along with its table file
--@ table   string  Name of table to Fetch

function MisDB:Collection(table)
    -- If This Collection Doesn't Exist Create it
    if not self.db[table] then
        self.db[table] = {}
    end

    -- Local "Object" to Hold this Collection
    local Collection = {}
    -- Set the Name
    Collection.Name = table
    -- Assign Ourselves as the objects "Parent" for access to our Methods
    Collection.parent = self

    --* Fetch a Page From Collection using its PageID
    --? If the Page Exists then this Returns a Table Containing the Contant
    --? Stored in JSONfile  for the Specified Page.
    --! Theres no Specific Method for Checking the Existance of a Page
    --! if this Function returns no Data then that Page is Empty or Missing
    Collection.GetPage = function(self, pageId)
        local PageData = self.parent.db[self.Name]
        if PageData ~= nil or {} then
            if PageData[tostring(pageId)] ~= nil then
                return PageData[tostring(pageId)]
            end
        end
        -- Something Went Wrong
        --? Invalid Page was Probably Requested
        --? Its also possible we Recieved Malformed Data the JSON Module was unable to decode
        return nil, "Failed to fetch Page: " .. tostring(pageId)
    end

    --* Set a Pages Contents By PageID in this Collection
    --? Returns a Collection Containing the Contant of the Specified Page
    Collection.SetPage = function(self, pageId, data)
        local PageData = self.parent.db[self.Name]
        if PageData ~= nil then
            PageData[tostring(pageId)] = data
            self.parent.db:save()
            return PageData[tostring(pageId)]
        end
        -- Something Went Wrong
        --! This Should't Happen unless Theres File acces Problems
        --? MisDB Automaticly Creates Collection/Pages and the files that Back them
        --? Whenever You Attempt to "Set" their Data so this Shouldn't Occur
        return nil, "Failed to Update Page: " .. tostring(pageId)
    end

    --* Remove a Page By PageID from this Collection
    --? Returns a Collection Containing the Contant of the Specified Page
    Collection.PurgePage = function(self, pageId)
        local PageData = self.parent.db[self.Name]
        if PageData then
            self.parent.db[self.Name][tostring(pageId)] = nil
            if not self.parent.db[self.Name][tostring(pageId)] then
                return true, "Success Purging Page: " .. tostring(pageId)
            else
                return nil, "Failed Purging Page: " .. tostring(pageId)
            end
        end
        -- Something Went Wrong
        --! This Should't Happen unless Theres File acces Problems
        return nil, "Couldn't Purge that Page"
    end
    -- Return Our Collection
    return Collection
end
