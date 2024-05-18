-- @depends Utility.lua
-- @depends Quest.lua

-- All "Q_*" files inherit from the Quest class which can be found in Quest.lua
-- Please refer to that for functions
-- This specific Object is not a class for use but an EXAMPLE, you can copy this file whenever you want to create a new Quest and just rename TEMPLATE within the file.
-- Also remove this comment block if you don't want your compiled .lua file to be long as fuck, make sure to leave in the @depends block though.

local Q_TEMPLATE = {
    name = "TEMPLATE",
    id = 00000,
    prerequisites = {},
    requiredLevel = 1,

    SequenceLogic = function(self)
        local sequence = self:GetSequence()
        if(sequence == 0) then

        elseif(sequence == 1) then

        elseif(sequence == 255) then

        else
            Utility.log("Unexpected quest sequence value! Aborting Quest")
            return false
        end
    end
}

Utility.Object.Inherit(Q_TEMPLATE, Quest)