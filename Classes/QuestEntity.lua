-- @depends Utility.lua
-- @depends Entity.lua
-- @depends Item.lua

local QuestEntity = {
    requiredItemAmount = 0,
    type = "prog",

    AllCollected = function(self)
        if type == "prog" then
            -- TODO. No idea how to get progress only info yet
            Utility.log("AllCollected type prog not implemented yet")
            return false
        elseif type == "item" then
            return (self:GetAmount() >= self.requiredItemAmount)
        end
    end
}

QuestEntity = Utility.Object.InheritMultiple(QuestEntity, Entity, Item)