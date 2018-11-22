local Class = require "extra_libs.hump.class"
local Color = require "classes.color.color"
local Drawable = require "classes.primitives.drawable"

--Image: is a drawable object with an image
local Image = Class{
    __includes = {Drawable},
    init = function(self, _image, _x, _y, _c, _sx, _sy, _rotation) --Set circle's atributes
        DRAWABLE.init(self, _x, _y, _c, _rotation, _sx, _sy)

        self.image = _image

        self.tp = "image"
    end,
}

--Draws the image
function Image:draw()
    local img = self

    Color.set(img.color)
    love.graphics.draw(img.image, img.pos.x, img.pos.y, img.rotation, img.sx, img.sy)
end

return Image
