local Rgb = require "classes.color.rgb"
local Hsl = require "classes.color.hsl"
--COLOR CLASS--

--Wrapper to properly handle HSV or RGB colors

local Color = {}
local Default = "HSL" --Default mode for colors in this program.

--Returns a new color identical to the one provided
function Color.getCopy(c)
    if c1.type == "RGB" then
        return RGB(c.r, c.g, c.b, c.a)
    elseif c1.type == "HSL" then
        return HSL(c.h, c.s, c.l, c.a)
    end
end

--Copy colors from a color c2 to a color c1 (both have to be the same type)
function Color.copy(c1, c2)
    if c1.type == "RGB" then
        Rgb.copy(c1, c2)
    elseif c1.type == "HSL" then
        Hsl.copy(c1, c2)
    end
end

--Set color c as love drawing color
function Color.set(c)
    if c.type == "RGB" then
        Rgb.set(c)
    elseif c.type == "HSL" then
        Hsl.set(c)
    end
end

--Set the color used for drawing using 255 as alpha amount
function Color.setOpaque(c)
    if c.type == "RGB" then
        Rgb.setOpaque(c)
    elseif c.type == "HSL" then
        Hsl.setOpaque(c)
    end
end

--Set the color used for drawing using 0 as alpha amount
function Color.setTransp(c)
    if c.type == "RGB" then
        Rgb.setTransp(c)
    elseif c.type == "HSL" then
        Hsl.setTransp(c)
    end
end

---------------
--PRESET COLORS
---------------

--Dark Black
function Color.black(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.black()
    else
      return Rgb.black()
    end
end

--Clean white
function Color.white(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.white()
    else
        return Rgb.white()
    end
end

--Cheerful red
function Color.red(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.red()
    else
        return Rgb.red()
    end
end

--Calm green
function Color.green(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.green()
    else
        return Rgb.green()
    end
end

--Smooth blue
function Color.blue(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.blue()
    else
        return Rgb.blue()
    end
end

--Jazzy orange
function Color.orange(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.orange()
    else
        return Rgb.orange()
    end
end

--Sunny yellow
function Color.yellow(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.yellow()
    else
        return Rgb.yellow()
    end
end

--Sexy purple
function Color.purple(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.purple()
    else
        return Rgb.purple()
    end
end

--Happy pink
function Color.pink(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.pink()
    else
        return Rgb.pink()
    end
end

--Invisible transparent
function Color.transp(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.transp()
    else
        return Rgb.transp()
    end
end

--Return functions
return Color
