--[[
	Name: BomberMan2D
	Filename: BombManagerS.lua
	Authors: Sam@ke
--]]

BombManagerS = {}

function BombManagerS:constructor(parent)
	mainOutput("BombManagerS was loaded.")
	
	self.mainClass = parent
	self.gameState = "idle"
	
	self.bombs = {}
	
	self.m_SetGameState = bind(self.setGameState, self)
	addEvent("onGameStateChanged", true)
	addEventHandler("onGameStateChanged", root, self.m_SetGameState)
	
	self.m_PlaceBomb = bind(self.placeBomb, self)
	addEvent("BM2DPLACEBOMB", true)
	addEventHandler("BM2DPLACEBOMB", root, self.m_PlaceBomb)
end


function BombManagerS:setGameState(state)
	if (state) then
		self.gameState = state
	end
end


function BombManagerS:update()
	if (self.gameState == "ingame") then
		for index, bomb in pairs(self.bombs) do
			if (bomb) then
				bomb:update()
			end
		end
	end
end


function BombManagerS:placeBomb(id)
	if (id) then
		if (self.gameState == "ingame") then
			if (not self.bombs[id]) then
				local bombSettings = {}
				bombSettings.id = id
				bombSettings.owner = source
				
				self.bombs[id] = new(BombS, self, bombSettings)
			end
		end
	end
end


function BombManagerS:deleteBomb(id)
	if (id) then
		if (self.bombs[id]) then
			delete(self.bombs[id])
			self.bombs[id] = nil
		end
	end
end


function BombManagerS:clearBombs()
	for index, bomb in pairs(self.bombs) do
		if (bomb) then
			delete(bomb)
			bomb = nil
		end
	end
end


function BombManagerS:destructor()

	self:clearBombs()

	removeEventHandler("onGameStateChanged", root, self.m_SetGameState)
	removeEventHandler("BM2DPLACEBOMB", root, self.m_PlaceBomb)

	mainOutput("BombManagerS was deleted.")
end
