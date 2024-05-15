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
            if self:GetZone() == Zone.NAMEtoID[desiredZone] then
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
    WaitForCastToEnd = function ()
        repeat
            Utility.Wait.min()
        until not IsPlayerCasting()
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
    EnsureZone = function(self, desiredZone)
        if not self:CheckIfInZone(desiredZone) then
            Utility.log("Currently in zone " .. Zone.IDtoNAME[self:GetZone()] .. ", desired zone is " .. desiredZone .. "; Teleporting.")
            self:Teleport(desiredZone)
        end
    end
}