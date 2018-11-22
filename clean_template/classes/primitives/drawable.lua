local Class = require "extra_libs.hump.class"
local Element = require "classes.primitives.element"
local Pos = require "classes.primitives.pos"
local Clr = require "classes.primitives.clr"

--Drawable object with a 2-dimension position, color, rotation and scale(x,y)
local Drawable = Class{
    __includes = {Element, Pos, Clr},
    init = function(self, _x, _y, _c, _rotation, _sx, _sy)
        Element.init(self)
        Pos.init(self, _x, _y)
        Clr.init(self, _c)

        self.rotation = _rotation
        self.sx = _sx
        self.sy = _sy

        self.tp = "drawable"
    end
}

return Drawable
