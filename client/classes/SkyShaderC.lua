--[[
	Name: BomberMan2D
	Filename: SkyShaderC.lua
	Authors: Sam@ke
--]]

SkyShaderC = {}

function SkyShaderC:constructor(parent)
	mainOutput("SkyShaderC was loaded.")
	
	self.shaderManager = parent
	
	self.currentR = 0
	self.currentG = 0
	self.currentB = 0
	
	self.newR = 0
	self.newG = 0
	self.newB = 0
	
	self.fadeStep = 1
	
	self.screenWidth, self.screenHeight = guiGetScreenSize()
	self.renderTarget = dxCreateRenderTarget(self.screenWidth, self.screenHeight, true)
	self.skyGradientShader = dxCreateShader("res/shaders/skyGradient.fx")
	
	self.isLoaded = self.renderTarget and self.skyGradientShader
	
	self.m_LoadMap = bind(self.loadMap, self)
	addEvent("loadMap", true)
	addEventHandler("loadMap", root, self.m_LoadMap)
end


function SkyShaderC:loadMap(map)
	if (map) then
		if (map.skyColor) then
			self.newR = map.skyColor.r
			self.newG = map.skyColor.g
			self.newB = map.skyColor.b
		end
	end
end


function SkyShaderC:update()
	if (self.isLoaded) then
		
		if (self.currentR < self.newR) then
			self.currentR = self.currentR + self.fadeStep
			
			if (self.currentR >= 255) then
				self.currentR = 255
			end
		elseif (self.currentR > self.newR) then
			self.currentR = self.currentR - self.fadeStep
			
			if (self.currentR <= 0) then
				self.currentR = 0
			end
		end
		
		if (self.currentG < self.newG) then
			self.currentG = self.currentG + self.fadeStep
			
			if (self.currentG >= 255) then
				self.currentG = 255
			end
		elseif (self.currentG > self.newG) then
			self.currentG = self.currentG - self.fadeStep
			
			if (self.currentG <= 0) then
				self.currentG = 0
			end
		end
		
		if (self.currentB < self.newB) then
			self.currentB = self.currentB + self.fadeStep
			
			if (self.currentB >= 255) then
				self.currentB = 255
			end
		elseif (self.currentB > self.newB) then
			self.currentB = self.currentB - self.fadeStep
			
			if (self.currentB <= 0) then
				self.currentB = 0
			end
		end
		
		self.skyGradientShader:setValue("skyColor", self:convertColors(self.currentR, self.currentG, self.currentB))
		
		dxSetRenderTarget(self.renderTarget, true)
		dxDrawImage(0, 0, self.screenWidth, self.screenHeight, self.skyGradientShader)
		dxSetRenderTarget()
	end
end


function SkyShaderC:getSkyRender()
	return self.renderTarget
end


function SkyShaderC:convertColors(r, g, b)
	if (r) and (g) and (b) then
		local newColors = {}
		newColors[1] = (1 / 255) * r
		newColors[2] = (1 / 255) * g
		newColors[3] = (1 / 255) * b
		
		return newColors
	end
end


function SkyShaderC:destructor()
	removeEventHandler("loadMap", root, self.m_LoadMap)

	if (self.renderTarget) then
		self.renderTarget:destroy()
		self.renderTarget = nil
	end
	
	if (self.skyGradientShader) then
		self.skyGradientShader:destroy()
		self.skyGradientShader = nil
	end
	
	mainOutput("SkyShaderC was deleted.")
end
