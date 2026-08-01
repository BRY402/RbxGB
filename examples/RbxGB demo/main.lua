local RbxGB = require("RbxGB")

local place = RbxGB.place

local UniverseId = 10284203367 -- (OPTIONAL) replace 0 with the universe id of the experience
local PlaceId = 127730636989537 -- replace 0 with the place id of the universe you wanna update
place:setPlace(PlaceId, UniverseId)
place:setKey("jOI2Zx+h8UO85qQlkewFtBGpaRAOc1bdGRUiBLiJ5VydqsU/ZXlKaGJHY2lPaUpTVXpJMU5pSXNJbXRwWkNJNkluTnBaeTB5TURJeExUQTNMVEV6VkRFNE9qVXhPalE1V2lJc0luUjVjQ0k2SWtwWFZDSjkuZXlKaGRXUWlPaUpTYjJKc2IzaEpiblJsY201aGJDSXNJbWx6Y3lJNklrTnNiM1ZrUVhWMGFHVnVkR2xqWVhScGIyNVRaWEoyYVdObElpd2lZbUZ6WlVGd2FVdGxlU0k2SW1wUFNUSmFlQ3RvT0ZWUE9EVnhVV3hyWlhkR2RFSkhjR0ZTUVU5ak1XSmtSMUpWYVVKTWFVbzFWbmxrY1hOVkx5SXNJbTkzYm1WeVNXUWlPaUl4TVRBMk9EQXdOelEwTVNJc0ltVjRjQ0k2TVRjNE1EZ3dNRGM1TXl3aWFXRjBJam94Tnpnd056azNNVGt6TENKdVltWWlPakUzT0RBM09UY3hPVE45LktSZHdvWTNsM1ExRE5ZeHNvWjJDSTNKRGFaTTJxZVhFX2I4QkdFM2dJTEliUFdJd0VOUTJ5ZFFQNm54U3NicW5HYWRGQzdoWjRSYWlDNnhWaVJGNjB5NXE0WVR4UTN2ZmF3LVQ5bWd0R0ZNUjJNeUxFSFJYa1hQcGcxWTNHZ09WTzZSVDA5bnRJMXZTdllLY1F3TjBBckU0MERudVNFa25hUW5GT1M5SmY0TWVLbXhMTU40a3NJTlZMQ3ROaG92QmhGRjVIcnpXRkprZFFVQVNlcThfN05WVE1UamdkZXBlMjhMUFRFZ0UzazhEa1JkSlNrOVl5d1pCYmduYWx6Mm9QQXFLTFY5ZFV0cVVtRnRvd0NHMTlkUFRLdDlsdzlKY0VSUFN2ZkFWUFBPb2hWUTZ0aERyamlnZ2VnN211OTRvOGxjZjQ5U1hGZmZubFFJNWhyX041Zw==") -- replace your_api_key with your api key

local Classes = RbxGB.Classes.XML -- DONT TOUCH BINARY FOR NOW im not even 1% done with the code
local Enum = RbxGB.Enum

local function newProperty(Parent, Type, Name, ...)
    local Property = Classes.TypeElements[Type]:new(...)
    Property:SetAttribute("name", Name)
    Parent:AddChild(Property)
    
    return Property
end
local Roblox = Classes.DefinitionElements.roblox:new() -- needed for all rbx xml files
local workspace = Classes.DefinitionElements.Item:new("Workspace", "RBX0") -- ClassName, Referent (referent must be unique and does not need a specific format)
--[[local Baseplate = Classes.DefinitionElements.Item:new("Part", "RBX1")
local Properties = Baseplate.Properties
newProperty(Properties, "Color3", "Color", 0, .7, 0)
newProperty(Properties, "Vector3", "Size", 2048, 10, 2048)
newProperty(Properties, "bool", "Anchored", true)
newProperty(Properties, "bool", "CanCollide", true)
newProperty(Properties, "token", "Material", Enum.Material.Grass)]]

Roblox:AddChild(workspace)
--workspace:AddChild(Baseplate)

local maincodef = io.open("./game/maincode.lua")
local maincode = maincodef:read("*a")
maincodef:close()

local Script = Classes.DefinitionElements.Item:new("Script", "asd")
local Properties = Script.Properties
newProperty(Properties, "ProtectedString", "Source", maincode)

local localplayerf = io.open("./game/localplayer.lua")
local localplayer = localplayerf:read("*a")
localplayerf:close()

local LocalScript = Classes.DefinitionElements.Item:new("LocalScript", "qwerty")
local Properties = LocalScript.Properties
newProperty(Properties, "ProtectedString", "Source", localplayer)

workspace:AddChild(Script)
workspace:AddChild(LocalScript)

place:setBody(Roblox:tostring())
--print(place.Body)

print(place:Publish())
-- ^ output should be: 200   {"versionNumber":x} (x being the version mumber)