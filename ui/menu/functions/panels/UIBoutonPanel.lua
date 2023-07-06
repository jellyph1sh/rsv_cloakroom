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

local TextPanels = {
    Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 32 },
    Text = {
        Left = { X = 8, Y = 10, Scale = 0.25 },
        Right = { X = 8, Y = 10, Scale = 0.25 },
    },
}

---BoutonPanel
---@param LeftText string
---@param RightText string
---@public
function _Panels:BoutonPanel(LeftText, RightText, Index)
    local CurrentMenu = RageUI.CurrentMenu
    if CurrentMenu ~= nil then
        local leftTextSize = MeasureStringWidth(LeftText)
        if CurrentMenu and (Index == nil or (CurrentMenu.Index == Index)) then
            RenderRectangle(CurrentMenu.X, CurrentMenu.Y + TextPanels.Background.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset + (RageUI.StatisticPanelCount * 32), TextPanels.Background.Width + CurrentMenu.WidthOffset, TextPanels.Background.Height, 0, 0, 0, 170)
            RenderText(LeftText or "", CurrentMenu.X + TextPanels.Text.Left.X, (RageUI.StatisticPanelCount * 30) + CurrentMenu.Y + TextPanels.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, TextPanels.Text.Left.Scale, 245, 245, 245, 255, 0)
            RenderText(RightText or "", CurrentMenu.X + TextPanels.Background.Width + CurrentMenu.WidthOffset - leftTextSize, (RageUI.StatisticPanelCount * 30) + CurrentMenu.Y + TextPanels.Text.Left.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, 0, TextPanels.Text.Left.Scale, 245, 245, 245, 255, 2)
            RageUI.StatisticPanelCount = RageUI.StatisticPanelCount + 1
        end
    end
end