local Rgb = require "classes/rgb"

--MODULE FOR DRAWING STUFF--

local draw = {}

----------------------
--BASIC DRAW FUNCTIONS
----------------------

--Draws every drawable object from all tables
function draw.allTables()
    
    DrawTable(D_T.L1)

    DrawTable(D_T.L2)

    CAM:attach() --Start tracking camera
    
    DrawTable(D_T.L3)

    DrawTable(D_T.L4)

    DrawTable(D_T.L5)

    CAM:detach() --Stop tracking camera

    DrawTable(D_T.L6)
    
end

--Draw all the elements in a table
function DrawTable(t)

    for o in pairs(t) do
        love.graphics.setShader(o.shader) --Set object shader, if any
        o:draw() --Call the object respective draw function
        love.graphics.setShader() --Remove shader, if any
    end

end


---------------------------------
--DRAWING-TABLE MANAGER FUNCTIONS
---------------------------------

function draw.findId()
end

--Return functions
return draw