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
		self.currentMap = map
		triggerClientEvent("loadMap", root, self.currentMap)
		outputChatBox("MapCount: " .. #self.allMaps)
		outputChatBox("Name: " .. self.currentMap.name)
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


function MapManagerS:destructor()

	removeEventHandler("onGameStateChanged", root, self.m_SetGameState)

	mainOutput("MapManagerS was deleted.")
end
