-- @depends Quest.lua
-- @depends NPC_Grehfarr.lua
-- @depends NPC_Swozblaet.lua
-- @depends NPC_Baderon.lua

local Q_MSQ_1_0_lvl1_2 = {
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
            Player:Interact(NPC_Baderon)
            Player:WaitForAvailable()
        elseif(sequence == 1) then
            Player:EnsureZone(self.QuestEntities.LimsaAetheryte.zone, true)
            Player:MoveUntilEntityInReach(self.QuestEntities.LimsaAetheryte, true)
            Player:Interact(self.QuestEntities.LimsaAetheryte)
            Player:WaitForCastAndAvailable()
            -- Objective 1 Done
            Player:MoveUntilEntityInReach(NPC_Swozblaet)
            Player:Interact(NPC_Swozblaet)
            Player:WaitForAvailable()
            -- Objective 2 Done
            Player:MoveUntilEntityInReach(NPC_Grehfarr, true)
            Player:Interact(NPC_Grehfarr)
            Utility.Wait.double()
            Dialogue.SelectYes()
            Player:WaitForAvailable()
        elseif(sequence == 2) then

        elseif(sequence == 255) then

        else
            Utility.log("Unexpected quest sequence value! Aborting Quest")
            return false
        end
        return true
    end
}

Utility.Object.Inherit(Q_MSQ_1_0_lvl1_2, Quest)