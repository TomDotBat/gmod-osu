
local hitObject = {}
hitObject.__index = hitObject

--https://osu.ppy.sh/help/wiki/osu!_File_Formats/Osu_(file_format)#hit-objects
--Hit object syntax: x,y,time,type,hitSound,objectParams,hitSample

osu.accessorFunc(hitObject, "nX", "X", FORCE_NUMBER) --x (Integer) and y (Integer): Position in osu! pixels of the object.
osu.accessorFunc(hitObject, "nY", "Y", FORCE_NUMBER)

osu.accessorFunc(hitObject, "nTime", "Time", FORCE_NUMBER) --(Integer): Time when the object is to be hit, in milliseconds from the beginning of the beatmap's audio.

osu.accessorFunc(hitObject, "nHitSound", "HitSound", FORCE_NUMBER) --(Integer): Bit flags indicating the hitsound applied to the object. See the hitsounds section.

osu.accessorFunc(hitObject, "nType", "Type", FORCE_NUMBER) --(Integer): Bit flags indicating the type of the object. See the type section.

osu.accessorFunc(hitObject, "sParams", "Params", FORCE_STRING) --(Comma-separated list): Extra parameters specific to the object's type.

osu.accessorFunc(hitObject, "sHitSample", "HitSample", FORCE_STRING) --(Colon-separated list): Information about which samples are played when the object is hit. It is closely related to hitSound; see the hitsounds section. If it is not written, it defaults to 0:0:0:0:.

function osu.hitObject(x, y, time, type, hitSound, objectParams, hitSample)
    local obj = setmetatable({}, hitObject)

    obj:setX(x)
    obj:setY(y)

    obj:setTime(time)

    obj:setHitSound(hitSound)

    obj:setParams(objectParams)

    obj:setHitSample(hitSample or "0:0:0:0:")

    return obj
end
