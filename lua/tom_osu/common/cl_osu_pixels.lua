
local scrW, scrH = ScrW, ScrH
local max = math.max

function osu.osuPixelsToReal(value)
    return max(value * (scrH() / 480), 1)
end

local unpack = unpack
local cachedBounds, lastRes

function osu.getPlayAreaBounds() --512x384
    if lastRes and lastRes == scrH() then
        return unpack(cachedBounds)
    end

    lastRes = scrH()

    local w, h = osu.osuPixelsToReal(512), osu.osuPixelsToReal(384)
    cachedBounds = {scrW() / 2 - w / 2, scrH() / 2 - h / 2, w, h}

    return unpack(cachedBounds)
end

function osu.getCircleSize(cs) --Credit to clayton - https://osu.ppy.sh/community/forums/topics/311844?start=4282387
    return 109 - 9 * cs
end