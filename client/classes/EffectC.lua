--[[
	Name: BomberMan2D
	Filename: EffectC.lua
	Authors: Sam@ke
--]]

EffectC = {}

function EffectC:constructor(parent, effectSettings)

	self.effectManager = parent
	
	self.id = effectSettings.id
	self.type = effectSettings.type
	self.mapTileSize = effectSettings.mapTileSize
	self.startX = effectSettings.startX
	self.startY = effectSettings.startY
	self.lifetime = effectSettings.lifetime
	self.textures = effectSettings.textures
	
	self.postGUI = false
	self.subPixelPositioning = false
	
	self.startTime = getTickCount()
	self.currentTexture = 1
	
	--mainOutput("EffectC " .. self.id .. " was loaded.")
end


function EffectC:update()
	if (self.effectManager) then
		self.currentTexture = self.currentTexture + 1
		
		if (self.currentTexture >= #self.textures) then
			self.currentTexture = #self.textures
		end
		
		self.offSetX = string.sub(self.id, 1, 2)
		self.offSetY = string.sub(self.id, 3, 4)
		
		if (self.offSetX) and (self.offSetY) then
			self.x = self.startX + self.mapTileSize * (tonumber(self.offSetX) - 1)
			self.y = self.startY + self.mapTileSize * (tonumber(self.offSetY) - 1)
			
			dxSetRenderTarget(self.effectManager.renderTarget, false)
			
			if (self.textures[self.currentTexture]) then
				dxDrawImage(self.x, self.y, self.mapTileSize, self.mapTileSize, self.textures[self.currentTexture])
			else
				dxDrawRectangle(self.x, self.y, self.mapTileSize, self.mapTileSize, tocolor(255, 0, 255, 255))
			end
			
			dxSetRenderTarget()
		end
	end
	
	self.currentTime = getTickCount()
	
	if ((self.currentTime - self.startTime) > self.lifetime) then
		self.effectManager:deleteEffect(self.id)
	end
end


function EffectC:destructor()

	--mainOutput("EffectC " .. self.id .. " was deleted.")
end
