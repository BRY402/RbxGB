local bin = require("libs/BIN")
local to = require("deps/to")


local chunkheader = bin:extend("BINChunkHeader")

function chunkheader:initialize(Name, CompressedLength, UncompressedLength)
    bin.initialize(self)
    self:Push(Name, 4)
    self:Push(to.UInt(32, CompressedLength))
    self:Push(to.UInt(32, UncompressedLength))
    self:Push({0, 0, 0, 0})
end

return chunkheader