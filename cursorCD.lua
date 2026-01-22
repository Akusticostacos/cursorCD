print("cursorCD: lua loaded")

local anchor = CreateFrame("Frame", "cursorCD_Anchor", UIParent)
anchor:SetSize(6, 6)
anchor:SetPoint("CENTER")

-- Debugging
local tex = anchor:CreateTexture(nil, "OVERLAY")
tex:SetAllPoints()
tex:SetColorTexture(1, 1, 1, 1)

local viewer = _G["UtilityCooldownViewer"]

anchor:SetScript("OnUpdate", function(self)
  if not viewer then return end

  local x, y = GetCursorPosition()
  local scale = UIParent:GetEffectiveScale()
  local ux, uy = x / scale, y / scale

  self:ClearAllPoints()
  self:SetPoint("CENTER", UIParent, "BOTTOMLEFT", ux, uy)

  viewer:ClearAllPoints()
  viewer:SetPoint("CENTER", self, "CENTER", 24, -24)
end)
