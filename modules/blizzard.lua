--[[   ____    ______
      /\  _`\ /\__  _\   __
 __  _\ \ \/\_\/_/\ \/ /_\ \___
/\ \/'\\ \ \/_/_ \ \ \/\___  __\
\/>  </ \ \ \L\ \ \ \ \/__/\_\_/
 /\_/\_\ \ \____/  \ \_\  \/_/
 \//\/_/  \/___/    \/_/

 [=====================================]
 [  Author: Dandraffbal-Stormreaver US ]
 [  xCT+ Version 4.x.x                 ]
 [  ©2020. All Rights Reserved.        ]
 [====================================]]

-- Dont do anything for Legion
--local build = select(4, GetBuildInfo())
--if build >= 70000 then return end


-- TODO: Fix this up

local ADDON_NAME, addon = ...
local x = addon.engine
local L = addon.L
local LSM = LibStub("LibSharedMedia-3.0");

-- Intercept Messages Sent by other Add-Ons that use CombatText_AddMessage
hooksecurefunc('CombatText_AddMessage', function(message, scrollFunction, r, g, b, displayType, isStaggered)
  if not x.db.profile.blizzardFCT.enableFloatingCombatText then
    local lastEntry = COMBAT_TEXT_TO_ANIMATE[ #COMBAT_TEXT_TO_ANIMATE ]
    CombatText_RemoveMessage(lastEntry)
    x:AddMessage("general", message, {r, g, b})
  end
end)

local fsTitle, configButton
x.UpdateBlizzardOptions = function() --[[ Nothing to see here, for now... ]] end

if InterfaceOptionsCombatPanel then
  InterfaceOptionsCombatPanel:HookScript('OnShow', function(self)
    if not fsTitle then
      -- Show Combat Options Title
      fsTitle = self:CreateFontString(nil, "OVERLAY")
      fsTitle:SetTextColor(1.00, 1.00, 1.00, 1.00)
      fsTitle:SetFontObject(GameFontHighlightLeft)
      fsTitle:SetText(L["|cff60A0FF(Now Controlled by |cffFFFF00xCT+|cff60A0FF)"])
      fsTitle:SetPoint("LEFT", InterfaceOptionsCombatPanelEnableFloatingCombatText, "RIGHT", 0, -16)
    end

    if not configButton then
      -- Create a button to delete profiles
      configButton = CreateFrame("Button", nil, self, "UIPanelButtonTemplate")
      configButton:ClearAllPoints()
      configButton:SetPoint("TOPLEFT", InterfaceOptionsCombatPanelEnableFloatingCombatText, "BOTTOMLEFT", 24, -16)
      configButton:SetSize(160, 28)
      configButton:SetText(L["Configure in xCT+"])
      configButton:Show()
      configButton:SetScript("OnClick", function(self)
        InterfaceOptionsFrame_OnHide()
        HideUIPanel(GameMenuFrame)
        x:ShowConfigTool("FloatingCombatText")
      end)
    end

    if not InterfaceOptionsCombatPanel.xCTEnabled then
      local oldText = InterfaceOptionsCombatPanelEnableFloatingCombatTextText:GetText()
      InterfaceOptionsCombatPanelEnableFloatingCombatText:Disable()
      InterfaceOptionsCombatPanel.xCTEnabled = true

      -- -- InterfaceOptionsCombatPanelSpellAlertOpacitySlider:ClearAllPoints()
      -- -- InterfaceOptionsCombatPanelSpellAlertOpacitySlider:SetPoint("TOPLEFT", configButton, "BOTTOMLEFT", 24, -32)
  	InterfaceOptionsCombatPanelCombatTextFloatModeDropDown:ClearAllPoints()
  	InterfaceOptionsCombatPanelCombatTextFloatModeDropDown:SetPoint("TOPLEFT", configButton, "BOTTOMLEFT", 0, -20)
  	-- InterfaceOptionsCombatPanelEnableCombatDamageText:Disable()
  	-- InterfaceOptionsCombatPanelEnableCombatDamageText:ClearAllPoints()
  	-- InterfaceOptionsCombatPanelEnableCombatDamageText:SetPoint("TOPLEFT", configButton, "BOTTOMLEFT", 224, -32)
    end
  end)
elseif SettingsPanel and (EventRegistry and EventRegistry.RegisterCallback) then
  EventRegistry:RegisterCallback("Settings.CategoryChanged",function(ownerID, ...)
    local category = ...
    if category:GetName() == _G.COMBAT then
      local defaultsBtn = SettingsPanel.Container.SettingsList.Header.DefaultsButton
      local frmStrata,frmLevel
      if defaultsBtn then
        frmStrata = defaultsBtn:GetFrameStrata()
        frmLevel = defaultsBtn:GetFrameLevel()
      else
        return
      end
      if not configButton then
        -- Create a button to delete profiles
        configButton = CreateFrame("Button", "xCT_Plus_Blizzard_Button", SettingsPanel, "UIPanelButtonTemplate")
        configButton:ClearAllPoints()
        configButton:SetPoint("RIGHT", defaultsBtn, "LEFT", -20, 0)
        configButton:SetSize(150, 24)
        configButton:SetText(L["Configure in xCT+"])
        configButton:SetScript("OnClick", function(self)
          HideUIPanel(SettingsPanel)
          HideUIPanel(GameMenuFrame)
          x:ShowConfigTool("FloatingCombatText")
        end)
      end
      configButton:SetFrameStrata(frmStrata)
      configButton:SetFrameLevel(frmLevel + 1)
      configButton:Show()
    else
      if configButton then
        configButton:Hide()
      end
    end
  end)
end

function x:UpdateBlizzardFCT()
  if self.db.profile.blizzardFCT.enabled then
    DAMAGE_TEXT_FONT = self.db.profile.blizzardFCT.fontName

    -- Not working
		--  LSM:Fetch("font", self.db.profile.blizzardFCT.font)
    --COMBAT_TEXT_HEIGHT = self.db.profile.blizzardFCT.fontSize
    --CombatTextFont:SetFont(self.db.profile.blizzardFCT.font, self.db.profile.blizzardFCT.fontSize, self.db.profile.blizzardFCT.fontOutline)
  end

  -- Turn off Blizzard's Combat Text
  if not x.db.profile.blizzardFCT.enableFloatingCombatText then
    CombatText:UnregisterAllEvents()
    CombatText:SetScript("OnLoad", nil)
    CombatText:SetScript("OnEvent", nil)
    CombatText:SetScript("OnUpdate", nil)
  end
end

-- Interface - Addons (Ace3 Blizzard Options)
x.blizzardOptions = {
  name = L["|cffFFFF00Combat Text - |r|cff60A0FFPowered By |cffFF0000x|r|cff80F000CT|r+|r"],
  handler = x,
  type = 'group',
  args = {
    showConfig = {
      order = 1,
      type = 'execute',
      name = L["Show Config"],
      func = function()
        if _G.InterfaceOptionsFrame_OnHide then
          InterfaceOptionsFrame_OnHide();
        elseif SettingsPanel.Close then
          HideUIPanel(SettingsPanel);
        end
        HideUIPanel(GameMenuFrame);
        x:ShowConfigTool();
      end,
    },
  },
}
