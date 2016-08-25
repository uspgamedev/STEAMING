require "classes.primitive"
local Rgb = require "classes.rgb"
--BUTTON CLASS --

local button = {}

--[[Square button with centralized text]]

But = Class{
    __includes = {RECT, WTXT},
    init = function(self, _x, _y, _w, _h, _b_color, _func, _text, _font, _t_color)
        self.tp = "button" --Type of this class
        
        RECT.init(self, _x, _y, _w, _h, _b_color) --Set atributes

        self.func  = _func  --Function to call when pressed

        WTXT.init(self, _text, _font, _t_color) --Set text
    end
}



--Draws a given square button with centralized text
function But:draw()
    local fwidth, fheight, tx, ty, b

    b = self

    --Draws button box
    Rgb.set(b.color)
    love.graphics.rectangle("fill", b.x, b.y, b.w, b.h)
    
    fwidth  = b.font:getWidth(b.text)  --Width of font
    fheight = b.font:getHeight(b.text) --Height of font
    tx = (b.w - fwidth)/2              --Relative x position of font on textbox
    ty = (b.h - fheight)/2             --Relative y position of font on textbox

    --Draws button text
    Rgb.set(b.t_color)
    love.graphics.setFont(b.font)
    love.graphics.print(b.text, b.x + tx , b.y + ty)

end

--Check if a mouse click collides with any button
function button.checkCollision(x,y)

    if BUTTON_LOCK then return end --If buttons are locked, does nothing

    --Iterate on drawable buttons table
    for _,t in pairs(DRAW_TABLE) do
        for b in pairs(t) do
            if  b.tp == "button"
                and
                b.x <= x
                and
                x <= b.x + b.w
                and
                b.y <= y
                and
                y <= b.y + b.h then
                b:func()
                return
            end
        end
    end

end

--Return functions
return button