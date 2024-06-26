-- @depends Utility.lua
-- @depends Zone.lua
-- @depends Entity.lua

local Player = {
    GetPos = function(self)
        return {
            X = GetPlayerRawXPos(),
            Y = GetPlayerRawYPos(),
            Z = GetPlayerRawZPos()
        }
    end,
    GetZone = function(self)
        return GetZoneID()
    end,

    CheckIfInZone = function(self, desiredZone)
        if type(desiredZone) == "number" then
            if self:GetZone() == desiredZone then
                return true
            end
        else
            if self:GetZone() == Zone.NAMEtoID[desiredZone].id then
                return true
            end
        end
        return false
    end,
    
    --
    -- Waits
    --
    WaitForAvailable = function(self)
        repeat
            Utility.Wait.min()
        until IsPlayerAvailable()
    end,
    WaitForAbsolutelyAvailable = function(self)
        i = 0
        repeat -- This is for those occasions where things overlap in such a strange way that the former does not suffice
            self:WaitForAvailable()
            Utility.Wait.short()
            i = i + 1
        until i == 3
    end,
    WaitForMoveEnd = function(self)
        repeat
            Utility.Wait.min()
        until not IsMoving()
    end,
    WaitForMoveUntilEntityInReach = function(self, entity)
        repeat
            Utility.Wait.min()
        until entity:CheckReachable() or (not IsMoving())
        yield("/vnav stop")
    end,
    WaitForCastToEnd = function (self)
        repeat
            Utility.Wait.min()
        until not IsPlayerCasting()
    end,
    WaitForCastAndAvailable = function(self)
        self:WaitForCastToEnd()
        self:WaitForAvailable()
    end,
    
    --
    -- Actions
    --

    Interact = function(self, entity)
        entity:Target()
		yield("/interact")
	end,

    --
    -- Teleport
    --
    TP_Aetheryte = function(self, ZoneName)
        if Zone.NAMEtoID[ZoneName].requires then
            self:Teleport(Zone.NAMEtoID[ZoneName].requires)
        end
        yield("/tp " .. ZoneName)
        Utility.Wait.short()
        self:WaitForCastToEnd()
        self:WaitForAvailable()
    end,
    TP_Aethernet = function(self, ZoneName)
        if Zone.NAMEtoID[ZoneName].requires then
            self:Teleport(Zone.NAMEtoID[ZoneName].requires)
        end
        yield("/li " .. ZoneName)
        Utility.Wait.double()
        self:WaitForAvailable()
    end,
    Teleport = function(self, ZoneName)
        local retCode = true
        if Zone.NAMEtoID[ZoneName] == nil then
            Utility.log("Tried to tp to " .. ZoneName .. " which is not defined in Zone.lua")
        end
        if Zone.NAMEtoID[ZoneName].type == "AY" then
            retCode = self:TP_Aetheryte(ZoneName)
        elseif Zone.NAMEtoID[ZoneName].type == "AN" then
            retCode = self:TP_Aethernet(ZoneName)
        else
            Utility.log("Tried to tp to " .. ZoneName .. "but type " .. Zone.NAMEtoID[ZoneName].type .. "defined in Zone.lua is invalid")
            return false
        end
        return retCode
    end,

    --
    -- Movement
    --
    MoveTo = function(self, coords)
        yield("/vnav moveto " .. Utility.Coords.Stringify(coords))
        Utility.Wait.short()
    end,
    MoveUntilEntityInReach = function(self, entity, alwaysUseFallback)
        self:MoveTo(entity:GetPos(alwaysUseFallback))
        self:WaitForMoveUntilEntityInReach(entity)
    end,
    EnsureZone = function(self, desiredZone, mustAlreadyBeThere)
        if not self:CheckIfInZone(desiredZone) then
            if mustAlreadyBeThere then
                Utility.log("Currently in zone " .. Zone.IDtoNAME[self:GetZone()] .. ", desired zone is " .. desiredZone)
                Utility.log("Player MUST be in desired Zone. Stopping script.")
                yield("/snd stop")
            end
            Utility.log("Currently in zone " .. Zone.IDtoNAME[self:GetZone()] .. ", desired zone is " .. desiredZone .. "; Teleporting.")
            self:Teleport(desiredZone)
        end
    end
}