--MODULE FOR THE GAMESTATE: GAME--

local state = {}

function state:enter()

	--[[EXAMPLE

		Creates a square, adding it to the layer L1 and giving it the id "mySquare"

	]]--
	local square = RECT(50, 50, 100, 100, Color.orange())
	square:addElement(DRAW_TABLE.L1, nil, "mySquare")

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

	--[[EXAMPLE

		Find our square "mySquare" and kills it when pressing the "1" key

	]]--
	if key == "1" then
		local square = Util.findId("mySquare")
		if square then square.death = true end
	end

end

--Return state functions
return state
