local Util = require "util"
local Draw = require "draw"
local Rgb  = require "classes.rgb" 

--MODULE FOR THE GAMESTATE: GAME--

--BUTTON FUNCTION--

local but1 = require "buttons.renato_button"

local state = {}

function state:enter()
    local b

    b = But(10, 10, 200, 300, Rgb.orange(), but1, "FRANKIE SAYS RENATO", my_font)
    b:addElement(DRAW_TABLE.L1, "big_buttons", "renato_button")

end

function state:leave()

    Util.clearAllTables()

end


function state:update(dt)


end

function state:draw()
    
    Draw.allTables()

end

function state:keypressed(key)
    local i

    Util.defaultKeyPressed(key)
    

end

--Return state functions
return state