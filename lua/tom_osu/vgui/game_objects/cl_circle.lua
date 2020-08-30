
local PANEL = {}

function PANEL:Init()
    self:SetIsCircular(true)

    self.Color = ColorRand()
end

function PANEL:Paint(w, h)
    draw.RoundedBox(w, 0, 0, w, w, self.Color)
end

vgui.Register("osu.circle", PANEL, "osu.button")