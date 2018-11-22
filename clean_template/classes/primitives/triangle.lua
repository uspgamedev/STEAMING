local Class = require "extra_libs.hump.class"
local Vector = require "extra_libs.hump.vector"
local Element = require "classes.primitives.element"
local Clr = require "classes.primitives.clr"
local Color = require "classes.color.color"

--Triangle: is a positionable and colorful object with three points
local Triangle = Class{
    __includes = {Element, Clr},
    init = function(self, _pos1, _pos2, _pos3, _c, _mode, _line_width) --Set rectangle's atributes
        Element.init(self)
        Clr.init(self, _c)

        --Triangle positions
        self.p1 = Vector(_pos1.x, _pos1.y)
        self.p2 = Vector(_pos2.x, _pos2.y)
        self.p3 = Vector(_pos3.x, _pos3.y)

        self.mode = self.mode or _mode or "line" --Mode to draw the triangle
        self.line_width = _line_width or 3 --Line thickness if mode is line

        self.tp = "triangle"
    end
}

--Draws the triangle
function Triangle:draw()
    local t

    t = self

    --Draws the triangle
    Color.set(t.color)
    if t.mode == "line" then
        love.graphics.setLineWidth(t.line_width)
    end
    love.graphics.polygon(t.mode, t.p1.x, t.p1.y, t.p2.x, t.p2.y, t.p3.x, t.p3.y)
end

return Triangle
