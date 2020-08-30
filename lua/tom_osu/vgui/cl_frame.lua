
local PANEL = {}

function PANEL:Init()
    self:Dock(FILL)
    self:MakePopup()

    local map = osu.readBeatmap("gmod-osu/test.osu")

    for k,v in ipairs(map.hitObjects) do
        timer.Simple(v:getTime() / 1000, function()
            if not IsValid(self) then return end
            self:SpawnCircle(v:getX(), v:getY())
        end)
    end

    timer.Simple(0, function()
        surface.PlaySound("../data/gmod-osu/song1.mp3")
    end)

    self.Circles = {}
end

function PANEL:OsuPixelToReal(x, y)

end

local circleSize = 32

function PANEL:SpawnCircle(x, y)
    local circle = vgui.Create("osu.circle", self)

    circle:SetSize(circleSize, circleSize)
    circle:SetPos(x - circleSize / 2, y - circleSize / 2)

    --circle:SetAlpha(0)
    circle:AlphaTo(255, .25)

    timer.Simple(.25, function()
        if not IsValid(circle) then return end
        circle:AlphaTo(0, .25, 0, function()
            if not IsValid(circle) then return end
            circle:Remove()
        end)
    end)

    table.insert(self.Circles, circle)
end

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, color_black)
end

vgui.Register("osu.frame", PANEL, "EditablePanel")

if not IsValid(LocalPlayer()) then return end

if IsValid(osu.frame) then
    osu.frame:Remove()
end

osu.frame = vgui.Create("osu.frame")