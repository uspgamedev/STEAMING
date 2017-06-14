local res = {}

local W
local H

local scale, tx, ty

local function __NULL__() end

function res.init()
    W = O_WIN_W
    H = O_WIN_H

    love.graphics.setDefaultFilter('linear', 'linear')

    --Overwrite love getWidth and getHeight functions to account for translations
    res.getRealWidth = love.graphics.getWidth
    res.getRealHeight = love.graphics.getHeight
    love.graphics.getWidth = function() return W end
    love.graphics.getHeight = function() return H end

    --Overwrite love function getMousePosition to get the correct mouse position
    res.getMouseRealPosition = love.mouse.getPosition
    love.mouse.getPosition = function()
        local x, y = res.getMouseRealPosition()
        x = (x - tx) / scale
        y = (y - ty) / scale
        return x, y
    end

    --Overwrite love mouse and touch function to account for translations
    local registry = {}
    local callbacks = {"mousepressed", "mousereleased"}
    for _, f in ipairs(callbacks) do
		registry[f] = love[f] or __NULL__
		love[f] = function(x, y, ...)
            x, y = love.mouse.getPosition() -- fixed
			return registry[f](x, y, ...)
		end
	end
    registry["mousemoved"] = love["mousemoved"] or __NULL__
    love["mousemoved"] = function(x, y, dx, dy, ...)
        x, y = love.mouse.getPosition() -- fixed
        dx, dy = dx * res.scale(), dy * res.scale()
        return registry["mousemoved"](x, y, dx, dy, ...)
    end
    callbacks = {"touchpressed", "touchreleased", "touchmoved"}
    for _, f in ipairs(callbacks) do
        registry[f] = love[f] or __NULL__
        love[f] = function(id, x, y, dx, dy, ...)
            x = (x - tx) / scale
            y = (y - ty) / scale
            dx, dy = dx * res.scale(), dy * res.scale()
            return registry[f](id, x, y, dx, dy, ...)
        end
    end

    --Overwrite love draw function to add pre and after translation effects
    registry["draw"] = love["draw"] or __NULL__
    love["draw"] = function(...)
        res.preDraw()
        registry["draw"](...)
        res.postDraw()
    end

    --Overwrite love resize function
    registry["resize"] = love["resize"] or __NULL__
    love["resize"] = function(w, h)
        res.adjustWindow(w,h)
        registry["resize"](w, h)
    end

    --Adjust window size
    res.adjustWindow(res.getRealWidth(), res.getRealHeight())

end

function res.toRealCoords(x, y)
    return tx + x * scale, ty + y * scale
end

function res.scale() return scale end

function res.translation() return tx, ty end


function res.adjustWindow(w, h)
    local sx, sy = w / W, h / H
    scale = math.min(sx, sy)
    if sx <= sy then
        tx, ty = 0, (h - H * sx) / 2
    else
        tx, ty = (w - W * sy) / 2, 0
    end
end

function res.preDraw()
    love.graphics.push()
    love.graphics.translate(tx, ty)
    love.graphics.scale(scale, scale)
end

function res.postDraw()
    love.graphics.pop()
    love.graphics.setColor(25, 25, 0)
    if tx > 0 then
        love.graphics.rectangle('fill', 0, 0, tx, res.getRealHeight())
        love.graphics.rectangle('fill', res.getRealWidth() - tx, 0, tx, res.getRealHeight())
    elseif ty > 0 then
        love.graphics.rectangle('fill', 0, 0, res.getRealWidth(), ty)
        love.graphics.rectangle('fill', 0, res.getRealHeight() - ty, res.getRealWidth(), ty)
    end
end

--Return functions
return res
