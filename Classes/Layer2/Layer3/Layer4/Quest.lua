local Quest = {
	name = "Undefined",
	id = -1,
	order = 0,
	prerequisites = {-1}, -- These are QuestIDs
	requiredLevel = 999,
	QuestItems = {},

	Flags = {
		prereqParsed = false
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

	ParseQuestItems = function(self)
		for _, item in pairs(self.QuestItems) do
			Utility.Object.Inherit(item, QuestItem)
		end
	end,

	PreExecute = function(self)
		if not self.Flags.prereqParsed then
			if not self:CheckPrerequisites() then
				Utility.log("Prerequisites for quest \"" .. self.name .. "\" not met. Stopping execution.")
				return false
			elseif not self:CheckIfPlayerLevelEnough() then
				Utility.log("Required level for quest \"" .. self.name .. "\" not met. Stopping execution. Current level " .. GetLevel() .. " Required level " .. self.requiredLevel)
				return false
			end
			self:ParseQuestItems()
			self.Flags.prereqParsed = true
		end
		return true
	end,

	SequenceLogic = function(self)
		return
	end,

	Execute = function(self)
        if not self:PreExecute() then
            return  false
        end

        while not self:GetComplete() do
			Utility.log("Executing \"" .. self.name .. "\" with sequence " .. self:GetSequence())
            if not self:SequenceLogic() then
                return false
            end
        end
        return true
    end
}