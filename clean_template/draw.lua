--MODULE FOR DRAWING STUFF--

local draw = {}

----------------------
--BASIC DRAW FUNCTIONS
----------------------

--Draws every drawable object from all tables
function draw.allTables()

    draw.DrawTable(DRAW_TABLE.BG)

    draw.DrawTable(DRAW_TABLE.L1)

    draw.DrawTable(DRAW_TABLE.L2)

    draw.DrawTable(DRAW_TABLE.GUI)

end

--Draw all the elements in a table
function draw.DrawTable(t)

    for o in pairs(t) do
        if not o.invisible then
          o:draw() --Call the object respective draw function
        end
    end

end

--Return functions
return draw
