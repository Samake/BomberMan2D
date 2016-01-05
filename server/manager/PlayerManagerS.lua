--[[
	Name: BomberMan2D
	Filename: PlayerManagerS.lua
	Authors: Sam@ke
--]]

PlayerManagerS = {}

function PlayerManagerS:constructor(parent)
	mainOutput("PlayerManagerS was loaded.")
	
	self.mainClass = parent
	self.gameState = "idle"
	
	self.players = {}
	self.playerPositions = {}
	self.spawnPlaces = {}
	
	self.m_SetGameState = bind(self.setGameState, self)
	addEvent("onGameStateChanged", true)
	addEventHandler("onGameStateChanged", root, self.m_SetGameState)
	
	self.m_SpawnAllPlayers = bind(self.spawnAllPlayers, self)
	addEvent("BM2DSPAWNPLAYERS", true)
	addEventHandler("BM2DSPAWNPLAYERS", root, self.m_SpawnAllPlayers)
end


function PlayerManagerS:setGameState(state)
	if (state) then
		self.gameState = state
	end
end


function PlayerManagerS:update()
	if (self.gameState == "ingame") then
		
		for index, playerClass in pairs(self.players) do
			if (playerClass) then
				if (not self.playerPositions[playerClass:getID()]) then
					self.playerPositions[playerClass:getID()] = {}
					self.playerPositions[playerClass:getID()].player = playerClass:getPlayer()
					self.playerPositions[playerClass:getID()].name = playerClass:getPlayerName()
					self.playerPositions[playerClass:getID()].position = playerClass:getPosition()
					self.playerPositions[playerClass:getID()].direction = playerClass:getDirection()
				else
					self.playerPositions[playerClass:getID()].player = playerClass:getPlayer()
					self.playerPositions[playerClass:getID()].name = playerClass:getPlayerName()
					self.playerPositions[playerClass:getID()].position = playerClass:getPosition()
					self.playerPositions[playerClass:getID()].direction = playerClass:getDirection()
				end
			end
		end
		
		triggerClientEvent("BM2DREFRESHPLAYERPOSITIONS", root, self.playerPositions)
	end
end


function PlayerManagerS:spawnAllPlayers(spawnPlaces)
	if (spawnPlaces) then
		self:clear()
		self.spawnPlaces = spawnPlaces
		
		for index, player in pairs(getElementsByType("player")) do
			if (player) then
				local spawn = self:getFreeSpawn()
				
				if (spawn) then
					local playerSettings = {}
					playerSettings.id = tostring(player).. "ID"
					playerSettings.player = player
					playerSettings.position = spawn.id
					
					self.players[playerSettings.id] = new(PlayerS, self, playerSettings)
				end
			end
		end
	end
end


function PlayerManagerS:getFreeSpawn()
	for index, possibleSpawn in pairs(self.spawnPlaces) do
		if (possibleSpawn) then
			if (possibleSpawn.isSpawn == "true") and (possibleSpawn.inUse == "false") then
				possibleSpawn.inUse = "true"
				
				return possibleSpawn
			end
		end
	end
	
	return nil
end


function PlayerManagerS:isBlocked(pos)
	if (pos) and (self.mainClass.mapManager) then
		return self.mainClass.mapManager:isBlocked(pos)
	end

	return "true"
end


function PlayerManagerS:clear()
	self.spawnPlaces = {}
	
	for index, playerClass in pairs(self.players) do
		if (playerClass) then
			delete(playerClass)
			playerClass = nil
		end
	end
end


function PlayerManagerS:destructor()
	self:clear()

	removeEventHandler("onGameStateChanged", root, self.m_SetGameState)
	removeEventHandler("BM2DSPAWNPLAYERS", root, self.m_SpawnAllPlayers)

	mainOutput("PlayerManagerS was deleted.")
end
