print("cursorCD: lua loaded")

local anchor = CreateFrame("Frame", "cursorCD_Anchor", UIParent)
anchor:SetSize(6, 6)
anchor:SetPoint("CENTER")

local CD_viewer = _G["UtilityCooldownViewer"]
local BUFF_viewer = _G["BuffIconCooldownViewer"]

local function IsEditModeActive()
  return EditModeManagerFrame and EditModeManagerFrame:IsShown()
end

local function IsHealer()
  local spec = GetSpecialization()
  if not spec then return false end
  return GetSpecializationRole(spec) == "HEALER"
end

local function AnchorOnUpdate(self)
  if not CD_viewer then return end
  if IsEditModeActive() then return end

  local x, y = GetCursorPosition()
  local scale = UIParent:GetEffectiveScale()
  local ux, uy = x / scale, y / scale

  self:ClearAllPoints()
  self:SetPoint("CENTER", UIParent, "BOTTOMLEFT", ux, uy)

  CD_viewer:ClearAllPoints()
  CD_viewer:SetPoint("CENTER", self, "CENTER", 53, 23)
  BUFF_viewer:ClearAllPoints()
  BUFF_viewer:SetPoint("CENTER", self, "CENTER", 118, 23)
end

local function ApplyRoleState()
  if not CD_viewer then
    CD_viewer = _G["UtilityCooldownViewer"]
    BUFF_viewer = _G["BuffIconCooldownViewer"]
  end
  if IsHealer() then
    anchor:SetScript("OnUpdate", AnchorOnUpdate)
    if CD_viewer then CD_viewer:Show() end
  else
    anchor:SetScript("OnUpdate", nil)
    if CD_viewer then CD_viewer:Hide() end
  end
end

local ev = CreateFrame("Frame")
ev:RegisterEvent("PLAYER_LOGIN")
ev:RegisterEvent("PLAYER_ENTERING_WORLD")
ev:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")

ev:SetScript("OnEvent", ApplyRoleState)

ApplyRoleState()
print(BUFF_viewer)