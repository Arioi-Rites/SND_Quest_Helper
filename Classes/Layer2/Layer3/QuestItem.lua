local QuestItem = {
    id = -1,
    required = 0,
    GetAmount = function(self)
        return GetItemCount(self.id)
    end,
    AllCollected = function(self)
        return (self:GetAmount() >= self.required)
    end
}

Utility.Object.Inherit(QuestItem, Entity)