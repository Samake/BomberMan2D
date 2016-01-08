--[[
	Name: BomberMan2D
	Filename: MapTileC.lua
	Authors: Sam@ke
--]]

MapTileC = {}

function MapTileC:constructor(parent, tileSettings)

	self.mapManager = parent
	self.id = tileSettings.id
	self.color = {r = 0, g = 0, b = 0}
	self.x = tileSettings.x
	self.y = tileSettings.y
	self.size = tileSettings.size
	self.type = tileSettings.type
	self.isBlocked = tileSettings.isBlocked
	self.isSpawn = tileSettings.isSpawn
	self.destroyable = tileSettings.destroyable
	self.destroyed = tileSettings.destroyed
	self.offSetX = tileSettings.offSetX
	self.offSetY = tileSettings.offSetY
	self.texture = tileSettings.texture
	
	self.postGUI = false
	self.subPixelPositioning = false
	
	self.isLoaded = self.mapManager
	
	--mainOutput("MapTileC " .. self.id .. " was loaded.")
end


function MapTileC:update()
	if (self.isLoaded) then
		dxSetRenderTarget(self.mapManager.renderTarget, false)
		
		-- // draw own texture // --
		if (self.texture) then
			dxDrawImage(self.x, self.y, self.size, self.size, self.texture, 0, 0, 0, tocolor(255, 255, 255, 255), self.postGUI)
		else
			dxDrawRectangle(self.x, self.y, self.size, self.size, tocolor(self.color.r, self.color.g, self.color.b, 255), self.postGUI, self.subPixelPositioning)
		end
		
		-- // draw spawn texture // --
		if (self.isSpawn == "true") then
			dxDrawImage(self.x, self.y, self.size, self.size, self.mapManager.spawnTexture, 0, 0, 0, tocolor(self.color.r, self.color.g, self.color.b, 255), self.postGUI)
		end
		
		-- // draw shadows if wall or block is above // --
		if (self.type ~= "wall") and (self.type ~= "block") then
			if (self:getIDUp()) then
				if (self.mapManager:isTileType(self:getIDUp(), "wall") == "true") or (self.mapManager:isTileType(self:getIDUp(), "block") == "true") then
					dxDrawImage(self.x, self.y, self.size, self.size, self.mapManager.blockShadowTexture, 0, 0, 0, tocolor(255, 255, 255, 80), self.postGUI)
				end
			end
		end
		
		dxSetRenderTarget()
	end
end


function MapTileC:getIDLeft()
	return string.format("%02d", tonumber(self.offSetX) - 1) .. string.format("%02d", self.offSetY)
end


function MapTileC:getIDRight()
	return string.format("%02d", tonumber(self.offSetX) + 1) .. string.format("%02d", self.offSetY)
end


function MapTileC:getIDUp()
	return string.format("%02d", self.offSetX) .. string.format("%02d", tonumber(self.offSetY) - 1)
end


function MapTileC:getIDDown()
	return string.format("%02d", self.offSetX) .. string.format("%02d", tonumber(self.offSetY) + 1)
end


function MapTileC:isBlocked()
	return self.isBlocked
end


function MapTileC:setBlocked(blockedIN)
	if (blockedIN) then
		self.isBlocked = blockedIN
	end
end


function MapTileC:setType(typeIN)
	if (typeIN) then
		self.type = typeIN
	end
end


function MapTileC:setTexture(textureIN)
	if (self.texture) then
		self.texture = textureIN
	end
end


function MapTileC:setColor(colorIN)
	if (colorIN) then
		self.color = colorIN
	end
end


function MapTileC:destructor()

	--mainOutput("MapTileC " .. self.id .. " was deleted.")
end
