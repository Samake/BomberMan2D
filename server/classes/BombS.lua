--[[
	Name: BomberMan2D
	Filename: BombS.lua
	Authors: Sam@ke
--]]

BombS = {}

function BombS:constructor(parent, bombSettings)

	self.bombManager = parent
	
	self.id = bombSettings.id
	self.owner = bombSettings.player
	self.element = createElement("BM2DBOMB", self.id)
	
	self.lifeTime = 3000
	self.startTime = getTickCount()
	
	self.isExploded = "false"
	
	self.element:setData("BM2DBOMBPOSITION", self.id, true)

	mainOutput("Bomb " .. self.id .. " was loaded.")
end


function BombS:update()
	self.currentTime = getTickCount()
	
	if ((self.currentTime - self.startTime) > self.lifeTime) then
		if (self.isExploded == "false") then
			self.bombManager:deleteBomb(self.id)
			self.isExploded = "true"
		end
	end
end


function BombS:destoyBlocks()
	self.offSetX = string.sub(self.id, 1, 2)
	self.offSetY = string.sub(self.id, 3, 4)
	
	local possibleExplosions = {}
	
	if (self.bombManager:isDestroyable(self.id) == "true") then
		table.insert(possibleExplosions, self.id)
	end
	
	if (self.bombManager:isDestroyable(self:getIDLeft(1)) == "true") then
		table.insert(possibleExplosions, self:getIDLeft(1))
		
		if (self.bombManager:isDestroyable(self:getIDLeft(2)) == "true") then
			table.insert(possibleExplosions, self:getIDLeft(2))
		end
	end

	
	if (self.bombManager:isDestroyable(self:getIDRight(1)) == "true") then
		table.insert(possibleExplosions, self:getIDRight(1))
		
		if (self.bombManager:isDestroyable(self:getIDRight(2)) == "true") then
			table.insert(possibleExplosions, self:getIDRight(2))
		end
	end
	
	if (self.bombManager:isDestroyable(self:getIDUp(1)) == "true") then
		table.insert(possibleExplosions, self:getIDUp(1))
		
		if (self.bombManager:isDestroyable(self:getIDUp(2)) == "true") then
			table.insert(possibleExplosions, self:getIDUp(2))
		end
	end
	
	if (self.bombManager:isDestroyable(self:getIDDown(1)) == "true") then
		table.insert(possibleExplosions, self:getIDDown(1))
		
		if (self.bombManager:isDestroyable(self:getIDDown(2)) == "true") then
			table.insert(possibleExplosions, self:getIDDown(2))
		end
	end
	
	triggerEvent("BM2DCREATEEXPLOSIONS", root, possibleExplosions)
end


function BombS:getIDLeft(dist)
	if (dist) then
		return string.format("%02d", tonumber(self.offSetX) - dist) .. string.format("%02d", self.offSetY)
	end
	
	return nil
end


function BombS:getIDRight(dist)
	if (dist) then
		return string.format("%02d", tonumber(self.offSetX) + dist) .. string.format("%02d", self.offSetY)
	end
	
	return nil
end


function BombS:getIDUp(dist)
	if (dist) then
		return string.format("%02d", self.offSetX) .. string.format("%02d", tonumber(self.offSetY) - dist)
	end
	
	return nil
end


function BombS:getIDDown(dist)
	if (dist) then
		return string.format("%02d", self.offSetX) .. string.format("%02d", tonumber(self.offSetY) + dist)
	end
	
	return nil
end


function BombS:destructor()
	self:destoyBlocks()

	if (self.element) then
		self.element:destroy()
		self.element = nil
	end

	mainOutput("Bomb " .. self.id .. " was deleted.")
end
