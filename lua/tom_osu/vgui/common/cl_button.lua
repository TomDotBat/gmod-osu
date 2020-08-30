
local PANEL = {} --I really hate the bulk of the DButton element so here's my much cleaner version with support for circles

AccessorFunc(PANEL, "bIsCircular", "IsCircular", FORCE_BOOL)
AccessorFunc(PANEL, "bIsToggle", "IsToggle", FORCE_BOOL)
AccessorFunc(PANEL, "bToggle", "Toggle", FORCE_BOOL)

function PANEL:Init()
    self:SetIsToggle(false)
    self:SetToggle(false)
    self:SetIsCircular(false)

    self:SetMouseInputEnabled(true)
    self:SetCursor("hand")
end

local sqrt = math.sqrt
local min = math.min

function PANEL:TestHover(x, y) --Taken from the wiki to save time :) - https://wiki.facepunch.com/gmod/PANEL:TestHover
    if not self:GetIsCircular() then return end

    x, y = self:ScreenToLocal(x, y)
    local w, h = self:GetWide(), self:GetTall()
    return (sqrt((x - w / 2) ^ 2 + (y - h / 2) ^ 2)) < min(w, h) / 2
end

function PANEL:DoToggle()
    if not self:GetIsToggle() then return end

    self:SetToggle(not self:GetToggle())
    self:OnToggled(self:GetToggle())
end

function PANEL:OnMousePressed(mouseCode)
    if not self:IsEnabled() then return end

    self:MouseCapture(true)
    self.Depressed = true
    self:OnPressed(mouseCode)
end

function PANEL:OnMouseReleased(mouseCode)
    self:MouseCapture(false)

    if not self:IsEnabled() then return end

    if self.Depressed then
        self.Depressed = nil
        self:OnReleased(mouseCode)
    end

    if not self.Hovered then return end

    self.Depressed = true

    if mouseCode == MOUSE_RIGHT then
        self:DoRightClick()
    elseif mouseCode == MOUSE_LEFT then
        self:DoClick()
    elseif mouseCode == MOUSE_MIDDLE then
        self:DoMiddleClick()
    end

    self.Depressed = nil
end

function PANEL:IsDown() return self.Depressed end
function PANEL:OnPressed(mouseCode) end
function PANEL:OnReleased(mouseCode) end
function PANEL:OnToggled(enabled) end
function PANEL:DoClick() self:DoToggle() end
function PANEL:DoRightClick() end
function PANEL:DoMiddleClick() end

vgui.Register("osu.button", PANEL, "Panel")