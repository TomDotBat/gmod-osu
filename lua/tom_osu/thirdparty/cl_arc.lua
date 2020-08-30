
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

-- Draws an arc on your screen.
-- startang and endang are in degrees, 
-- radius is the total radius of the outside edge to the center.
-- cx, cy are the x,y coordinates of the center of the arc.
-- roughness determines how many triangles are drawn. Number between 1-360; 2 or 3 is a good number.
function draw.Arc(cx,cy,radius,thickness,startang,endang,roughness,color)
	surface.SetDrawColor(color)
	surface.DrawArc(surface.PrecacheArc(cx,cy,radius,thickness,startang,endang,roughness))
end

function surface.PrecacheArc(cx,cy,radius,thickness,startang,endang,roughness)
	local triarc = {}
	-- local deg2rad = math.pi / 180
	
	-- Define step
	local roughness = math.max(roughness or 1, 1)
	local step = roughness
	
	-- Correct start/end ang
	local startang,endang = startang or 0, endang or 0
	
	if startang > endang then
		step = math.abs(step) * -1
	end
	
	-- Create the inner circle's points.
	local inner = {}
	local r = radius - thickness
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		-- local rad = deg2rad * deg
		local ox, oy = cx+(math.cos(rad)*r), cy+(-math.sin(rad)*r)
		table.insert(inner, {
			x=ox,
			y=oy,
			u=(ox-cx)/radius + .5,
			v=(oy-cy)/radius + .5,
		})
	end	
	
	-- Create the outer circle's points.
	local outer = {}
	for deg=startang, endang, step do
		local rad = math.rad(deg)
		-- local rad = deg2rad * deg
		local ox, oy = cx+(math.cos(rad)*radius), cy+(-math.sin(rad)*radius)
		table.insert(outer, {
			x=ox,
			y=oy,
			u=(ox-cx)/radius + .5,
			v=(oy-cy)/radius + .5,
		})
	end	
	
	-- Triangulize the points.
	for tri=1,#inner*2 do -- twice as many triangles as there are degrees.
		local p1,p2,p3
		p1 = outer[math.floor(tri/2)+1]
		p3 = inner[math.floor((tri+1)/2)+1]
		if tri%2 == 0 then --if the number is even use outer.
			p2 = outer[math.floor((tri+1)/2)]
		else
			p2 = inner[math.floor((tri+1)/2)]
		end
	
		table.insert(triarc, {p1,p2,p3})
	end
	
	-- Return a table of triangles to draw.
	return triarc
end

function surface.DrawArc(arc) //Draw a premade arc.
	for k,v in ipairs(arc) do
		surface.DrawPoly(v)
	end
end