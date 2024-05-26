-- @depends Quest.lua
-- @depends NPC_Ryssfloh.lua
-- @depends NPC_Grehfarr.lua
-- @depends NPC_Baderon.lua

local Q_MSQ_1_0_lvl1_1 = {
    name = "Coming to Limsa Lominsa",
    id = 65643,
    prerequisites = {},
    requiredLevel = 1,

    SequenceLogic = function(self)
        local sequence = self:GetSequence()
        if(sequence == 0) then
            Player:MoveUntilEntityInReach(NPC_Ryssfloh)
            Player:Interact(NPC_Ryssfloh)
            Player:WaitForAbsolutelyAvailable()
        elseif(sequence == 1) then
            Player:MoveUntilEntityInReach(NPC_Grehfarr)
            Player:Interact(NPC_Grehfarr)
            Utility.Wait.double()
            Dialogue.SelectYes()
            Player:WaitForAvailable()
        elseif(sequence == 255) then
            Player:MoveUntilEntityInReach(NPC_Baderon)
            Player:Interact(NPC_Baderon)
            Player:WaitForAvailable()
        else
            Utility.log("Unexpected quest sequence value! Aborting Quest")
            return false
        end
        return true
    end
}

Utility.Object.Inherit(Q_MSQ_1_0_lvl1_1, Quest)