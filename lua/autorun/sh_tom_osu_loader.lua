osu = {}

function osu.loadDirectory(dir)
    local fil, fol = file.Find(dir .. "/*", "LUA")
    for k,v in pairs(fol) do
        osu.loadDirectory(dir .. "/" .. v)
    end

    for k,v in ipairs(fil) do
        local dirs = dir .. "/" .. v
        if v:StartWith("cl_") then
            if SERVER then
                AddCSLuaFile(dirs)
            else
                include(dirs)
            end
        elseif v:StartWith("sh_") then
            AddCSLuaFile(dirs)
            include(dirs)
        else
            if SERVER then
                include(dirs)
            end
        end
    end
end

print([[       ________  _______  ____        ____  _____ __  __
  / ____/  |/  / __ \/ __ \      / __ \/ ___// / / /
 / / __/ /|_/ / / / / / / /_____/ / / /\__ \/ / / / 
/ /_/ / /  / / /_/ / /_/ /_____/ /_/ /___/ / /_/ /  
\____/_/  /_/\____/_____/      \____//____/\____/   
Loading GMod-osu! by Tom.bat]])

osu.loadDirectory("tom_osu")

print("GMod-osu! has finished loading!")