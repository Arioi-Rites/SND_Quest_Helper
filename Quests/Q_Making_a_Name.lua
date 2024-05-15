local Q_Making_a_Name = {
    name = "Making a Name",
    id = 65647,
    prerequisites = {65643},
    requiredLevel = 1,

    QuestItems = {
        PeculiarHerb = {
            name = "Peculiar Herb",
            id = 2000447,
            required = 6
        }
    },

    SequenceLogic = function(self)
        local sequence = self:GetSequence()
        if(sequence == 0) then
            --Player:EnsureZone(NPC_Niniya.zone)
            Player:MoveTo(NPC_Niniya:GetPos())
            Player:WaitForMoveUntilEntityInReach(NPC_Niniya)
            NPC_Niniya:Interact()
            Player:WaitForAvailable()
        elseif(sequence == 1) then
            --Player:EnsureZone(NPC_Skaenrael.zone)
            Player:MoveTo(NPC_Skaenrael:GetPos())
            Player:WaitForMoveUntilEntityInReach(NPC_Skaenrael)
            NPC_Skaenrael:Interact()
            Utility.Wait.short()
            Utility.Dialogue.SelectYes()
            Player:WaitForAvailable()
        elseif(sequence == 2) then
            while not self.QuestItems.PeculiarHerb:AllCollected() do
                Player.MoveTo(self.QuestItems.PeculiarHerb)
                Player:WaitForMoveUntilEntityInReach(self.QuestItems.PeculiarHerb)
                NPC_Skaenrael:Interact()
                Player:WaitForAvailable()
            end
        elseif(sequence == 255) then

        else
            Utility.log("Unexpected quest sequence value! Aborting Quest")
            return false
        end
    end
}

Utility.Object.Inherit(Q_Making_a_Name, Quest)