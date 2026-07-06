local API = require("libs/API")

local place = {
    API_Url = "",
    API_Key = "",
    Body = ""
}

function place:setPlace(UniverseId, PlaceId)
    self.API_Url = API.Url:gsub("{universeId}", tostring(UniverseId)):gsub("{placeId}", tostring(PlaceId))
    
    return self
end
function place:setKey(API_Key)
    API:setKey(API_Key)
    
    return self
end
function place:setBody(str)
    self.Body = tostring(str)
    
    return self
end

function place:Save()
    return API:sendRequest(self.API_Url.."?versionType=Saved", tostring(self.Body))
end

function place:Publish()
    return API:sendRequest(self.API_Url.."?versionType=Published", tostring(self.Body))
end

return place