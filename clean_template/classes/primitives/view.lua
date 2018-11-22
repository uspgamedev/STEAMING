local Class = require "extra_libs.hump.class"
local Element = require "classes.primitives.element"

local View = Class {
    __includes = {Element}
}

function View:init(obj)
    self:setObj(obj)
end

-- For now, each obj can only have one view
function View:setObj(obj)
    if self.obj ~= nil then
        self.obj.view = nil
    end
    self.obj = obj
    if obj ~= nil then
        assert(obj.view == nil)
        obj.view = self
    end
end

function View:getObj()
    return self.obj
end

return View
