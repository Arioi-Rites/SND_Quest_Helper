-- @depends Utility.lua

local Entity = {
	name = "Undefined",
	position = {},
	zone = "Default",
	notApproachable = false,
	interactionDistance = 7, -- 7 is the max distance for NPC dialogue

	Target = function(self)
		pcall(function ()
			yield("/target " .. self.name)
		end)
	end,
	CheckTargetable = function(self)
		local currentlyTargeted = (GetTargetName() == self.name)
		if not currentlyTargeted then
			self:Target() -- Don't know if this sends data to the server if it targets something that is already targeted, better not
		end
		return (GetTargetName() == self.name)
	end,
	CheckReachable = function(self,required)
		if not (GetTargetName() == self.name) then
			self:Target() -- Don't know if this sends data to the server if it targets something that is already targeted, better not
		end
		if self:CheckTargetable() and GetDistanceToTarget() < self.interactionDistance then
			return true
		else
			if required then
				Utility.log("Target not found! Stopping script")
				yield("/snd stop")
			else
				return false
			end
		end
	end,
	GetPos = function(self, alwaysUseFallback)
		if not alwaysUseFallback and self:CheckTargetable() then
			return {
				X = GetTargetRawXPos(),
				Y = GetTargetRawYPos(),
				Z = GetTargetRawZPos()
			}
		else
			-- Uses fallback position if not targetable or alwaysUseFallback
			if (not self.position.X or not self.position.Y or not self.position.Z) then
				Utility.log("No valid position for target found! Stopping script")
				yield("/snd stop")
			end

			return self.position
		end
	end
}