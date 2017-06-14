--HUMP STUFF
Gamestate = require "extra_libs.hump.gamestate"
Timer     = require "extra_libs.hump.timer"
Class     = require "extra_libs.hump.class"
Camera    = require "extra_libs.hump.camera"
Vector    = require "extra_libs.hump.vector"


--CLASSES

require "classes.primitive"
Color = require "classes.color.color"

--MY MODULES
Util      = require "util"
Draw      = require "draw"
Setup     = require "setup"
Font      = require "font"
Res       = require "res_manager"




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
