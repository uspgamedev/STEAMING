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
    for o in pairs (T) do
        exc = o.exception
        if mode == "force" or not exc then --Don't erase exceptions
        	if exc ~= nil and mode == "remove" then exc = false end
            o:destroy()
        end
    end

end

--Clear all Drawable Tables (and respective Id/Subtype tables) with an optional argument mode:
--  mode == "force": clear all tables, ignoring exceptions
--  mode == "remove": apply all exceptions, but removes them afterwards
--  else, just apply exceptions normally and keep them as they are
function util.clearAllTables(mode)
    
    for i, t in ipairs(D_T) do
        util.clearTable(t, mode)
    end

end

--------------
--FIND OBJECTS
--------------

--Find an object based on an id
function util.findId(id)
    return ID_T[id]
end

--Find a set of objects based on a subtype
function util.findSubtype(subtp)
    return SUBTP_T[subtp]
end

-----------------
--DESTROY OBJECTS
-----------------

--Delete an object based on an id
function util.destroyId(id)
    if ID_T[id] then ID_T[id]:destroy() end 
end

--Delete a set of objects based on a subtype
function util.destroySubtype(subtp)
    if SUBTP_T[subtp] then
        for o in pairs do
            SUBTP_T[subtp][o]:destroy()
        end 
    end
end

---------------------------
--APPLY EXCEPTION FUNCTIONS
---------------------------

---------------------------
--APPLY INVISIBLE FUNCTIONS
---------------------------

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