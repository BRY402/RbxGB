-- handles all class to xml logic
-- base for all classes
local object = require("deps/object")

local concat = table.concat
local remove = table.remove
local f = string.format
local find = table.find or function(tbl, value)
    for i, v in ipairs(tbl) do
        if v == value then
            return i
        end
    end
end
local tostring = tostring

local xml = object:extend("BaseXML")

function xml:tostring()
    local Name = self.Name or self.ClassName
    local str = {"<", Name}
    
    for k, v in next, self.Attributes do
        str[#str + 1] = " "..k..f("=%q", tostring(v))
    end
        
    str[#str + 1] = ">"
    str[#str + 1] = tostring(self.Content == nil and "" or self.Content)
        
    for i, child in ipairs(self.Children) do
        str[#str + 1] = child:tostring()
    end
        
    str[#str + 1] = f("</%s>", Name)
    
    return concat(str)
end

function xml:AddChild(Child)
    local Children = self.Children
    if find(Children, Child) then
        return
    end
    
    Children[#Children + 1] = Child
end

function xml:RemoveChild(Child)
    local Children = self.Children
    local ChildIndex = find(Children, Child)
    if not ChildIndex then
        return
    end
    
    remove(Children, ChildIndex)
end

function xml:AddChildren(...)
    local Children = self.Children
    local n = #Children
    for _, i in select("#", ...) do
        local Child = select(i, ...)
        if not find(Children, Child) then
            Children[n + i] = Child
        end
    end
end

function xml:RemoveChildren(...)
    local Children = self.Children
    local n = #Children
    for _, i in select("#", ...) do
        local Child = select(i, ...)
        local ChildIndex = find(Children, Child)
        if ChildIndex then
            remove(Children, ChildIndex)
        end
    end
end

function xml:SetAttribute(Name, Attribute)
    self.Attributes[Name] = tostring(Attribute)
end

function xml:RemoveAttribute(Name)
    self.Attributes[Name] = nil
end

function xml:ClearAllChildren()
    self.Children = {}
end

function xml:ClearAllAttributes()
    self.Attributes = {}
end

function xml:SetContent(Content)
    self.Content = Content
end

function xml:initialize(Name, Content, Attributes)
    self.Content = Content
    self.Attributes = {}
    self.Children = {}
    self.Name = Name or self.ClassName
end

return xml