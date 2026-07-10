-- TypeElements classes, holds all logic for roblox items
-- i couldve done everything here the same by just using a Script and ProtectedString but I hate myself
local f = string.format

local base64 = require("mime").b64
local generateUIDS = require("deps/generateUIDS")
local to = require("deps/to")
local xml = require("libs/XML")
local xml_escape = require("deps/xml_escape")

local TypeElements = {}
local function newTypeElement(ClassName, func)
    local ClassName = tostring(ClassName)
    
    local Property = xml:extend(ClassName)
    function Property:initialize(...)
        xml.initialize(self)
        func(self, ...)
    end
    
    TypeElements[ClassName] = Property
    
    return Property
end

newTypeElement("null", function() end)
newTypeElement("url", function(self, Content) self:SetContent(Content) end)

local function addChildElements(Parent, Names, Values)
    for i, Name in ipairs(Names) do
        local Value = Values[i]
        
        local child = TypeElements.float:new(tostring(tonumber(Value) or 0):upper())
        child.Name = Name
        Parent:AddChild(child)
    end
end

-- ColorSequenceKeypoint: Time(0, 1), R, G, B, Envelope = 0

-- ZYX
newTypeElement("Axes", function(self, Axes3Bits)
    addChildElements(self, {"axes"}, {to.UInt(3, Axes3Bits)})
end)

newTypeElement("BinaryString", function(self, Content)
    local Content = tostring(Content)
    
    self:SetContent(base64(Content))
end)

newTypeElement("bool", function(self, Content)
    self:SetContent(not not Content)
end)

newTypeElement("BrickColor", function(self, Content)
    self:SetContent(to.Int(32, tonumber(Content) or 0))
end)

newTypeElement("CFrame", function(self, ...)
    addChildElements(self, {"X", "Y", "Z", "R00", "R01", "R02", "R10", "R11", "R12", "R20", "R21", "R22"}, {...})
end)

newTypeElement("Color3", function(self, ...)
    addChildElements(self, {"R", "G", "B"}, {...})
end)

newTypeElement("Color3uint8", function(self, HexValue)
    self:SetContent(0xFF000000 + to.UInt(8, tonumber(HexValue) or 0))
end)

-- no plans on adding this soon cuz it sucks ass to add this but it will be here
newTypeElement("ColorSequence", function(self)
    
end)

-- unused but will keep it just in case
local ContentChildNames = {
    uri = "url",
    Ref = "Ref",
    null = "null"
}

newTypeElement("Content", function(self, Type, Content)
    local childName = ContentChildNames[Type]
    assert(childName, "unsupported Content type: "..tostring(Type))
    self:AddChild(TypeElements[childName]:new(Content))
end)

newTypeElement("ContentId", function(self, urlValue)
    if not urlValue then
        self:AddChild(TypeElements.null:new())
        return
    end
    
    local urlComp = TypeElements.url:new(urlValue)
    self:AddChild(urlComp)
end)

newTypeElement("double", function(self, Content)
    local Content = tonumber(Content or 0)
    self:SetContent(tostring(Content):upper())
end)

newTypeElement("Faces", function(self, Faces6Bits)
    addChildElements(self, {"faces"}, {to.UInt(6, Faces6Bits)})
end)

newTypeElement("float", function(self, Content)
    local n = to.float32(Content)
    self:SetContent(tostring(n):upper())
end)

newTypeElement("Font", function(self, Family, Weight, Style, CachedFaceId)
    local FamilyComp = TypeElements.null:new()
    FamilyComp.Name = "Family"
    local WeightComp = TypeElements.token:new(Weight)
    WeightComp.Name = "Weight"
    local StyleComp = TypeElements.string:new(Style)
    StyleComp.Name = "Style"
    if CachedFaceId then
        local CachedFaceIdComp = TypeElements.null:new()
        CachedFaceIdComp.Name = "CachedFaceId"
        local cachedfaceidContent = TypeElements.url:new(CachedFaceId)
        CachedFaceIdComp:AddChild(cachedfaceidContent)
        self:AddChild(CachedFaceIdComp)
    end
    
    local familyContent = TypeElements.url:new(Family)
    FamilyComp:AddChild(familyContent)
    self:AddChild(FamilyComp)
    self:AddChild(WeightComp)
    self:AddChild(StyleComp)
end)

newTypeElement("int64", function(self, Content)
    self:SetContent(to.Int(64, tonumber(Content) or 0))
end)

newTypeElement("NetAssetRef", function(self, md5)
    self:SetContent(tostring(md5))
end)

newTypeElement("NumberRange", function(self, n1, n2)
    local min = math.min(n1, n2)
    local max = math.max(n1, n2)
    
    self:SetContent(tostring(min).." "..tostring(max))
end)

-- same shit as colorsequence hell no
newTypeElement("NumberSequence", function(self, Content)
    
end)

-- this is probably useless but im adding it anyway
local OptionalChildNames = {
    CoordinateFrame = "CFrame",
}

newTypeElement("Optional", function(self, Type)
    local childName = OptionalChildNames[Type]
    assert(childName, "unsupported Optional<T> type: "..tostring(Type))
    self.Name = "Optional"..Type
end)

newTypeElement("PhysicalProperties", function(self, CustomPhysicalProperties, ...)
    local Custom = TypeElements.bool:new(CustomPhysicalProperties)
    Custom.Name = "CustomPhysicalProperties"
    
    addChildElements(self, {"Density", "Friction", "Elasticity", "FrictionWeight", "ElasticityWeight", "AcousticAbsorption"}, {...})
end)

newTypeElement("ProtectedString", function(self, Content)
    self:SetContent(f("<![CDATA[%s]]>", tostring(Content):gsub("]", "\\]"):gsub("[", "\\[")))
end)

newTypeElement("Ray", function(self, origin, direction)
    assert(min.ClassName == "Vector3", "Invalid value for origin, expected Vector3 class")
    assert(max.ClassName == "Vector3", "Invalid value for direction, expected Vector3 class")
    
    origin.Name = "origin"
    direction.Name = "direction"
    self:AddChildren(direction, origin)
end)

newTypeElement("Rect2D", function(self, min, max)
    assert(min.ClassName == "Vector2", "Invalid value for min, expected Vector2 class")
    assert(max.ClassName == "Vector2", "Invalid value for max, expected Vector2 class")
    
    min.Name = "min"
    max.Name = "max"
    self:AddChildren(min, max)
end)

newTypeElement("Ref", function(self, referent)
    if not referent then
        self.Name = "null"
        return
    end
    
    self:SetContent(tostring(referent))
end)

newTypeElement("string", function(self, Content)
    self:SetContent(xml_escape(tostring(Content)))
end)

newTypeElement("token", function(self, Id)
    self:SetContent(math.floor(tonumber(Id) or 0))
end)

newTypeElement("UDim", function(self, ...)
    addChildElements(self, {"S", "O"}, {...})
end)

newTypeElement("UDim2", function(self, ...)
    addChildElements(self, {"XS", "XO", "YS", "YO"}, {...})
end)

newTypeElement("UniqueId", function(self)
    self:SetContent(generateUIDS(1)[1])
end)

newTypeElement("Vector2", function(self, ...)
    addChildElements(self, {"X", "Y"}, {...})
end)

newTypeElement("Vector3", function(self, ...)
    addChildElements(self, {"X", "Y", "Z"}, {...})
end)

newTypeElement("Vector3int16", function(self, X, Y, Z)
    local XComp, YComp, ZComp = TypeElements.int(to.Int(16, X)), TypeElements.int(to.Int(16, Y)), TypeElements.int(to.Int(16, Z))
    self:AddChildren(XComp, YComp, ZComp)
end)


TypeElements.CoordinateFrame = TypeElements.CFrame:extend("CoordinateFrame")
TypeElements.int = TypeElements.BrickColor:extend("int")
TypeElements.SharedString = TypeElements.NetAssetRef:extend("SharedString")

return TypeElements