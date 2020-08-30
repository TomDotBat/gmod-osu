
local lerp = Lerp
function osu.lerpColor(t, from, to)
    local newCol = Color(0, 0, 0)

    newCol.r = lerp(t, from.r, to.r)
    newCol.g = lerp(t, from.g, to.g)
    newCol.b = lerp(t, from.b, to.b)
    newCol.a = lerp(t, from.a, to.a)

    return newCol
end