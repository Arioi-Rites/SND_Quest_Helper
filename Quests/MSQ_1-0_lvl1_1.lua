local MSQ_1_0_lvl1_1 = {
    name = "Coming to Limsa Lominsa",
    id = 65643,
    prerequisites = {},
    requiredLevel = 1,

    SequenceLogic = function(self)
        local sequence = self:GetSequence()
        if(sequence == 0) then
            Player:MoveTo(NPC_Ryssfloh:GetPos())
            Player:WaitForMoveUntilEntityInReach(NPC_Ryssfloh)
            NPC_Ryssfloh:Interact()
            Player:WaitForAvailable()
        elseif(sequence == 1) then
            Player:MoveTo(NPC_Grehfarr:GetPos())
            Player:WaitForMoveUntilEntityInReach(NPC_Grehfarr)
            NPC_Grehfarr:Interact()
            yield("/wait 2")
            Utility.Dialogue.SelectYes()
            Player:WaitForAvailable()
        elseif(sequence == 255) then
            Player:MoveTo(NPC_Baderon:GetPos())
            Player:WaitForMoveUntilEntityInReach(NPC_Baderon)
            NPC_Baderon:Interact()
            Player:WaitForAvailable()
        else
            Utility.log("Unexpected quest sequence value! Aborting Quest")
            return false
        end
    end
}

Utility.Object.Inherit(MSQ_1_0_lvl1_1, Quest)