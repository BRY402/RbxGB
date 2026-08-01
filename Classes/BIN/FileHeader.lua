local bin = require("libs/BIN")
local to = require("deps/to")

local header = bin:extend("BINFileHeader")

function header:initialize(ClassCount, InstCount)
    bin.initialize(self)
    self:Push("<roblox!") -- magic num
    self:Push({0x89, 0xff, 0x0d, 0x0a, 0x1a, 0x0a}) -- signature
    self:Push({0, 0, 0, 0}) -- version
    self:Push(to.Int(32, ClassCount))
    self:Push(to.Int(32, InstCount))
    self:Push({0, 0, 0, 0, 0, 0, 0, 0}) -- reserved
end

return header