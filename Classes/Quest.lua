-- @depends Utility.lua
-- @depends QuestEntity.lua
-- @depends QuestItem.lua

local Quest = {
	name = "Undefined",
	id = -1,
	order = 0,
	prerequisites = {-1}, -- These are QuestIDs
	requiredLevel = 999,
	QuestItems = {},
	QuestEntities = {},
	TemporaryNPCs = {},

	Flags = {
		OneTimeChecksDone = false
	},

	GetComplete = function(self)
		return IsQuestComplete(self.id)
	end,
	GetSequence = function(self)
		return GetQuestSequence(self.id)
	end,
	CheckAccepted = function(self)
		return IsQuestAccepted(self.id)
	end,
	CheckIfPlayerLevelEnough = function(self)
		return (self.requiredLevel <=  GetLevel())
	end,

	CheckPrerequisites = function(self)
		for _, prerequisite in ipairs(self.prerequisites) do
			if not IsQuestComplete(prerequisite) then
				return false
			end
		end
		return true
	end,

	ParseQuestEntities = function(self)
		for _, entity in pairs(self.QuestEntities) do
			Utility.Object.Inherit(entity, QuestEntity)
		end
	end,

	ParseQuestItems = function(self)
		for _, item in pairs(self.QuestItems) do
			Utility.Object.Inherit(item, QuestItem)
		end
	end,

	ParseTemporaryNPCs = function(self)
		for _, npc in pairs(self.TemporaryNPCs) do
			Utility.Object.Inherit(npc, Entity)
		end
	end,

	OneTimeChecks = function(self)
		if not self.Flags.OneTimeChecksDone then
			if not self:CheckPrerequisites() then
				Utility.log("Prerequisites for quest \"" .. self.name .. "\" not met. Stopping execution.")
				return false
			elseif not self:CheckIfPlayerLevelEnough() then
				Utility.log("Required level for quest \"" .. self.name .. "\" not met. Stopping execution. Current level " .. GetLevel() .. " Required level " .. self.requiredLevel)
				return false
			end
			self:ParseQuestEntities()
			self:ParseQuestItems()
			self.Flags.OneTimeChecksDone = true
		end
		return true
	end,

	SequenceLogic = function(self)
		return
	end,

	Execute = function(self, goalSequence)
		if not goalSequence then
			goalSequence = 999
		end
		if self:GetComplete() then
			return true
		end
        if not self:OneTimeChecks() then
            return  false
        end

        repeat
			Utility.log("Executing \"" .. self.name .. "\" with sequence " .. self:GetSequence())
            if not self:SequenceLogic() then
                return false
            end
        until (self:GetComplete() or (self:GetSequence() >= goalSequence))
        return true
    end
}