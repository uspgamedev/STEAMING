local Class = require "extra_libs.hump.class"
local Color = require "classes.color.color"
local Drawable = require "classes.primitives.drawable"

--Rectangle: is a positionable and colorful object with width and height
local Rect = Class{
    __includes = {Drawable},
    init = function(self, _x, _y, _w, _h, _c, _mode, _line_width) --Set rectangle's atributes
        Drawable.init(self, _x, _y, _c, 0, 1, 1)

        self.w = _w or 10 --Width
        self.h = _h or 10 --Height

        self.mode = self.mode or _mode or "fill" --Mode to draw the triangle
        self.line_width = _line_width or 3 --Line thickness if mode is line

        self.tp = "rectangle"
    end,

    resize = function(self, _w, _h) --Change width/height
        self.w = _w
        self.h = _h
    end
}

--Draws the rectangle
function Rect:draw()
    local r = self

    Color.set(r.color)
    if r.mode == "line" then
        love.graphics.setLineWidth(r.line_width)
    end

    love.graphics.rectangle(r.mode, r.pos.x, r.pos.y, r.w, r.h)

end

return Rect
