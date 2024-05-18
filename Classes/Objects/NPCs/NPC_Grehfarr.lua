-- @depends Utility.lua
-- @depends Entity.lua

local NPC_Grehfarr = {
    name = "Grehfarr",
    zone = "Limsa_Lower_Decks",
    position = {X = 11.18 , Y = 20.99 , Z = 13.32 }
}

Utility.Object.Inherit(NPC_Grehfarr, Entity)