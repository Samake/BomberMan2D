--[[
	Name: BomberMan2D
	Filename: utils.lua
	Authors: Sam@ke, WiKi
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


-- ############# removeHEXColorCode ############## -- 
function removeHEXColorCode(text)
    return text:gsub('#%x%x%x%x%x%x', '')
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
