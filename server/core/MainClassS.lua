--[[
	Name: BomberMan2D
	Filename: MainClassS.lua
	Authors: Sam@ke
--]]

local Instance = nil

MainClassS = {}


function MainClassS:constructor()
	mainOutput("SERVER // ***** BomberMan2D was started *****")
	mainOutput("MainClassS was loaded.")
	
	setFPSLimit(60)
	
	self.updateInterVal = 100
	
	self.m_Update = bind(self.update, self)
	self.updateTimer = setTimer(self.m_Update, self.updateInterVal , 0)
	
	self:init()
	
end

function MainClassS:init()
	
	for index, player in pairs(getElementsByType("player")) do
		if (player) and (isElement(player)) then
			player:setFrozen(true)
			toggleAllControls(player, false)
		end
	end
	
	if (not self.gameStateHandler) then
		self.gameStateHandler = new(GameStateHandlerS, self)
	end
	
	if (not self.mapManager) then
		self.mapManager = new(MapManagerS, self)
	end
	
	
	if (not self.gameManager) then
		self.gameManager = new(GameManagerS, self)
	end
	
	if (not self.playerManager) then
		self.playerManager = new(PlayerManagerS, self)
	end
	
	if (not self.bombManager) then
		self.bombManager = new(BombManagerS, self)
	end
end


function MainClassS:update()
	setSunColor(0, 0, 0, 0, 0, 0)
	setSkyGradient(0, 0, 0, 0, 0, 0)
	setWeather(0)
	setMoonSize(0)
	setSunSize(0)
	
	for index, player in pairs(getElementsByType("player")) do
		if (player) and (isElement(player)) then
			if (not player:isFrozen()) then
				player:setFrozen(true)
				toggleAllControls(player, false)
			end
		end
	end
	
	if (self.gameStateHandler) then
		self.gameStateHandler:update()
	end
	
	if (self.mapManager) then
		self.mapManager:update()
	end
	
	if (self.gameManager) then
		self.gameManager:update()
	end
	
	if (self.playerManager) then
		self.playerManager:update()
	end
	
	if (self.bombManager) then
		self.bombManager:update()
	end
end


function MainClassS:clear()
	if (self.gameStateHandler) then
		delete(self.gameStateHandler)
		self.gameStateHandler = nil
	end
	
	if (self.mapManager) then
		delete(self.mapManager)
		self.mapManager = nil
	end
	
	if (self.gameManager) then
		delete(self.gameManager)
		self.gameManager = nil
	end
	
	if (self.playerManager) then
		delete(self.playerManager)
		self.playerManager = nil
	end
	
	if (self.bombManager) then
		delete(self.bombManager)
		self.bombManager = nil
	end
	
	for index, player in pairs(getElementsByType("player")) do
		if (player) and (isElement(player)) then
			player:setFrozen(false)
			toggleAllControls(player, true)
		end
	end
end


function MainClassS:destructor()

	self:clear()
	
	resetSkyGradient()
	resetHeatHaze()
	resetSunSize()
	resetSunColor()
	resetWindVelocity()
	resetFarClipDistance()
	resetMoonSize()
	
	mainOutput("MainClassS was deleted.")
end


addEventHandler("onResourceStart", resourceRoot,
function()
	Instance = new(MainClassS)
end)


addEventHandler("onResourceStop", resourceRoot,
function()
	if (Instance) then
		delete(Instance)
		Instance = nil
	end
end)