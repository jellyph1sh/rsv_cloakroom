--[[
--Created Date: Monday June 20th 2022
--Author: JustGod
--Made with ❤
-------
--Last Modified: Monday June 20th 2022 4:46:41 pm
-------
--Copyright (c) 2022 MFA Concept, All Rights Reserved.
--This file is part of MFA Concept project.
--Unauthorized using, copying, modifying and/or distributing of this file
--via any medium is strictly prohibited. This code is confidential.
-------
--]]

---@type table
local Heritage = {
    Background = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "mumdadbg", Width = 431, Height = 228 },
    Mum = { Dictionary = "char_creator_portraits", X = 25, Width = 228, Height = 228 },
    Dad = { Dictionary = "char_creator_portraits", X = 195, Width = 228, Height = 228 },
}

---@param Mum number
---@param Dad number
function _Items:Heritage(Mum, Dad)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu then
            Mum = Mum - 1
            Dad = Dad - 1
            if Mum < 0 or Mum > 21 then
                Mum = 0
            end
            if Dad < 0 or Dad > 23 then
                Dad = 0
            end
            if Mum == 21 then
                Mum = "special_female_" .. (tonumber(string.sub(Mum, 2, 2)) - 1)
            else
                Mum = "female_" .. Mum
            end
            if Dad >= 21 then
                Dad = "special_male_" .. (tonumber(string.sub(Dad, 2, 2)) - 1)
            else
                Dad = "male_" .. Dad
            end
            RenderSprite(Heritage.Background.Dictionary, Heritage.Background.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background.Height)
            RenderSprite(Heritage.Dad.Dictionary, Dad, CurrentMenu.X + Heritage.Dad.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Dad.Width, Heritage.Dad.Height)
            RenderSprite(Heritage.Mum.Dictionary, Mum, CurrentMenu.X + Heritage.Mum.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Mum.Width, Heritage.Mum.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end
