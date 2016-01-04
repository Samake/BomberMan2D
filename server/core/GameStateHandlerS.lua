--[[
	Name: BomberMan2D
	Filename: GameStateHandlerS.lua
	Authors: Sam@ke
--]]

GameStateHandlerS = {}

function GameStateHandlerS:constructor(parent)
	mainOutput("GameStateHandlerS was loaded.")
	
	self.mainClass = parent
	self.gameState = "idle"
	self.isStarted = "false"
	
	self.m_SetGameState = bind(self.setGameState, self)
end


function GameStateHandlerS:setGameState(state)
	if (state) then
		self.gameState = state
		triggerEvent("onGameStateChanged", root, self.gameState)
		triggerClientEvent("onGameStateChanged", root, self.gameState)
	end
end


function GameStateHandlerS:update()
	if (#getElementsByType("player") < 1) then
		if (self.gameState ~= "idle") then
			self.gameState = "idle"
			self.isStarted = "false"
		end
	else
		if (self.gameState == "idle") then
			if (self.isStarted == "false") then
				setTimer(self.m_SetGameState, 5000, 1, "ingame")
				self.isStarted = "true"
			end
		end
	end
end


function GameStateHandlerS:destructor()

	mainOutput("GameStateHandlerS was deleted.")
end
