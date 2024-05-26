-- @depends Utility.lua

Dialogue = {
    SelectYes = function()
        yield("/click select_yes")
        Utility.Wait.veryShort()
    end
}