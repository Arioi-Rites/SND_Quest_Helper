local MSQ_1_0_lvl1_2 = {
    name = "Close to Home",
    id = 65644,
    prerequisites = {65643},
    requiredLevel = 1,

    SequenceLogic = function(self)
        local sequence = self:GetSequence()
        if(sequence == 0) then
            Player:MoveTo(NPC_Baderon:GetPos())
            Player:WaitForMoveUntilEntityInReach(NPC_Baderon)
            NPC_Baderon:Interact()
            Player:WaitForAvailable()
        elseif(sequence == 1) then
            
        elseif(sequence == 255) then

        else
            Utility.log("Unexpected quest sequence value! Aborting Quest")
            return false
        end
    end
}

Utility.Object.Inherit(MSQ_1_0_lvl1_2, Quest)