local Utility = {
    Wait = {
        min = function() yield("/wait 0.1") end,
        veryShort = function() yield("/wait 0.5") end,
        short = function() yield("/wait 1") end,
        double = function() yield("/wait 2") end,
        triple = function() yield("/wait 3") end,
        max = function () yield ("/wait 5") end
    },
    Coords = {
        Stringify = function(coords)
            return (coords.X .. " " .. coords.Y .. " " .. coords.Z)
        end
    },
    Object = {
        Inherit = function(obj, base)
            setmetatable(obj, { __index = base })
        end
    },
    Dialogue = {
        SelectYes = function()
            yield("/click select_yes")
            Utility.Wait.veryShort()
        end
    },
    log = function(text)
        yield("/e " .. tostring(text))
    end
}