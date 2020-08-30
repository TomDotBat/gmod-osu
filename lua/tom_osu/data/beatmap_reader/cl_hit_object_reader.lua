
local function skipComma(reader)
    local str = reader:Read(1)
    if str == "," then return end

    osu.logError("Failed to read hitobject, expected \",\" at " .. reader:Tell())
    return true
end

function osu.readHitObject(reader, beatmap) --x,y,time,type,hitSound,objectParams,hitSample
    beatmap:addHitobject(unpack(string.Split(reader:ReadLine(), ",")))
    if true then return end
    --local line = string.Split(reader:ReadLine(), ",")
    --if #line < 6 then
    --    osu.logError("Failed to read hitobject, not enough data was specified at: " .. reader:Tell())
    --    return
    --end

    local x = reader:ReadShort()
    if skipComma(reader) then return end
    local y = reader:ReadShort()
    if skipComma(reader) then return end

    local objType = reader:ReadByte()
    if skipComma(reader) then return end

    local hitSound = reader:ReadByte() --Actually a 4 bit int, 8 is the closest we can get
    if skipComma(reader) then return end

    reader:ReadLine()

    beatmap:addHitobject(x, y, time, objType, hitSound, "objectParams", "hitSample")

    print("x", x)
    print("y", y)
    print("time", time)
    print("type", objType)
    print("hitSound", hitSound)
end