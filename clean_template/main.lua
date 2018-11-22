--HUMP STUFF
local Gamestate = require "extra_libs.hump.gamestate"


--MY MODULES
local Setup     = require "setup"
local Res       = require "res_manager"


--GAMESTATES
GS = {
    --MENU     = require "gamestates.menu",     --Menu Gamestate
    GAME     = require "gamestates.game",     --Game Gamestate
    --GAMEOVER = require "gamestates.gameover"  --Gameover Gamestate
}

------------------
--LÖVE FUNCTIONS--
------------------

function love.load()

    Setup.config() --Configure your game

    Gamestate.registerEvents() --Overwrites love callbacks to call Gamestate as well

    --[[
        Setup support for multiple resolutions. Res.init() Must be called after Gamestate.registerEvents()
        so it will properly call the draw function applying translations.
    ]]
    Res.init()

    Gamestate.switch(GS.GAME) --Jump to the inicial state

end
