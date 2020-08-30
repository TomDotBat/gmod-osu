
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

    --surface.PlaySound("../data/gmod-osu/music.mp3")

    self.Circles = {}
    self.Shadows = {}
    self.HitCount = 0
end

local curTime = UnPredictedCurTime

function PANEL:SpawnCircle(x, y)
    local circle = vgui.Create("osu.circle", self)

    circle:SetFullApproachTime(curTime() + .25)

    circle:SetSize(self.CircleSize, self.CircleSize)

    local halfCircle = self.CircleSize / 2
    circle:SetPos(self.PlayAreaBounds[1] + (osu.osuPixelsToReal(x) - halfCircle), self.PlayAreaBounds[2] + (osu.osuPixelsToReal(y) - halfCircle))

    circle:AlphaTo(255, .25)

    circle.DoClick = function(s)
        osu.log("Hit")
        self.HitCount = self.HitCount + 1

        s:Remove()
        self:AddShadow(s.x, s.y, s.Color)
    end

    timer.Simple(.25, function()
        if not IsValid(circle) then return end
        circle:AlphaTo(0, .25, 0, function()
            if not IsValid(circle) then return end
            circle:Remove()
        end)
    end)

    table.insert(self.Circles, circle)
end

function PANEL:AddShadow(x, y, col)
    table.insert(self.Shadows, {
        x = x,
        y = y,
        color = color_white,
        num = 1,
        alpha = 1
    })
end

function PANEL:PerformLayout(w, h)
    self.CircleSize = osu.osuPixelsToReal(osu.getCircleSize(5))
    self.PlayAreaBounds = {osu.getPlayAreaBounds()}
end

local lerp = Lerp

local playAreaCol = Color(20, 20, 20)

function PANEL:Paint(w, h)
    draw.RoundedBox(0, 0, 0, w, h, color_black)
    draw.RoundedBox(0, self.PlayAreaBounds[1], self.PlayAreaBounds[2], self.PlayAreaBounds[3], self.PlayAreaBounds[4], playAreaCol)

    for k,v in ipairs(self.Shadows) do
        surface.SetAlphaMultiplier(v.alpha)
        draw.RoundedBox(self.CircleSize, v.x, v.y, self.CircleSize, self.CircleSize, v.color)

        v.alpha = lerp(FrameTime(), v.alpha, 0)
        if v.alpha > .001 then table.remove(self.Shadows, k) end
    end

    surface.SetAlphaMultiplier(1)


    draw.SimpleText(self.HitCount, "DermaLarge", 0, 0, color_white)
end

vgui.Register("osu.frame", PANEL, "EditablePanel")

if not IsValid(LocalPlayer()) then return end

if IsValid(osu.frame) then
    osu.frame:Remove()
end

osu.frame = vgui.Create("osu.frame")