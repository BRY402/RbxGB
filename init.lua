local _, path_to_module = ...
if not path_to_module then
    path_to_module = os.getenv("PWD") or os.getenv("cd")
end
if not path_to_module then
    error("Fatal: no working directory found")
end
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