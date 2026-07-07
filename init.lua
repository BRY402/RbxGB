local _, path_to_module = ...
local module_dir = path_to_module:match(".*/")
package.path = package.path..";"..module_dir.."?.lua;"..module_dir.."?/init.lua"
-- voodoo magic type shit

local place = require("libs/place")
local Classes = require("Classes")
local Enum = require("libs/Enum")

return {
    place = place,
    Classes = Classes,
    Enum = Enum
}