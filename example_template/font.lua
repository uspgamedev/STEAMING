--MODULE WITH FONTS UTILITIES AND STUFF--

local fonts_funcs = {}

--[[
Table containing a database for all fonts.

Each field in the table will have a field "path", containing the path to the font file,
and a field "fonts", that is a table containing all sizes created for this font
--]]
local Fonts_Table = {}

------------------
--MANAGING FONTS--
------------------

--Creates a new "database" for a font, provided a path for font file and the font name.
--Will overwrite if there was a previously defined font with the same label
function fonts_funcs.new(font_name, path_to_font_file)

    Fonts_Table[font_name] = {
        path = path_to_font_file,
        fonts = {}
    }

end

--[[
Returns the font object given a font name and size.
By default, if the font size wasn't already created, it will create and store in the Fonts_Table,
but you can provide an optional argument "dont_store" so it won't store the font object.

]]--
function fonts_funcs.get(font_name, size, dont_store)
    dont_store = dont_store or false

    local font_db = Fonts_Table[font_name] --Database with font information

    --Leave function if font doesn't exist
    if not font_db then
        if DEBUG then print("Tried to get inexistent font!") end
        return
    end

    if not font_db.fonts[size] then
        --If font size didn't exist
        local font = love.graphics.newFont(font_db.path, size)
        if dont_store then
            return font
        else
            font_db.fonts[size] = font
            return font
        end
    else
        --If font size already existed
        return font_db.fonts[size]
    end

end

--[[
Sets the current Love font, given a font name and size.
By default, if the font size wasn't already created, it will create and store in the Fonts_Table,
but you can provide an optional argument "dont_store" so it won't store the font object.

Returns the font object given a font name and size.
]]--
function fonts_funcs.set(font_name, size, dont_store)
    dont_store = dont_store or false

    local font_db = Fonts_Table[font_name] --Database with font information

    --Leave function if font doesn't exist
    if not font_db then
        if DEBUG then print("Tried to set inexistent font!") end
        return
    end

    if not font_db.fonts[size] then
        --If font size didn't exist
        local font = love.graphics.newFont(font_db.path, size)
        if dont_store then
            love.graphics.setFont(font)
            return font
        else
            font_db.fonts[size] = font
            love.graphics.setFont(font)
            return font
        end
    else
        --If font size already existed
        love.graphics.setFont(font_db.fonts[size])
        return font_db.fonts[size]
    end

end


--Return functions
return fonts_funcs
