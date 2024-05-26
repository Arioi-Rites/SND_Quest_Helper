-- @depends Utility.lua
-- @depends Entity.lua

local NPC_Baderon = {
    name = "Baderon",
    zone = "Limsa_Upper_Decks_Aftcastle",
    position = {X = 17.6 , Y = 40.2 , Z = -4.54 }
}

Utility.Object.Inherit(NPC_Baderon, Entity)