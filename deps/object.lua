-- The base object `Object`
local Object = {
  ClassName = "Object",
  IsA = function(self, ClassName)
    return self.ClassName == ClassName
  end
}
Object.meta = {__index = Object}

-- Create a new instance of this object  
function Object:create(ClassName)
  local meta = rawget(self, "meta")
  if not meta then error("Cannot inherit from instance object") end
  local obj = {}
  for i, v in next, self do
    obj[i] = v
  end
  obj.ClassName = ClassName or self.ClassName
  
  return setmetatable(obj, meta)
end

-- Create a new instance and call constructor if there is one
function Object:new(...)
  local obj = self:create(self.ClassName)
  if type(obj.initialize) == "function" then
    obj:initialize(...)
  end
  return obj
end

-- Extend this object into a new prototype object
function Object:extend(ClassName)
  local obj = self:create(ClassName)
  obj.meta = {__index = self}
  return obj
end

return Object