local http = require("socket.http")
local ltn12 = require("ltn12")

local concat = table.concat
local request = http.request
local API = {
    Url = "https://apis.roblox.com/universes/v1/{universeId}/places/{placeId}/versions"
}
function API:setKey(apikey)
    self.API_Key = apikey
end

local responses = {
    [200] = function(versionNum)
        return true, versionNum
    end,
    
    [400] = function()
        return false, "Invalid request / Invalid file content."
    end,
    
    [401] = function()
        return false, "API key not valid for operation, user does not have authorization."
    end,
    
    [403] = function()
        return false, "Publish not allowed on place."
    end,
    
    [404] = function()
        return false, "Place or universe does not exist."
    end,
    
    [409] = function()
        return false, "Place not part of the universe."
    end,
    
    [500] = function()
        return false, "Internal server error."
    end
}

function API:sendRequest(url, body)
    if not self.API_Key then
        error("No API key provided")
    end
    
    local responseBody = {}

local ok, status, headers, statusLine = request({
    url = url,
    method = "POST",
    source = ltn12.source.string(body),
    sink = ltn12.sink.table(responseBody),
    headers = {
        ["x-api-key"] = self.API_Key,
        ["content-length"] = tostring(#body),
        ["content-type"] = "application/xml"
    }
})
    
    if not ok then
        error("Fatal: "..status)
    end
    
    return status, concat(responseBody)
end

return API