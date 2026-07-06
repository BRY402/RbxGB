return function(n)
    local gens = {}
    for i = 0, n - 1 do
        -- split in two cuz lua turns 64 bit hex into -1 for some reason
        local tophalf = math.random(0, 0xFFFFFFFF)
        local bottomhalf = math.random(0, 0xFFFFFFFF)
        if tophalf >= 0xFFFFFFF then
            tophalf = tophalf - 0xFFFFFFF
            bottomhalf = bottomhalf + 1
        end
        local PRH = string.format("%08x", tophalf)..string.format("%08x", bottomhalf)
        local time = string.format("%08x", to.UInt(os.time(), 32))
        local index = string.format("%08x", i)
        
        gens[i + 1] = PRH..time..index
    end
    
    return gens
end