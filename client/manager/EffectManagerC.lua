--[[
	Name: BomberMan2D
	Filename: EffectManagerC.lua
	Authors: Sam@ke
--]]

EffectManagerC = {}

function EffectManagerC:constructor(parent)
	mainOutput("EffectManagerC was loaded.")
	
	self.mainClass = parent
		
	self.screenWidth, self.screenHeight = guiGetScreenSize()
	self.renderTarget = dxCreateRenderTarget(self.screenWidth, self.screenHeight, true)

	self.isLoaded = self.renderTarget and self.mainClass
	
	self.m_AddEffect = bind(self.addEffect, self)
	addEvent("BM2DADDEFFECT", true)
	addEventHandler("BM2DADDEFFECT", root, self.m_AddEffect)
	
	self.m_UpdateSlowly = bind(self.updateSlowly, self)
	self.slowUpdateDelta = 200
	self.updateTimer = setTimer(self.m_UpdateSlowly, self.slowUpdateDelta, 0)
	
	self.explosionTextures = {}
	
	for i = 1, 16, 1 do
		self.explosionTextures[i] = dxCreateTexture("res/textures/explo" .. i .. ".png")
	end
	
	self.effects = {}
end


function EffectManagerC:updateSlowly()

end


function EffectManagerC:update()
	if (self.isLoaded) and (self.mainClass.mapManager) then	
	
		self.mapTileSize = self.mainClass.mapManager.mapTileSize
		self.startX = self.mainClass.mapManager.startX
		self.startY = self.mainClass.mapManager.startY
		
		dxSetRenderTarget(self.renderTarget, true)

		for index, effect in pairs(self.effects) do
			if (effect) then
				effect:update()
			end
		end
		
		dxSetRenderTarget()
	end
end


function EffectManagerC:addEffect(effectSettings)
	if (effectSettings) then
		effectSettings.mapTileSize = self.mapTileSize
		effectSettings.startX = self.startX
		effectSettings.startY = self.startY
		effectSettings.textures = self.explosionTextures
		
		if (not self.effects[effectSettings.id]) then
			self.effects[effectSettings.id] = new(EffectC, self, effectSettings)
		end
	end
end


function EffectManagerC:deleteEffect(id)
	if (id) then
		if (self.effects[id]) then
			delete(self.effects[id])
			self.effects[id] = nil
		end	
	end
end


function EffectManagerC:getEffectRender()
	return self.renderTarget
end


function EffectManagerC:clearEffects()
	for index, effect in pairs(self.effects) do
		if (effect) then
			delete(effect)
			effect = nil
		end
	end
end


function EffectManagerC:destructor()

	removeEventHandler("BM2DADDEFFECT", root, self.m_AddEffect)
	
	self:clearEffects()
	
	if (self.renderTarget) then
		self.renderTarget:destroy()
		self.renderTarget = nil
	end
	
	if (self.updateTimer) then
		self.updateTimer:destroy()
		self.updateTimer = nil
	end
	
	for index, texture in pairs(self.explosionTextures) do
		if (texture) then
			texture:destroy()
			texture = nil
		end
	end

	mainOutput("EffectManagerC was deleted.")
end
