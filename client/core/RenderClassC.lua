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
	self.renderTarget = dxCreateRenderTarget(self.screenWidth, self.screenHeight, true)
	
	self.isLoaded = self.screenSource and self.renderTarget
end


function RenderClassC:update()
	if (self.isLoaded) then
		self.screenSource:update()
		
		dxSetRenderTarget(self.renderTarget, true)
		
		if (self.mainClass.shaderManager) then
			if (self.mainClass.shaderManager.skyShader) then
				dxDrawImage(0, 0, self.screenWidth, self.screenHeight, self.mainClass.shaderManager.skyShader:getSkyRender())
			end
		end
		
		if (self.gameState == "ingame") then
			if (self.mainClass.mapManager) then
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
		
		dxDrawImage(0, 0, self.screenWidth, self.screenHeight, self.renderTarget)
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
	
	if (self.renderTarget) then
		self.renderTarget:destroy()
		self.renderTarget = nil
	end
	
	mainOutput("RenderClassC was deleted.")
end
