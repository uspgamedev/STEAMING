--MODULE WITH LOGICAL, MATHEMATICAL AND USEFUL STUFF--

local util = {}

---------------------
--UTILITIES FUNCTIONS
---------------------


--Clear a single table T with an optional argument mode:
--  mode == "force": clear all elements, ignoring exceptions
--  mode == "remove": apply all exceptions, but removes them afterwards
--  else, just apply exceptions normally and keep them as they are
function util.clearTable(T, mode)
    local exc --Element exception
    
    if not T then return end --If table is empty
    
    --Clear T table
    for i, k in pairs (T) do
        exc = k.exception
        if mode == "force" or not exc then --Don't erase exceptions
        	if exc ~= nil and mode == "remove" then exc = false end
            T[i] = nil
        end
    end

end

--Clear all Drawable Tables with an optional argument mode:
--  mode == "force": clear all tables, ignoring exceptions
--  mode == "remove": apply all exceptions, but removes them afterwards
--  else, just apply exceptions normally and keep them as they are
function util.clearAllDrawTables(mode)
    
    for i, t in ipairs(D_T) do
        util.clearTable(t, mode)
    end

end

--------------------
--GLOBAL FUNCTIONS
--------------------

--Exit program
function util.quit()

    love.event.quit()

end

--Pause program
function util.pause()

    if Gamestate.current() == GS_GAME and GAME_BEGIN then
        Gamestate.switch(GS_PAUSE)
    elseif Gamestate.current() == GS_PAUSE then
        Gamestate.switch(GS_GAME)
    end

end

--Go back to menu screen
function util.goBack()
    
    if Gamestate.current() ~= GS_PAUSE and Gamestate.current() ~= GS_GAMEOVER then
        return
    end

    Gamestate.switch(GS_MENU)

end

--Toggles DEBUG
function util.toggleDebug()
    
    DEBUG = not DEBUG

end

--Get any key that is pressed and checks for generic events
function util.defaultKeyPressed(key)

    if key == 'escape' or key == 'x' then
        util.quit()
    elseif key == 'b' then
        util.goBack()
    elseif key == 'insert' then
        util.toggleDebug()
    elseif key == 'p' then
        util.pause()
    end

end


--Return functions
return util