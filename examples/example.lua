local RbxGB = require("RbxGB")

local place = RbxGB.place

local UniverseId = 0 -- replace 0 with the universe id of the experience
local PlaceId = 0 -- replace 0 with the place id of the universe you wanna update
place:setPlace(UniverseId, PlaceId)
place:setKey("your_api_key") -- replace your_api_key with your api key

local Classes = RbxGB.Classes
local Enum = RbxGB.Enum

local function newProperty(Parent, Type, Name, ...)
    local Property = Classes.TypeElements[Type]:new(...)
    Property:SetAttribute("name", Name)
    Parent:AddChild(Property)
    
    return Property
end
local Roblox = Classes.DefinitionElements.roblox:new() -- needed for all rbx xml files
local workspace = Classes.DefinitionElements.Item:new("Workspace", "RBX0") -- ClassName, Referent (referent must be unique and does not need a specific format)
local Baseplate = Classes.DefinitionElements.Item:new("Part", "RBX1")
local Properties = Baseplate.Properties
newProperty(Properties, "Color3", "Color", 0, .7, 0)
newProperty(Properties, "Vector3", "Size", 2048, 10, 2048)
newProperty(Properties, "bool", "Anchored", true)
newProperty(Properties, "bool", "CanCollide", true)
newProperty(Properties, "token", "Material", Enum.Material.Grass)

Roblox:AddChild(workspace)
workspace:AddChild(Baseplate)

place:setBody(Roblox:tostring())

print(place:Publish())
-- ^ output should be: 200   {"versionNumber":x} (x being the version mumber)