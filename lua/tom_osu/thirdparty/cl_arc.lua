
--https://gist.github.com/theawesomecoder61/d2c3a3d42bbce809ca446a85b4dda754

local setTexture = surface.SetTexture
local setDrawColor = surface.SetDrawColor
local drawPoly = surface.DrawPoly
local abs = math.abs
local rad = math.rad
local cos = math.cos
local sin = math.sin
local floor = math.floor
local insert = table.insert
local ipairs = ipairs

function osu.precacheArc(cx, cy, radius, thickness, startAng, endAng, step)
    local triarc = {}

    if startAng > endAng then
        step = abs(step) * -1
    end

    local inner = {}
    local r = radius - thickness

    for deg = startAng, endAng, step do
        local radians = rad(startAng)
        local ox, oy = cx + (cos(radians) * r), cy + (-sin(radians) * r)

        insert(inner, {
            x = ox,
            y = oy,
            u = (ox - cx) / radius + .5,
            v = (oy - cy) / radius + .5
        })
    end

    local outer = {}

    for deg = startAng, endAng, step do
        local radians = rad(startAng)
        local ox, oy = cx + (cos(radians) * radius), cy + (-sin(radians) * radius)

        insert(outer, {
            x = ox,
            y = oy,
            u = (ox - cx) / radius + .5,
            v = (oy - cy) / radius + .5
        })
    end

    for tri = 1, #inner * 2 do
        local p1, p2, p3
        p1 = outer[floor(tri / 2) + 1]
        p3 = inner[floor((tri + 1) / 2) + 1]

        if tri % 2 == 0 then
            p2 = outer[floor((tri + 1) / 2)]
        else
            p2 = inner[floor((tri + 1) / 2)]
        end

        insert(triarc, {p1, p2, p3})
    end

    return triarc
end

function osu.drawArc(arc)
    for k, v in ipairs(arc) do
        drawPoly(v)
    end
end

local whiteMat = surface.GetTextureID("vgui/white")

function osu.drawUncachedArc(cx, cy, radius, thickness, startAng, endAng, step, color)
    setTexture(whiteMat)
    setDrawColor(color)
    osu.drawArc(osu.precacheArc(cx, cy, radius, thickness, startAng, endAng, step))
end