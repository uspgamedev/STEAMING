local Class = require "extra_libs.hump.class"

--PRIMITIVE CLASS--

--Element: has a type, subtype and id
local Element = Class {
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

    setDrawTable = function(self, draw_table_label)
        --Check for previous draw table and remove it
        for idx, draw_table in pairs(DRAW_TABLE) do
            if draw_table[self] then draw_table[self] = nil end
        end
        DRAW_TABLE[draw_table_label][self] = true
    end,

    getDrawTable = function(self)
        local label
        for idx, draw_table in pairs(DRAW_TABLE) do
            if draw_table[self] then
                label = idx
            end
        end
        return label
    end,

    register = function(self, draw_table_label, subtp, id) --Add element to a drawable table with label "draw_table_label", and if desired, adds a subtype and/or id
        if draw_table_label then self:setDrawTable(draw_table_label) end
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

return Element
