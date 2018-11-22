local Class = require "extra_libs.hump.class"
local Color = require "classes.color.color"

--Colorful: the object has a color, and a color table for  transistions
local Clr = Class{
    init = function(self, _c)
        if _c then
            self.color = Color.getCopy(_c) --This object main color
        else
            self.color = Color.white()
        end
    end,

    setColor = function(self, _c) --Set object's color
        Color.copy(self.color, _c)
    end,

}

return Clr
