print("cursorCD: lua loaded")

local anchor = CreateFrame("Frame", "cursorCD_Anchor", UIParent)
anchor:SetSize(6, 6)
anchor:SetPoint("CENTER")

local viewer = _G["UtilityCooldownViewer"]

local function IsEditModeActive()
  return EditModeManagerFrame and EditModeManagerFrame:IsShown()
end

anchor:SetScript("OnUpdate", function(self)

  if not viewer then return end
  if IsEditModeActive() then return end

  local x, y = GetCursorPosition()
  local scale = UIParent:GetEffectiveScale()
  local ux, uy = x / scale, y / scale

  self:ClearAllPoints()
  self:SetPoint("CENTER", UIParent, "BOTTOMLEFT", ux, uy)

  viewer:ClearAllPoints()
  viewer:SetPoint("CENTER", self, "CENTER", 53, 23)
end)