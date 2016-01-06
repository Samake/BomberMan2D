--[[
	Name: BomberMan2D
	Filename: RenderClassC.lua
	Authors: Sam@ke
--]]

RenderClassC = {}

function RenderClassC:constructor(parent)
	mainOutput("RenderClassC was loaded.")
	
	self.mainClass = parent
	self.gameState = "idle"
	
	self.m_SetGameState = bind(self.setGameState, self)
	addEvent("onGameStateChanged", true)
	addEventHandler("onGameStateChanged", root, self.m_SetGameState)
	
	self.screenWidth, self.screenHeight = guiGetScreenSize()
	self.screenSource = dxCreateScreenSource(self.screenWidth, self.screenHeight)
	self.renderTargetGame = dxCreateRenderTarget(self.screenWidth, self.screenHeight, true)
	self.renderTargetFinal = dxCreateRenderTarget(self.screenWidth, self.screenHeight, true)
	
	self.brightness = 1.00
	self.saturation = 1.25
	self.contrast = 1.00
	self.flipRotation = 0
	
	self.isLoaded = self.screenSource and self.renderTargetGame and self.renderTargetFinal
end


function RenderClassC:update()
	if (self.isLoaded) then
		self.screenSource:update()
		
		dxSetRenderTarget(self.renderTargetGame, true)
		
		if (self.gameState == "ingame") then
			if (self.mainClass.mapManager) then
				self.mapScreenSize = self.mainClass.mapManager.mapScreenSize
				self.startX = self.mainClass.mapManager.startX
				self.startY = self.mainClass.mapManager.startY
				dxDrawImage(0, 0, self.screenWidth, self.screenHeight, self.mainClass.mapManager:getMapRender())
			end
			
			if (self.mainClass.bombManager) then
				dxDrawImage(0, 0, self.screenWidth, self.screenHeight, self.mainClass.bombManager:getBombRender())
			end
			
			if (self.mainClass.playerManager) then
				dxDrawImage(0, 0, self.screenWidth, self.screenHeight, self.mainClass.playerManager:getPlayerRender())
			end
			
			if (self.mainClass.effectManager) then
				dxDrawImage(0, 0, self.screenWidth, self.screenHeight, self.mainClass.effectManager:getEffectRender())
			end
		end
		
		dxSetRenderTarget()
		
		dxSetRenderTarget(self.renderTargetFinal, true)
		
		if (self.mainClass.shaderManager) then
			if (self.mainClass.shaderManager.skyShader) then
				dxDrawImage(0, 0, self.screenWidth, self.screenHeight, self.mainClass.shaderManager.skyShader:getSkyRender())
			end
		end
		
		if (self.mainClass.shaderManager) then
			if (self.mainClass.shaderManager.pictureQualityShader) then
				self.mainClass.shaderManager.pictureQualityShader:setInput(self.renderTargetGame)
				self.mainClass.shaderManager.pictureQualityShader:setBrightness(self.brightness)
				self.mainClass.shaderManager.pictureQualityShader:setSaturation(self.saturation)
				self.mainClass.shaderManager.pictureQualityShader:setContrast(self.contrast)
				self.mainClass.shaderManager.pictureQualityShader:setFlipRotation(self.flipRotation)
				
				if (self.mapScreenSize) and (self.startX) and (self.startY) then
					dxDrawRectangle(self.startX, self.startY, self.mapScreenSize, self.mapScreenSize, tocolor(0, 0, 0, 255))
				end
				
				dxDrawImage(0, 0, self.screenWidth, self.screenHeight, self.mainClass.shaderManager.pictureQualityShader:getQualityRender())
			end
		end
		
		dxSetRenderTarget()
		
		dxDrawImage(0, 0, self.screenWidth, self.screenHeight, self.renderTargetFinal)
	end
end


function RenderClassC:setGameState(state)
	if (state) then
		self.gameState = state
	end
end


function RenderClassC:destructor()

	removeEventHandler("onGameStateChanged", root, self.m_SetGameState)
	
	if (self.screenSource) then
		self.screenSource:destroy()
		self.screenSource = nil
	end
	
	if (self.renderTargetGame) then
		self.renderTargetGame:destroy()
		self.renderTargetGame = nil
	end
	
	if (self.renderTargetFinal) then
		self.renderTargetFinal:destroy()
		self.renderTargetFinal = nil
	end
	
	mainOutput("RenderClassC was deleted.")
end
