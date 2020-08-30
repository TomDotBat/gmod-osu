
local toString, toNumber, toBool = tostring, tonumber, tobool

function osu.accessorFunc(tbl, varName, name, forceType) --Edit of AccessorFunc but using camelCase - https://github.com/Facepunch/garrysmod/blob/master/garrysmod/lua/includes/util.lua#L178
    tbl["get" .. name] = function(self) return self[varName] end

    if forceType == FORCE_STRING then
        tbl["set" .. name] = function(self, val) self[varName] = toString(val) end
        return
    end

    if forceType == FORCE_NUMBER then
        tbl["set" .. name] = function(self, val) self[varName] = toNumber(val) end
        return
    end

    if forceType == FORCE_BOOL then
        tbl["set" .. name] = function(self, val) self[varName] = toBool(val) end
        return
    end

    tbl["set" .. name] = function(self, val) self[varName] = val end
end