--[[
	Name: Minecraft
	Filename: utils.lua
	Authors: Sam@ke, Jusonex, ZuluTangoDelta, 50p
--]]

-- ############# mainOutput ############## --
function mainOutput(text)
	if (text) then
		if (string.find(text, "CLIENT", 1, true)) then
			outputChatBox("#CCFF00 INFO >> #FFFF99" .. text, 255, 255, 255, true)
		elseif (string.find(text, "SERVER", 1, true)) then
			outputChatBox("#CCFF00 INFO >> #FFCC99" .. text, root, 255, 255, 255, true)
		elseif (string.find(text, "FAIL", 1, true)) then
			outputChatBox("#FF2222 INFO >> #FF0000" .. text, 255, 255, 255, true)
		else
			outputDebugString(text, 3)
		end
	else
		outputChatBox("mainOutput called without parameter!", 255, 255, 255, true)
	end
end


-- ############# getAttachedPosition ############## -- 
function getAttachedPosition(x, y, z, rx, ry, rz, distance, angleAttached, height)
 
    local nrx = math.rad(rx);
    local nry = math.rad(ry);
    local nrz = math.rad(angleAttached - rz);
    
    local dx = math.sin(nrz) * distance;
    local dy = math.cos(nrz) * distance;
    local dz = math.sin(nrx) * distance;
    
    local newX = x + dx;
    local newY = y + dy;
    local newZ = (z + height) - dz;
    
    return newX, newY, newZ;
end


-- ############# findRotation ############## -- 
function findRotation(x1, y1, x2, y2)
  local t = -math.deg(math.atan2(x2 - x1, y2 - y1))
  if t < 0 then t = t + 360 end;
  return t;
end


-- ############# getDistanceRotation ############## -- 
function getDistanceRotation(x, y, dist, angle)
  local a = math.rad(90 - angle)
  local dx = math.cos(a) * dist
  local dy = math.sin(a) * dist
  
  return x + dx, y + dy
end


-- ############# removeHEXColorCode ############## -- 
function removeHEXColorCode(text)
    return text:gsub('#%x%x%x%x%x%x', '')
end


-- ############# isElementMoving ############## -- 
function isElementMoving(theElement)
    if (isElement(theElement)) then
        local x, y, z = getElementVelocity(theElement)
        return x ~= 0 or y ~= 0 or z ~= 0
    end
 
    return nil
end


-- ############# tableSort ############## -- 
function tableSort(myTable, myColumn, sortUp)
    if (not myColumn) then
        myColumn = 1
    end
	
    if (myTable) and (#myTable > 1) then
        for i = 1, #myTable, 1 do
            for j = 2, #myTable, 1 do
                if (sortUp == true) then
                    if(myTable[j][myColumn] > myTable[j-1][myColumn]) then
                        temp = myTable[j-1]
                        myTable[j-1] = myTable[j]
                        myTable[j] = temp
                   end
               else
                   if(myTable[j][myColumn] < myTable[j-1][myColumn]) then
                        temp = myTable[j-1]
                        myTable[j-1] = myTable[j]
                        myTable[j] = temp
                    end
                end
            end
        end
    end
	
    return myTable
end


-- ############# math.round ############## -- 
function math.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end


-- ############# getCameraRotation ############## -- 
function getCameraRotation ()
	local px, py, pz, lx, ly, lz = getCameraMatrix()
	local rotz = 6.2831853071796 - math.atan2 ( ( lx - px ), ( ly - py ) ) % 6.2831853071796
 	local rotx = math.atan2 ( lz - pz, getDistanceBetweenPoints2D ( lx, ly, px, py ) )
	--Convert to degrees
	rotx = math.deg(rotx)
	rotz = -math.deg(rotz)
	
 	return rotx, 180, rotz
end


-- ############# dxDrawCircle3D ############## -- 
function dxDrawCircle3D(x, y, z, radius, segments, color, width)
    segments = segments or 16
    color = color or tocolor(255, 255, 0, 255)
    width = width or 1
    local segAngle = 360 / segments
    local fX, fY, tX, tY
    for i = 1, segments do
        fX = x + math.cos(math.rad(segAngle * i)) * radius
        fY = y + math.sin(math.rad(segAngle * i)) * radius
        tX = x + math.cos(math.rad(segAngle * (i+1))) * radius
        tY = y + math.sin(math.rad(segAngle * (i+1))) * radius
        dxDrawLine3D(fX, fY, z, tX, tY, z, color, width)
		dxDrawLine3D(x, y, z, tX, tY, z, color, width)
    end
end


-- ############# getFPS ############## -- 
local clientFpsVar = 0
local clientFpsStartTick = false
local clientFpsCurrentTick = 0

function getFPS()
    
    if not (clientFpsStartTick) then
        clientFpsStartTick = getTickCount()
    end
        
    clientFpsVar = clientFpsVar + 1
    clientFpsCurrentTick = getTickCount()
        
    if ((clientFpsCurrentTick - clientFpsStartTick) >= 1000) then
        clientFps = clientFpsVar
        
        clientFpsVar = 0
        clientFpsStartTick = false
    end
    
    if (clientFps) then
		return clientFps
    else
        return 0
    end
end


-- ############# getElementSpeed ############## --
function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    assert(getElementType(theElement) == "player" or getElementType(theElement) == "ped" or getElementType(theElement) == "object" or getElementType(theElement) == "vehicle", "Invalid element type @ getElementSpeed (player/ped/object/vehicle expected, got " .. getElementType(theElement) .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end


-- ############# GPS STUFF ############## --

-- ############# getAreaID ############## --
function getAreaID(x, y)
	return math.floor((y + 3000)/750)*8 + math.floor((x + 3000)/750)
end


-- ############# getNodeByID ############## --
function getNodeByID(db, nodeID)
	local areaID = math.floor(nodeID / 65536)
	return db[areaID][nodeID]
end


-- ############# findNodeClosestToPoint ############## --
function findNodeClosestToPoint(db, x, y, z)
	if (db) and (x) and (y) and (z) then
		local areaID = getAreaID(x, y)
		local minDist, minNode
		local nodeX, nodeY, dist
		
		for id, node in pairs(db[areaID]) do
			nodeX, nodeY = node.x, node.y
			dist = (x - nodeX) * (x - nodeX) + (y - nodeY) * (y - nodeY)
			
			if (not minDist) or (dist < minDist) then
				minDist = dist
				minNode = node
			end
		end
		
		return minNode
	end
	
	return nil
end