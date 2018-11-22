local Util = require "util"
local Draw = require "draw"
--MODULE FOR THE GAMESTATE: GAME--

local state = {}

--LOCAL VARIABLES--

local _switch --If gamestate should change to another one

--LOCAL FUNCTIONS--

--STATE FUNCTIONS--
function state:enter()

end

function state:leave()

	Util.destroyAll()

end


function state:update(dt)

	if _switch == "menu" then
		--Gamestate.switch(GS.MENU)
	end

	Util.destroyAll()

end

function state:draw()

    Draw.allTables()

end

function state:keypressed(key)

	if key == "r" then
		_switch = "MENU"
	else
    	Util.defaultKeyPressed(key)
	end

end

--Return state functions
return state
