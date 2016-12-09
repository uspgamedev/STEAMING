local Util = require "util"
local Draw = require "draw"

--MODULE FOR THE GAMESTATE: GAME--

local state = {}

function state:enter()

end

function state:leave()

end


function state:update(dt)

	Util.destroyAll()

end

function state:draw()
    
    Draw.allTables()

end

function state:keypressed(key)

    Util.defaultKeyPressed(key)
    
end

--Return state functions
return state