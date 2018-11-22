local Class = require "extra_libs.hump.class"
local Vector = require "extra_libs.hump.vector"

--Positionable: has a x and y position
local Pos = Class{
    init = function(self, _x, _y) --Set position for object
        self.pos = Vector(_x or 0, _y or 0) --Position vector
    end,

    setPos = function(self, _x, _y) --Set position for object
        self.pos.x, self.pos.y = _x, _y
    end
}

return Pos
