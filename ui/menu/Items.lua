--[[
--Created Date: Sunday June 19th 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Sunday June 19th 2022 6:28:11 pm
-------
--Copyright (c) 2022 MFA Concept, All Rights Reserved.
--This file is part of MFA Concept project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

---@class _Items
_Items = {}

---@return _Items
function _Items:new()
    local self = {}
    setmetatable(self, {__index = _Items})

    return self
end

---@type _Items
Items = _Items:new()