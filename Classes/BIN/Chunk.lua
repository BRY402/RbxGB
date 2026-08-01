package.path = package.path..";../../?.lua"
local chunkheader = require("Classes/BIN/ChunkHeader")
local llz4 = require("deps/BIN/llz4")

local chunk = chunkheader:extend("BINChunk")

function chunk:initialize(Name, IsCompressed, Data)
    local CompressedData = IsCompressed and llz4.compress(Data) or ""
    chunkheader.initialize(self, Name, #CompressedData, #Data)
    
    self:Push(IsCompressed and CompressedData or Data)
end

print(chunk:new("INST", true, "hihi hihi hihi hihi hihi hihi hihi hihi"):tostring())

return chunk