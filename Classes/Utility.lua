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
        end,
        InheritMultiple = function(...)
            local combinedClass = {}
            for _, baseClass in ipairs({...}) do
                for k, v in pairs(baseClass) do
                    -- Only copy the method if it doesn't already exist in the combinedClass
                    -- This means the first class will retain all fields, every class after will only retain it's delta to the collective
                    -- of all classes merged before it.
                    if combinedClass[k] == nil then
                        combinedClass[k] = v
                    end
                end
            end
            return combinedClass
        end
    },
    log = function(text)
        yield("/e " .. tostring(text))
    end
}