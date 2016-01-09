--[[
	Name: BomberMan2D
	Filename: MapManagerS.lua
	Authors: Sam@ke
--]]

MapManagerS = {}

function MapManagerS:constructor(parent)
	mainOutput("MapManagerS was loaded.")
	
	self.mainClass = parent
	self.gameState = "idle"
	self.isMapStarted = "false"
	self.currentMap = nil
	
	self.m_SetGameState = bind(self.setGameState, self)
	addEvent("onGameStateChanged", true)
	addEventHandler("onGameStateChanged", root, self.m_SetGameState)
	
	self.m_CreateExplosions = bind(self.createExplosions, self)
	addEvent("BM2DCREATEEXPLOSIONS", true)
	addEventHandler("BM2DCREATEEXPLOSIONS", root, self.m_CreateExplosions)
	
	self.allMaps = getBomberManMaps()
end


function MapManagerS:setGameState(state)
	if (state) then
		self.gameState = state
	end
end


function MapManagerS:update()
	if (self.gameState == "ingame") then
		if (self.isMapStarted == "false") then
			
			self:startMap(self:getRandomMap())
			self.isMapStarted = "true"
		end
	end
end


function MapManagerS:startMap(map)
	if (map) then
		
		local newMap = map
		local mapSettings = {}
		mapSettings.name = map.name
		mapSettings.size = map.size
		mapSettings.skyColor = map.skyColor
		mapSettings.textureSet = map.textureSet
		
		self.currentMap = mapSettings
		
		for i = 1, mapSettings.size do
			for j = 1, mapSettings.size do
				local id = string.format("%02d", j) .. string.format("%02d", i)
				
				if (not self.currentMap[id]) then
					if (newMap[i][j] == "W") then
						self.currentMap[id] = {id = id, offSetX = j, offSetY = i, isTile = "true", type = "wall", isBlocked = "true", isSpawn = "false", destroyable = "false"}
					elseif (newMap[i][j] == "S") then
						self.currentMap[id] = {id = id, offSetX = j, offSetY = i, isTile = "true", type = "spawn", isBlocked = "false", isSpawn = "true", destroyable = "true", inUse = "false"}
					elseif (newMap[i][j] == "B") then
						self.currentMap[id] = {id = id, offSetX = j, offSetY = i, isTile = "true", type = "block", isBlocked = "true", isSpawn = "false", destroyable = "true", destroyed = "false"}
					elseif (newMap[i][j] == "F") then
						self.currentMap[id] = {id = id, offSetX = j, offSetY = i, isTile = "true", type = "floor", isBlocked = "false", isSpawn = "false", destroyable = "true", destroyed = "false"}
					end
					
					self.currentMap[id].color = {r = 255, g = 255, b = 255}
				end
			end
		end
		
		triggerClientEvent("BM2DLOADMAP", root, self.currentMap)
		outputChatBox("MapCount: " .. #self.allMaps)
		outputChatBox("Name: " .. self.currentMap.name)
		
		self:initSpawns()
	end
end


function MapManagerS:getRandomMap()
	local randomizer = math.random(1, #self.allMaps)
	
	local current = 0
	for index, map in pairs(self.allMaps) do
		if (map) then
			current = current + 1
			
			if (current == randomizer) then
				return map
			end
		end
	end
	
	return nil
end


function MapManagerS:initSpawns()
	local availableSpawns = {}
	
	for index, mapPart in pairs(self.currentMap) do
		if (mapPart) then
			if (type(mapPart) == "table") then
				if (mapPart.type == "spawn") then
					table.insert(availableSpawns, mapPart)
				end
			end
		end
	end
	
	triggerEvent("BM2DSPAWNPLAYERS", root, availableSpawns)
end


function MapManagerS:getCurrentMap()
	return self.currentMap
end


function MapManagerS:isBlocked(id)
	if (id) then
		if (self.currentMap[id]) then
			return self.currentMap[id].isBlocked
		end
	end
	
	return "true"
end


function MapManagerS:isDestroyable(id)
	if (id) then
		if (self.currentMap[id]) then
			return self.currentMap[id].destroyable
		end
	end
	
	return "false"
end


function MapManagerS:createExplosions(possibleExplosions)
	if (possibleExplosions) then
		for index, explosionID in pairs(possibleExplosions) do
			if (explosionID) then
				local effectSettings = {}
				effectSettings.id = explosionID
				effectSettings.type = "explosion"
				effectSettings.lifetime = 500
				
				triggerClientEvent("BM2DADDEFFECT", root, effectSettings)
				
				self:destroyBlock(explosionID)
				
				triggerEvent("BM2DKILLPLAYER", root, explosionID)
			end
		end
	end
end


function MapManagerS:setColor(id, color)
	if (id) then
		if (self.currentMap[id]) then
			self.currentMap[id].color = color
			
			local blockSettings = {}
			blockSettings.id = self.currentMap[id].id
			blockSettings.type = self.currentMap[id].type
			blockSettings.isBlocked = self.currentMap[id].isBlocked
			blockSettings.color = color
				
			triggerClientEvent("BM2DCHANGEBLOCKSETTINGS", root, blockSettings)
		end
	end
end


function MapManagerS:destroyBlock(id)
	if (id) then
		if (self.currentMap[id]) then
			if (self.currentMap[id].type == "block") then
				self.currentMap[id].type = "floor"
				self.currentMap[id].isBlocked = "false"
				
				local blockSettings = {}
				blockSettings.id = self.currentMap[id].id
				blockSettings.type = self.currentMap[id].type
				blockSettings.isBlocked = self.currentMap[id].isBlocked
				blockSettings.color = self.currentMap[id].color
				
				triggerClientEvent("BM2DCHANGEBLOCKSETTINGS", root, blockSettings)
			end
		end
	end
end


function MapManagerS:destructor()

	removeEventHandler("onGameStateChanged", root, self.m_SetGameState)
	removeEventHandler("BM2DCREATEEXPLOSIONS", root, self.m_CreateExplosions)

	mainOutput("MapManagerS was deleted.")
end
