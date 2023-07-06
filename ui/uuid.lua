--[[
--Created Date: Thursday June 23rd 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Thursday June 23rd 2022 12:47:24 am
-------
--Copyright (c) 2022 MFA Concept, All Rights Reserved.
--This file is part of MFA Concept project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

local defaultTemplate = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
local random = math.random

local function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end

	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end

	return t
end

local function stringtoCharArray(str)
    local array = {}

    for i = 1, #str do
        array[i] = str:sub(i, i)
    end

    return array
end

local function stringToHexa(str)
    return string.lower(string.format("%X", str))
end

local function numberToHexa(nb)
    return stringToHexa(("%s"):format(nb))
end

if IsDuplicityVersion() then
    math.randomseed(os.time())
end

math.random();math.random();math.random()
math.random();math.random();math.random()
math.random();math.random();math.random()
math.random();math.random();math.random()

---@class TemplateUUID
local TemplateUUID = {}

function TemplateUUID:new(template)
    local self = {}
    setmetatable(self, {__index = TemplateUUID})

    self.template = stringsplit(template or defaultTemplate, "-")
    self.cursor = 0

    return self
end

function TemplateUUID:getCursor()
    return self.cursor
end

function TemplateUUID:resetCursor()
    self.cursor = 0
end

function TemplateUUID:getToken(idx)
    return self.template[idx]
end

function TemplateUUID:getTokenNumber()
    return #self.template
end

function TemplateUUID:getRemainingTokenNumber()
    return self:getTokenNumber() - self:getCursor()
end

function TemplateUUID:getNextToken()
    if self:getRemainingTokenNumber() > 0 then
        self.cursor = self.cursor + 1
        return self:getToken(self.cursor)
    else
        return nil
    end
end

function TemplateUUID:getTemplate()
    return table.concat(self.template, "-")
end


---@class UUID
local _UUID = {}

---@return _UUID
function _UUID:new()
    local self = {}
    setmetatable(self, {__index = _UUID})
    return self
end

function _UUID:getTemplate()
    return self.template
end

function _UUID:__call(pattern)
    return self:generate(pattern)
end

function _UUID:generate(pattern)
    local template = TemplateUUID:new(pattern)
    return string.gsub(template:getTemplate(), '[xy]',
        function (c)
            local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
            return string.format('%x', v)
        end)
end

---
---
---
--- @class UUID
---
--- return a unique UUID using default pattern and replacing 
---
--- @return string
---
function _UUID:unique(pattern)
    local hexa = stringtoCharArray(numberToHexa(os.time(os.date("!*t"))))
    local template = TemplateUUID:new(pattern)
    local token = template:getNextToken()
    local final = nil
    local idx = 0

    while token do
        
        if template:getRemainingTokenNumber() == 0 then
            token = string.gsub(token, '[xy]',
                function(char)
                    idx = idx + 1
                    if char == 'x' and hexa[idx] then
                        return hexa[idx]
                    elseif char == 'x' then
                        return string.format('%x', random(0, 0xf))
                    else
                        return string.format('%x', random(8, 0xb))
                    end
                end)
        else
            token = string.gsub(token, '[xy]',
                function (c)
                    local v = (c == 'x') and random(0, 0xf) or random(8, 0xb)
                    return string.format('%x', v)
                end)
        end
        
        final = final and ("%s-%s"):format(final, token) or token
        token = template:getNextToken()
    end

    return final
end

UUID = _UUID:new()

RageUI.UUID = function(pattern)
    return UUID:generate(pattern)
end
