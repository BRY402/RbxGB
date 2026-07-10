-- DefinitionElements classes, holds the logic for the xml headers
local xml = require("libs/XML")
local base64 = require("mime").b64

local roblox = xml:extend("roblox")
function roblox:initialize()
    xml.initialize(self)
    self:SetAttribute("version", 4)
end

local Meta = xml:extend("Meta")
function Meta:initialize(Name, Value)
    assert(type(Name) == "string", "Invalid value for Name, string expected")
    
    xml.initialize(self)
    self:SetAttribute("name", Name)
    self:SetContent(Value)
end


local External = xml:extend("External")
function External:initialize(Content)
    xml.initialize(self)
    self:SetContent(Content)
end



local Properties = xml:extend("Properties")
function Properties:initialize()
    xml.initialize(self)
end


local Item = xml:extend("Item")
function Item:initialize(ClassName, Referent)
    assert(type(ClassName) == "string", "Invalid ClassName, string expected")
    assert(type(Referent) == "string", "Invalid Referent, Referent expected (string)")
    
    xml.initialize(self)
    
    self:SetAttribute("class", ClassName)
    self:SetAttribute("referent", Referent)
    
    self.Properties = Properties:new()
    self:AddChild(self.Properties)
end


local SharedStrings = xml:extend("SharedStrings")
function SharedStrings:initialize()
    xml.initialize(self)
end

local SharedString = xml:extend("SharedString")
function SharedString:initialize(Content, md5)
    assert(type(Content) == "string", "Invalid value for Content, string expected")
    assert(type(md5) == "string", "Invalid value for md5, string or hash expected")
    
    xml.initialize(self)
    
    self:SetAttribute("md5", md5)
    self:SetContent(base64(Content))
end


return {
    roblox = roblox,
    Meta = Meta,
    External = External,
    Item = Item,
    Properties = Properties,
    SharedStrings = SharedStrings,
    SharedString = SharedString
}