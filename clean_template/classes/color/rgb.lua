local Hsl = require "classes.color.hsl"
--MODULE FOR COLOR AND STUFF--

local rgb_funcs = {}

--Color object
RGB = Class{
    init = function(self, r, g, b, a)
        self.r     = r or 255 --Red
        self.g     = g or 255 --Green
        self.b     = b or 255 --Blue
        self.a     = a or 255 --Alpha

        self.tp = "RGB"
    end
}

------------------
--USEFUL FUNCTIONS
------------------
--Converts RGB to HSL. (input and output range: 0 - 255)
function rgb_funcs.convert(r, g, b, a)

    r = r/255
    g = g/255
    b = b/255

    local min = math.min(r,g,b)
    local max = math.max(r,g,b)

    --Get lightness in %
    local l = (min+max)/2

    --Get saturation in %
    local s
    if l < .5 then
        s =  (max-min)/(max+min)
    else
        s = (max-min)/(2-max-min)
    end

    --Get Hue in degrees
    local h
    if r == max then
        h = (g-b)/(max-min)
    elseif g == max then
        h = 2.0 + (b-r)/(max-min)
    elseif b == max then
        h = 4.0 + (r-g)/(max-min)
    end
    h = h*60

    --Convert them to the standard values
    return Hsl.sdtv(h,s,l,a)
end

--Return red, green and blue levels of given color c
function rgb_funcs.rgb(c) return c.r, c.g, c.b end

--Return red, green, blue and alpha levels of given color c
function rgb_funcs.rgba(c) return c.r, c.g, c.b, c.a end

--Return alpha level of given color c
function rgb_funcs.a(c) return c.a end

--Copy colors from a color c2 to a color c1
function rgb_funcs.copy(c1, c2)  c1.r, c1.g, c1.b, c1.a = c2.r, c2.g, c2.b, c2.a end

--Set the color used for drawing
function rgb_funcs.set(c) love.graphics.setColor(c.r, c.g, c.b, c.a) end

--Set the color used for drawing using 255 as alpha amount
function rgb_funcs.setOpaque(c) love.graphics.setColor(c.r, c.g, c.b, 255) end

--Set the color used for drawing using 0 as alpha amount
function rgb_funcs.setTransp(c) love.graphics.setColor(c.r, c.g, c.b, 0) end

---------------
--PRESET COLORS
---------------

--Dark Black
function rgb_funcs.black()
    return RGB(0,0,0)
end

--Clean white
function rgb_funcs.white()
    return RGB(255,255,255)
end

--Cheerful red
function rgb_funcs.red()
    return RGB(240,41,74)
end

--Calm green
function rgb_funcs.green()
    return RGB(99,247,92)
end

--Smooth blue
function rgb_funcs.blue()
    return RGB(25,96,209)
end

--Jazzy orange
function rgb_funcs.orange()
    return RGB(247,154,92)
end

--Sunny yellow
function rgb_funcs.yellow()
    return RGB(240,225,65)
end

--Sexy purple
function rgb_funcs.purple()
    return RGB(142,62,240)
end

--Happy pink
function rgb_funcs.pink()
    return RGB(242,85,195)
end

--Invisible transparent
function rgb_funcs.transp()
    return RGB(0,0,0,0)
end

--Return functions
return rgb_funcs
