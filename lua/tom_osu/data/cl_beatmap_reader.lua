
function osu.readBeatmap(path)
    osu.log("Reading beatmap file: " .. path)

    local reader = file.Open(path, "r", "DATA")
    if not reader then
        osu.logError("Failed to open beatmap file: " .. path)
        return
    end

    local beatmap = osu.beatmap()

    local readingHitObjects = false

    while not reader:EndOfFile() do
        if readingHitObjects then
            osu.readHitObject(reader, beatmap)
        elseif reader:ReadLine() == "[HitObjects]\n" then --We'll just skip to the hitobjects for now
            readingHitObjects = true
        end
    end

    reader:Close()

    osu.logSuccess("Successfully read beatmap file.")
    return beatmap
end

osu.readBeatmap("gmod-osu/test.osu")