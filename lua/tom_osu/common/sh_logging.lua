
local colors = {
    primary = Color(243, 112, 170),
    positive = Color(44, 173, 74),
    negative = Color(173, 44, 59)
}

function osu.log(msg)
    MsgC(colors.primary, msg, "\n")
end

function osu.logSuccess(msg)
    MsgC(colors.positive, msg, "\n")
end

function osu.logError(msg)
    MsgC(colors.negative, msg, "\n")
    debug.Trace()
end