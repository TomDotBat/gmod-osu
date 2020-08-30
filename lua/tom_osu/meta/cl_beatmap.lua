
local beatmap = {}
beatmap.__index = beatmap

beatmap.hitObjects = {}

function beatmap:addHitobject(...)
    table.insert(beatmap.hitObjects, osu.hitObject(...))
end

function osu.beatmap()
    return setmetatable({}, beatmap)
end
