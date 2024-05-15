local Q_Making_a_Name = {
    name = "Making a Name",
    id = 65647,
    prerequisites = {65643},
    requiredLevel = 1,

    QuestEntities = {
        PeculiarHerb = {
            name = "Peculiar Herb",
            type == "item",
            itemId = 2000447,
            requiredItemAmount = 6,
            interactionDistance = 1
        }
    },

    SequenceLogic = function(self)
        local sequence = self:GetSequence()
        if(sequence == 0) then
            Player:EnsureZone(NPC_Niniya.zone, true)
            Player:MoveUntilEntityInReach(NPC_Niniya)
            Player:Interact()
            Player:WaitForAvailable()
        elseif(sequence == 1) then
            Player:EnsureZone(NPC_Skaenrael.zone, true)
            Player:MoveUntilEntityInReach(NPC_Skaenrael)
            Player:Interact()
            Utility.Wait.short()
            Utility.Dialogue.SelectYes()
            Player:WaitForAvailable()
        elseif(sequence == 2) then
            while not self.QuestEntities.PeculiarHerb:AllCollected() do
                Player:EnsureZone("Limsa_Lower_Decks", true)
                Player:MoveUntilEntityInReach(self.QuestEntities.PeculiarHerb)
                Player:Interact()
                Player:WaitForCastAndAvailable()
            end
        elseif(sequence == 255) then
            Player:EnsureZone(NPC_Ahldskyf.zone, true)
            Player:MoveUntilEntityInReach(NPC_Ahldskyf)
            Player:Interact()
            Player:WaitForAvailable()
        else
            Utility.log("Unexpected quest sequence value! Aborting Quest")
            return false
        end
    end
}

Utility.Object.Inherit(Q_Making_a_Name, Quest)