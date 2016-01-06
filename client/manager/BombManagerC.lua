--[[
	Name: BomberMan2D
	Filename: BombManagerC.lua
	Authors: Sam@ke
--]]

BombManagerC = {}

function BombManagerC:constructor(parent)
	mainOutput("BombManagerC was loaded.")
	
	self.mainClass = parent
		
	self.screenWidth, self.screenHeight = guiGetScreenSize()
	self.renderTarget = dxCreateRenderTarget(self.screenWidth, self.screenHeight, true)
	
	self.bombTextures = {}
	self.bombTextures[1] = dxCreateTexture("res/textures/bomb1.png")
	self.bombTextures[2] = dxCreateTexture("res/textures/bomb2.png")
	self.bombTextures[3] = dxCreateTexture("res/textures/bomb3.png")
	self.bombTextures[4] = dxCreateTexture("res/textures/bomb2.png")
	
	self.currentTexture = 1

	self.isLoaded = self.renderTarget and self.mainClass
	
	self.m_UpdateSlowly = bind(self.updateSlowly, self)
	self.slowUpdateDelta = 200
	self.updateTimer = setTimer(self.m_UpdateSlowly, self.slowUpdateDelta, 0)
end


function BombManagerC:updateSlowly()
	self.currentTexture = self.currentTexture + 1
	
	if (self.currentTexture > 4) then
		self.currentTexture = 1
	end
end


function BombManagerC:update()
	if (self.isLoaded) and (self.mainClass.mapManager) then	
	
		self.mapTileSize = self.mainClass.mapManager.mapTileSize
		self.startX = self.mainClass.mapManager.startX
		self.startY = self.mainClass.mapManager.startY
		
		dxSetRenderTarget(self.renderTarget, true)
		
		for index, bomb in pairs(getElementsByType("BM2DBOMB")) do
			if (bomb) then
				if (isElement(bomb)) then
					
					local offSetX = string.sub(bomb.id, 1, 2)
					local offSetY = string.sub(bomb.id, 3, 4)

					if (offSetX) and (offSetY) then
						local x = self.startX + self.mapTileSize * (tonumber(offSetX) - 1)
						local y = self.startY + self.mapTileSize * (tonumber(offSetY) - 1)
						
						if (self.bombTextures[self.currentTexture]) then
							local colorValue = bomb:getData("BM2DBOMBCOLOR") or 0
							dxDrawImage(x, y - self.mapTileSize, self.mapTileSize, self.mapTileSize * 2, self.bombTextures[self.currentTexture], 0, 0, 0, tocolor(255, 255 - colorValue, 255 - colorValue, 255), false)
						else
							dxDrawRectangle(x, y, self.mapTileSize, self.mapTileSize, tocolor(255, 0, 0, 255))
						end
					end
				end
			end
		end
		
		dxSetRenderTarget()
	end
end


function BombManagerC:getBombRender()
	return self.renderTarget
end


function BombManagerC:destructor()

	if (self.renderTarget) then
		self.renderTarget:destroy()
		self.renderTarget = nil
	end
	
	if (self.updateTimer) then
		self.updateTimer:destroy()
		self.updateTimer = nil
	end

	for index, texture in pairs(self.bombTextures) do
		if (texture) then
			texture:destroy()
			texture = nil
		end
	end

	mainOutput("BombManagerC was deleted.")
end
