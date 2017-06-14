local Rgb = require "classes.color.rgb"
local Hsl = require "classes.color.hsl"
--COLOR CLASS--

--Wrapper to properly handle HSV or RGB colors

local color_funcs = {}
local Default = "HSL" --Default mode for colors in this program.

--Returns a new color, given its 4 basic values: (hue, saturation, lightness and alpha) or (red, green, blue and alpha).
--You can provide the type, or else it will use the default type
--Tee first argument can be an already created color table. If so, the function will act exactly as color_funcs.getCopy().
function color_funcs.new(h_r_color, s_g, l_b, a, tp, sdtv)

    --Creates a copy of the color if its the first argument
    if type(h_r_color) == "table" then
        return color_funcs.getCopy(h_r_color)
    end

    tp = tp or Default
    a = a or 255
    if tp == "HSL" then
        if sdtv then
            local h,s,l,a = Hsl.sdtv(h_r_color, s_g, l_b, a)
            HSL(h,s,l,a)
        else
            return HSL(h_r_color, s_g, l_b, a)
        end
    elseif tp == "RGB" then
        return RGB(h_r_color, s_g, l_b, a)
    else
        return color_funcs.white()
    end
end

--Returns a new color identical to the one provided
function color_funcs.getCopy(c)
    if c.tp == "RGB" then
        return RGB(c.r, c.g, c.b, c.a)
    elseif c.tp == "HSL" then
        return HSL(c.h, c.s, c.l, c.a)
    end
end

--Copy colors from a color c2 to a color c1 (both have to be the same type)
function color_funcs.copy(c1, c2)
    if c1.tp == "RGB" then
        Rgb.copy(c1, c2)
    elseif c1.tp == "HSL" then
        Hsl.copy(c1, c2)
    end
end

--Set color c as love drawing color
function color_funcs.set(c)

    if c.tp == "RGB" then
        Rgb.set(c)
    elseif c.tp == "HSL" then
        Hsl.set(c)
    end

end

--Converts the color you provide to opposite mode (HSL to RGB, and RGB to HSL)
function color_funcs.convert(c)
    if c.tp == "HSL" then
        local r,g,b,a = Hsl.convert(c.h, c.s, c.l, c.a)
        return RGB(r,g,b,a)
    elseif c.tp == "RBB" then
        local h,s,l,a = Rgb.convert(c.r, c.g, c.b, c.a)
        return HSL(h,s,l,a)
    end
end

--Set the color used for drawing using 255 as alpha amount
function color_funcs.setOpaque(c)
    if c.tp == "RGB" then
        Rgb.setOpaque(c)
    elseif c.tp == "HSL" then
        Hsl.setOpaque(c)
    end
end

--Set the color used for drawing using 0 as alpha amount
function color_funcs.setTransp(c)
    if c.tp == "RGB" then
        Rgb.setTransp(c)
    elseif c.tp == "HSL" then
        Hsl.setTransp(c)
    end
end

---------------
--PRESET COLORS
---------------

--Dark Black
function color_funcs.black(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.black()
    else
      return Rgb.black()
    end
end

--Clean white
function color_funcs.white(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.white()
    else
        return Rgb.white()
    end
end

--Cheerful red
function color_funcs.red(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.red()
    else
        return Rgb.red()
    end
end

--Calm green
function color_funcs.green(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.green()
    else
        return Rgb.green()
    end
end

--Smooth blue
function color_funcs.blue(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.blue()
    else
        return Rgb.blue()
    end
end

--Jazzy orange
function color_funcs.orange(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.orange()
    else
        return Rgb.orange()
    end
end

--Sunny yellow
function color_funcs.yellow(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.yellow()
    else
        return Rgb.yellow()
    end
end

--Sexy purple
function color_funcs.purple(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.purple()
    else
        return Rgb.purple()
    end
end

--Happy pink
function color_funcs.pink(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.pink()
    else
        return Rgb.pink()
    end
end

--Invisible transparent
function color_funcs.transp(mode)
    mode = mode or Default

    if mode == "HSL" then
        return Hsl.transp()
    else
        return Rgb.transp()
    end
end

--Return functions
return color_funcs
