local MSQ_1_0_lvl1_2 = {
    name = "Close to Home",
    id = 65644,
    prerequisites = {65643},
    requiredLevel = 1,

    QuestEntities = {
        LimsaAetheryte = {
            name = "Aetheryte",
            zone = "Limsa_Lower_Decks",
            position = { X = -81.5 , Y = 18.8 , Z = -4.68 },
            type == "prog",
            interactionDistance = 5
        }
    },

    SequenceLogic = function(self)
        local sequence = self:GetSequence()
        if(sequence == 0) then
            Player:EnsureZone(NPC_Baderon.zone, true)
            Player:MoveUntilEntityInReach(NPC_Baderon)
            Player:Interact()
            Player:WaitForAvailable()
        elseif(sequence == 1) then
            Player:EnsureZone(self.QuestEntities.LimsaAetheryte.zone, true)
            Player:MoveUntilEntityInReach(self.QuestEntities.LimsaAetheryte, true)
            Player:Interact()
            Player:WaitForCastAndAvailable()
            -- Objective 1 Done
            Player:MoveUntilEntityInReach(NPC_Swozblaet)
            Player:Interact()
            Player:WaitForAvailable()
            -- Objective 2 Done
            Player:MoveUntilEntityInReach(NPC_Grehfarr, true)
            Player:Interact()
            Utility.Wait.double()
            Utility.Dialogue.SelectYes()
            Player:WaitForAvailable()
        elseif(sequence == 2) then

        elseif(sequence == 255) then

        else
            Utility.log("Unexpected quest sequence value! Aborting Quest")
            return false
        end
    end
}

Utility.Object.Inherit(MSQ_1_0_lvl1_2, Quest)