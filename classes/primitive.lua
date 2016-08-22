local Rgb = require "classes.rgb"

--PRIMITIVE CLASS--

local primitive = {}

--[[Primitive classes to inherit from]]

--Element: has a type, subtype and id
ELEMENT = Class{
    init = function(self, _tp, _subtp, _id)
        tp = _tp          --Type this element belongs to
        subtp = _subtp    --Subtype this element belongs to, if any
        id = _id          --Id of this element, if any
        exception = false --If this object is not to be removed when clearing tables
        invisible = false --If this object is not to be draw
    end,

    setId = function(self, _id) --Sets id for this element, and add it to a ID table for quick lookup
        if self.id then
            ID_TABLE[self.id] = nil --Delete previous Id element
        end
        self.id = _id
        if not _id then return end --If nil, just remove
        ID_TABLE[_id] = self
    end,

    setSubTp = function(self, _subtp) --Sets subtype for this element, and add it to respective subtype table for quick lookup
        if self.subtp then
            SUBTP_TABLE[self.subtp][self] = nil --Delete previous subtype this element had
            if #SUBTP_TABLE[self.subtp] == 0 then
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
        setSubTp(self, nil) --Removes from Id table, if its in one
        setId(self, nil) --Removes from Subtype table, if its in one
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

    addElement = function(self, t, subtp, id) --Add element to a t drawable table, and if desired, adds a subtype and/or id
        if subtp then self:setSubTp(subtp) end
        if id then self:setId(id) end
        t[self] = true
    end
}

-------------------
--CHARACTERISTICS--
-------------------

--Positionable: has a x and y position
POS = Class{
    init = function(self, _x, _y) --Set position for object
        self.x = _x or 0 --X position
        self.y = _y or 0 --Y position
    end,

    setPos = function(self, _x, _y) --Set position for object
        self.x, self.y = _x, _y
    end
}

--Colorful: the object has a color
CLR = Class{
    init = function(self, _c)
        self.color = RGB() --This object main color
        if _c then Rgb.copy(self.color, _c) end
    end,

    setColor = function(self, _c) --Set object's color
        Rgb.copy(self.color, _c)
    end
}

--With-Text: the object has a text
WTXT = Class{
    init = function(self, _text, _font, _t_color) --Set circle's atributes
        self.text = _text or "sample" --This object text
        self.font = _font             --This object text font
        self.t_color = RGB(0,0,0)     --This object text color
        if _text_color then Rgb.copy(self.t_color, _t_color) end
    end,

    setTextColor = function(self, _c) --Set object's text color
        Rgb.copy(self.t_color, _c)
    end
}

----------
--SHAPES--
----------

--Rectangle: is a positionable and colorful object with width and height
RECT = Class{
    __includes = {ELEMENT, POS, CLR},
    init = function(self, _x, _y, _w, _h, _c) --Set rectangle's atributes
        ELEMENT.init(self)
        POS.init(self, _x, _y)
        self.w = _w or 10
        self.h = _h or 10
        CLR.init(self, _c)
    end,

    resize = function(self, _w, _h) --Change width/height
        self.w = _w
        self.h = _h
    end

}

--Circle: is a positionable and colorful object with radius
CIRC = Class{
    __includes = {POS, CLR},
    init = function(self, _x, _y, _r, _c) --Set circle's atributes
        ELEMENT.init(self)
        POS.init(self, _x, _y)
        self.r = _r or 10
        CLR.init(self, _c)
    end,

    resize = function(self, _r) --Change radius
        self.r = _r
    end
}
