-- @depends Utility.lua
-- @depends Entity.lua

-- All "NPC_*" files inherit from the Entity class which can be found in Entity.lua
-- Please refer to that for functions
-- This specific Object is not a class for use but an EXAMPLE, you can copy this file whenever you want to create a new NPC and just rename TEMPLATE within the file.
-- Also remove this comment block if you don't want your compiled .lua file to be long as fuck, make sure to leave in the @depends block though.

local NPC_TEMPLATE = {
    name = "TEMPLATE",
    zone = "Default",
    position = {X = -0 , Y = 0 , Z = -0 }
}

Utility.Object.Inherit(NPC_TEMPLATE, Entity)