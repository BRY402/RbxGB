local object = require("deps/object")

local tochar = string.char
local rep = string.rep
local concat = table.concat
local pop = table.remove

local convert = {
    string = tostring,
    number = function(n)
        return math.min(math.abs(n), 255)
    end,
    table = function(data)
        for i, v in ipairs(data) do
            data[i] = tochar(v)
        end
        
        return concat(data)
    end
}

local function pad(Value, Len, MSB)
    local vLen = #Value
    if vLen > Len then
        return false
    end
    
    local padding = rep("\0", Len - vLen)
    
    return not MSB and (padding..Value) or (Value..padding)
end

local function strip(Value, Len, MSB)
    local vLen = #Value
    if vLen < Len then
        return false
    end
    
    return not MSB and Value:sub((#Value - Len) + 1, -1) or Value:sub(1, Len)
end

local bin = object:extend("BINData")

function bin:tostring() -- dont compress for now. compression
                        -- should be handled somewhere better
    return concat(self.Content)
end

function bin:SetContent(Content)
    self.Content = Content or {}
end

function bin:Push(Value, Len, MSB)
    local func = convert[type(Value)]
    Value = func and tostring(func(Value) or Value)
    local vLen = #Value
    Len = tonumber(Len) or vLen
    if vLen == Len then
        self.Content[#self.Content + 1] = Value
        return
    end
    
    self.Content[#self.Content + 1] = pad(Value, Len, MSB) or strip(Value, Len, MSB) or Value
end

function bin:Pop(Index)
    return pop(self.Content, tonumber(Index))
end

function bin:initialize(Content)
    self.Content = Content or {}
end

return bin