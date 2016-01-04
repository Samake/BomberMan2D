--[[
	Name: BomberMan2D
	Filename: GameManagerS.lua
	Authors: Sam@ke
--]]

GameManagerS = {}

function GameManagerS:constructor(parent)
	mainOutput("GameManagerS was loaded.")
	
	self.mainClass = parent
	self.gameState = "idle"
	
	self.m_SetGameState = bind(self.setGameState, self)
	addEvent("onGameStateChanged", true)
	addEventHandler("onGameStateChanged", root, self.m_SetGameState)
end


function GameManagerS:setGameState(state)
	if (state) then
		self.gameState = state
	end
end


function GameManagerS:update()
	if (self.gameState == "ingame") then

	end
end


function GameManagerS:destructor()

	removeEventHandler("onGameStateChanged", root, self.m_SetGameState)

	mainOutput("GameManagerS was deleted.")
end
