--PRIMITIVE CLASS--

local primitive = {}

--[[Primitive classes to inherit from]]

--Element: has a type, subtype and id
ELEMENT = Class{
    init = function(self)
        self.tp = nil --Type this element belongs to
        self.subtp = nil --Subtype this element belongs to, if any
        self.id = nil --Id of this element, if any
        self.invisible = false --If this object is not to be draw
        self.death = false --If true, the object will be deleted next update, unless it has the excepton flag as true
        self.exception = false --If this object is not to be removed when clearing tables, even if the death flag is on
        self.timers = {} --Table containing used timers for this object
    end,

    --Sets id for this element, and add it to a ID table for quick lookup
    setId = function(self, _id)
        if self.id then
            ID_TABLE[self.id] = nil --Delete previous Id element
        end
        self.id = _id
        if not _id then return end --If nil, just remove
        ID_TABLE[_id] = self
    end,
    --Sets subtype for this element, and add it to respective subtype table for quick lookup
    setSubtype = function(self, _subtp)
        if self.subtp then
            SUBTP_TABLE[self.subtp][self] = nil --Delete previous subtype this element had
            if not next(SUBTP_TABLE[self.subtp]) then
                SUBTP_TABLE[self.subtp] = nil   --If no more elements of this subtype, delete the table
            end
        end
        self.subtp = _subtp
        if not _subtp then return end  --If nil, just remove element
        if not SUBTP_TABLE[self.subtp] then
            SUBTP_TABLE[self.subtp] = {} --Creates subtype table if it didn't exist
        end
        SUBTP_TABLE[self.subtp][self] = true
    end,

    destroy = function(self, t) --Destroy this element from all tables (quicker if you send his drawable table, if he has one)
        self:setSubtype(nil) --Removes from Subtype table, if its in one
        self:setId(nil) --Removes from Id table, if its in one

        --Iterate through all handles this object might have and cancel from the correspondent timer
        if self.timers then
            for timer,handles in pairs(self.timers) do
                for _,handle in ipairs(handles) do
                    timer:cancel(handle) --Stops any timers this object has
                end
            end
        end

        if t then
            t[self] = nil --If you provide the  drawable table, removes from it quicker
        else
            for _,tb in pairs(DRAW_TABLE) do--Iterates in all drawable tables and removes element
                if tb[self] then
                    tb[self] = nil
                    return
                end
            end
        end
    end,

    addElement = function(self, draw_table_label, subtp, id) --Add element to a drawable table with label "draw_table_label", and if desired, adds a subtype and/or id
        DRAW_TABLE[draw_table_label][self] = true
        if subtp then self:setSubtype(subtp) end
        if id then self:setId(id) end
    end,

    --Kill this object
    kill = function(self)

        if self.death then return end
        self.death = true

    end,

    --Stores with a label a handle on the element given timer and function to use. Pass the arguments for the timer fucntionas well.
    --If given a label, its the same as
    --  self.timers[label] = timer.func(...)
    --If not just inserts the handle
    addTimer = function(self, label, timer, func, ...)

        --Initialize table if it doesn't exists
        if not self.timers[timer] then self.timers[timer] = {} end

        if label then
            self.timers[timer][label] = timer[func](timer,...)
        else
            table.insert(self.timers[timer], timer[func](timer,...))
        end

    end,

    --Remove a timer from element table
    removeTimer = function(self, label, timer)
        if not self.timers[timer] or not self.timers[timer][label] then return end

        timer:cancel(self.timers[timer][label])

    end
}

-------------------
--CHARACTERISTICS--
-------------------

--Positionable: has a x and y position
POS = Class{
    init = function(self, _x, _y) --Set position for object
        self.pos = Vector(_x or 0, _y or 0) --Position vector
    end,

    setPos = function(self, _x, _y) --Set position for object
        self.pos.x, self.pos.y = _x, _y
    end
}

--Colorful: the object has a color, and a color table for  transistions
CLR = Class{
    init = function(self, _c)
        if _c then
            self.color = Color.getCopy(_c) --This object main color
        else
            self.color = Color.white()
        end
    end,

    setColor = function(self, _c) --Set object's color
        Color.copy(self.color, _c)
    end,

}

--With-Text: the object has a text
WTXT = Class{
    init = function(self, _text, _font, _t_color) --Set circle's atributes
        self.text = _text or "sample" --This object text
        self.font = _font             --This object text font
        self.t_color = _t_color or Color.new(0,0,0) --This object text color
        if _text_color then Color.copy(self.t_color, _t_color) end
    end,

    setTextColor = function(self, _c) --Set object's text color
        Color.copy(self.t_color, _c)
    end
}

--Drawable object with a 2-dimension position, color, rotation and scale(x,y)
DRAWABLE = Class{
    __includes = {ELEMENT, POS, CLR},
    init = function(self, _x, _y, _c, _rotation, _sx, _sy)
        ELEMENT.init(self)
        POS.init(self, _x, _y)
        CLR.init(self, _c)

        self.rotation = _rotation
        self.sx = _sx
        self.sy = _sy

        self.tp = "drawable"
    end
}

-----------------
--SIMPLE SHAPES--
-----------------

-----------------------
--RECTANGLE FUNCTIONS--
-----------------------

--Rectangle: is a positionable and colorful object with width and height
RECT = Class{
    __includes = {DRAWABLE},
    init = function(self, _x, _y, _w, _h, _c, _mode, _line_width) --Set rectangle's atributes
        DRAWABLE.init(self, _x, _y, _c, 0, 1, 1)

        self.w = _w or 10 --Width
        self.h = _h or 10 --Height

        self.mode = self.mode or _mode or "fill" --Mode to draw the triangle
        self.line_width = _line_width or 3 --Line thickness if mode is line

        self.tp = "rectangle"
    end,

    resize = function(self, _w, _h) --Change width/height
        self.w = _w
        self.h = _h
    end

}

--Draws the rectangle
function RECT:draw()
    local p

    p = self

    Color.set(p.color)
    if p.mode == "line" then
        love.graphics.setLineWidth(p.line_width)
    end

    love.graphics.rectangle(p.mode, p.pos.x, p.pos.y, p.w, p.h)

end

----------------------
--TRIANGLE FUNCTIONS--
----------------------

--Triangle: is a positionable and colorful object with three points
TRIANGLE = Class{
    __includes = {ELEMENT, CLR},
    init = function(self, _pos1, _pos2, _pos3, _c, _mode, _line_width) --Set rectangle's atributes
        ELEMENT.init(self)
        CLR.init(self, _c)

        --Triangle positions
        self.p1 = Vector(_pos1.x, _pos1.y)
        self.p2 = Vector(_pos2.x, _pos2.y)
        self.p3 = Vector(_pos3.x, _pos3.y)

        self.mode = self.mode or _mode or "line" --Mode to draw the triangle
        self.line_width = _line_width or 3 --Line thickness if mode is line

        self.tp = "rectangle"
    end
}

--Draws the triangle
function TRIANGLE:draw()
    local t

    t = self

    --Draws the triangle
    Color.set(t.color)
    if t.mode == "line" then
        love.graphics.setLineWidth(t.line_width)
    end
    love.graphics.polygon(t.mode, t.p1.x, t.p1.y, t.p2.x, t.p2.y, t.p3.x, t.p3.y)
end

--------------------
--CIRCLE FUNCTIONS--
--------------------

--Circle: is a positionable and colorful object with radius
CIRC = Class{
    __includes = {ELEMENT, POS, CLR},
    init = function(self, _x, _y, _r, _c, _mode) --Set circle's atributes
        ELEMENT.init(self)
        POS.init(self, _x, _y)
        self.r = _r --Radius
        self.mode = _mode or "fill" --Circle draw mode
        CLR.init(self, _c)
    end,

    resize = function(self, _r) --Change radius
        self.r = _r
    end
}

--Draws the circle
function CIRC:draw()

    local circ = self

    Color.set(circ.color)
    if circ.mode == "line" then
        love.graphics.setLineWidth(circ.line_width)
    end

    love.graphics.circle(circ.mode, circ.pos.x, circ.pos.y, circ.r)

end

-------------------
--IMAGE FUNCTIONS--
-------------------

--Image: is a drawable object with an image
IMAGE = Class{
    __includes = {DRAWABLE},
    init = function(self, _image, _x, _y, _c, _sx, _sy, _rotation) --Set circle's atributes
        DRAWABLE.init(self, _x, _y, _c, _rotation, _sx, _sy)

        self.image = _image

    end,
}

--Draws the image
function IMAGE:draw()

    local img = self

    Color.set(img.color)
    love.graphics.draw(img.image, img.pos.x, img.pos.y, img.rotation, img.sx, img.sy)

end
