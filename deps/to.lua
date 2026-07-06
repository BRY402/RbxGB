local function Int(bits, n)
    local min = 2^(bits - 1)
    local max = min - 1
    
    if n < -min then
        local diff = -min - n
        n = max - (diff - 1)
    end
    
    if n > max then
        local diff = n - max
        n = -min + (diff - 1)
    end
    
    return math.floor(n)
end

local function UInt(bits, n)
    local max = 2^bits - 1
    
    if n < 0 then
        local diff = 0 - n
        n = max - (diff - 1)
    end
    
    return math.floor(n)
end

local function float32(n)
    return math.min(tonumber(Content) or 0, 1.8 * 10^38)
end

return {
    Int = Int,
    UInt = UInt,
    float32 = float32
}