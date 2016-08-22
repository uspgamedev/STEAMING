--MODULE FOR SETUP STUFF--

local setup = {}

--------------------
--SETUP FUNCTIONS
--------------------

--Set game's global variables, random seed, window configuration and anything else needed
function setup.config()
    local sucess --Indicates sucess on window configuration

    --IMAGES--
    --PIXEL = love.graphics.newImage("assets/pixel.png") --Example image

    --RANDOM SEED--
    love.math.setRandomSeed( os.time() )

    --GLOBAL VARIABLES--
    DEBUG = true --DEBUG mode status
    BUTTON_LOCK = false --Blocks buttons to be pressed

    --TIMERS--
    Game_Timer = Timer.new()  --Timer for all game-related timing stuff

    --INITIALIZING TABLES--
    --Drawing Tables
    DRAW_TABLE = {
    L1 = {}, --Layer 1 (bottom layer, first to draw)
    L2 = {}, --Layer 2
    L3 = {}, --Layer 3
    L4 = {}, --Layer 4
    L5 = {}, --Layer 5
    L6 = {}  --Layer 6 (top layer, last to draw)
    }

    --Other Tables
    SUBTP_TABLE = {} --Table with tables for each subtype (for fast lookup)
    ID_TABLE = {} --Table with elements with Ids (for fast lookup)

    --WINDOW CONFIG--
    success = love.window.setMode(500, 500, {borderless = not DEBUG})

    --FONT CONFIG--
    my_font = love.graphics.newFont("assets/fonts/vanadine_bold.ttf", 20)

    --CAMERA--
    CAM = Camera(love.graphics.getWidth()/2, love.graphics.getHeight()/2) --Set camera position to center of screen

    --SHADERS--
    --Example shader for drawing glow effect
    Glow_Shader = love.graphics.newShader[[
        vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords ){
            vec4 pixel = Texel(texture, texture_coords );
            vec2 center = vec2(0.5,0.5);
            number grad = 0.7;
            number dist = distance(center, texture_coords);
            if(dist <= 0.5){
                color.a = color.a * 1-(dist/0.5);
                color.r = color.r * grad;
                color.g = color.g * grad;
                color.b = color.b * grad;
                return pixel*color;
            }
        }
    ]]
end

--Return functions
return setup
