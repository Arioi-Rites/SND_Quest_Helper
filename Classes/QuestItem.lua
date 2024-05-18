-- @depends Utility.lua
-- @depends Item.lua

local QuestItem = {
    requiredItemAmount = 0,

    AllCollected = function(self)
        return (self:GetAmount() >= self.requiredItemAmount)
    end
}

Utility.Object.Inherit(QuestItem, Item)