local Utility = {
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
            yield("/wait 1")
        end
    },
    log = function(text)
        yield("/e " .. tostring(text))
    end
}