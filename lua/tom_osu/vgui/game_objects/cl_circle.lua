
local PANEL = {}

AccessorFunc(PANEL, "nFullyApproachedTime", "FullyApproachedTime", FORCE_NUMBER)

function PANEL:Init()
    self:SetIsCircular(true)
    self:NoClipping(true)

    self.Color = ColorRand()
end

local curTime = UnPredictedCurTime

function PANEL:SetFullApproachTime(time)
    self.nFullyApproachedTime = time
    self.nApproachTime = time - curTime()
end

function PANEL:GetApproachProgress()
    return (self.nFullyApproachedTime - curTime()) / self.nApproachTime
end

function PANEL:Paint(w, h)
    local approachProg = self:GetApproachProgress()
    print(approachProg)
    if approachProg > 0 then
        local center = h / 2
        draw.NoTexture()
        --draw.Arc(center, center, center + approachProg * h, osu.osuPixelsToReal(2), 0, 360, 10, color_white)
        --osu.drawUncachedArc(center, center, approachProg * h * 2, osu.osuPixelsToReal(2), 0, 360, 10, color_white)
        print("drawing")
    end

    draw.RoundedBox(h, 0, 0, h, h, self.Color)
end

vgui.Register("osu.circle", PANEL, "osu.button")