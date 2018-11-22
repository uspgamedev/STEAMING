local Class = require "extra_libs.hump.class"
local Color = require "classes.color.color"
local Drawable = require "classes.primitives.drawable"

--Circle: is a positionable and colorful object with radius
local Circ = Class{
    __includes = {Drawable},
    init = function(self, _x, _y, _r, _c, _mode, _line_width) --Set circle's atributes
        Drawable.init(self, _x, _y, _c)
        self.r = _r --Radius
        self.mode = _mode or "fill" --Circle draw mode
        self.line_width = _line_width --For "line" draw mode

        self.tp = "circle"
    end,

    resize = function(self, _r) --Change radius
        self.r = _r
    end
}

--Draws the circle
function Circ:draw()
    local circ = self

    Color.set(circ.color)
    if circ.mode == "line" then
        love.graphics.setLineWidth(circ.line_width)
    end

    love.graphics.circle(circ.mode, circ.pos.x, circ.pos.y, circ.r)
end

return Circ
