--[[
--Created Date: Monday June 20th 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Monday June 20th 2022 6:20:00 pm
-------
--Copyright (c) 2022 MFA Concept, All Rights Reserved.
--This file is part of MFA Concept project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

---@class Enum
local enums = {
    __index = function(table, key)
        if rawget(table.enums, key) then
            return key
        end
    end
}

---Enum
---@param t table
---@return Enum
function RageUI.Enum(t)
    local e = { enums = t }
    return setmetatable(e, enums)
end
