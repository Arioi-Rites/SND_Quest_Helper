local Entity = {
	name = "Undefined",
	position = {X = 0 , Y = 0 , Z = 0 },
	zone = "Default",
	notApproachable = false,

	Target = function(self)
		yield("/target " .. self.name)
	end,
	CheckReachable = function(self, required)
		if not (GetTargetName() == self.name) then
			self:Target() -- Don't know if this sends data to the server if it targets something that is already targeted, better not
		end
		if GetTargetName() == self.name and GetDistanceToTarget() < 7 then
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
	GetPos = function(self, reach)
		if (self:CheckReachable()) then
			return {
				X = GetTargetRawXPos(),
				Y = GetTargetRawYPos(),
				Z = GetTargetRawZPos()
			}
		else
			if (reach) then
				Utility.log("Target not found! Stopping script")
				yield("/snd stop")
			end
			return self.position
		end
	end,
	Interact = function(self)
		yield("/pinteract")
	end
}