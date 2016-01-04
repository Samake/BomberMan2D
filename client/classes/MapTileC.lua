--[[
	Name: BomberMan2D
	Filename: MapTileC.lua
	Authors: Sam@ke
--]]

MapTileC = {}

function MapTileC:constructor(parent, tileSettings)

	self.mapManager = parent
	self.id = tileSettings.id
	self.color = tileSettings.color
	self.x = tileSettings.x
	self.y = tileSettings.y
	self.size = tileSettings.size
	self.type = tileSettings.type
	self.isBlocked = tileSettings.isBlocked
	self.isSpawn = tileSettings.isSpawn
	self.texture = tileSettings.texture
	self.spawnTexture = tileSettings.spawnTexture
	
	self.postGUI = false
	self.subPixelPositioning = false
	
	self.isLoaded = self.mapManager
	
	--mainOutput("MapTileC " .. self.id .. " was loaded.")
end


function MapTileC:update()
	if (self.isLoaded) then
		dxSetRenderTarget(self.mapManager.renderTarget, false)
		
		if (self.texture) then
			dxDrawImage(self.x, self.y, self.size, self.size, self.texture)
		else
			dxDrawRectangle(self.x, self.y, self.size, self.size, self.color, self.postGUI, self.subPixelPositioning)
		end
		
		if (self.spawnTexture) and (self.isSpawn == "true") then
			dxDrawImage(self.x, self.y, self.size, self.size, self.spawnTexture)
		end
		
		dxSetRenderTarget()
	end
end

function MapTileC:isBlocked()
	return self.isBlocked
end


function MapTileC:destructor()

	--mainOutput("MapTileC " .. self.id .. " was deleted.")
end
