--[[
	Name: BomberMan2D
	Filename: MapManagerC.lua
	Authors: Sam@ke
--]]

MapManagerC = {}

function MapManagerC:constructor(parent)
	mainOutput("MapManagerC was loaded.")
	
	self.mainClass = parent
	
	self.mapSize = 0
	self.mapTiles = {}
	self.currentMap = nil
	self.mapTextures = {}
	self.textureSets = 2
	
	for i = 1, self.textureSets do
		self.mapTextures[i] = {}
		self.mapTextures[i].blockTexture = dxCreateTexture("res/textures/block" .. i .. ".png")
		self.mapTextures[i].wallTexture = dxCreateTexture("res/textures/wall" .. i .. ".png")
		self.mapTextures[i].floorTexture = dxCreateTexture("res/textures/floor" .. i .. ".png")
	end
	
	self.spawnTexture = dxCreateTexture("res/textures/spawn.png")
	self.blockShadowTexture = dxCreateTexture("res/textures/blockShadow.png")

	self.screenWidth, self.screenHeight = guiGetScreenSize()
	self.renderTarget = dxCreateRenderTarget(self.screenWidth, self.screenHeight, true)
	
	self.m_LoadMap = bind(self.loadMap, self)
	addEvent("BM2DLOADMAP", true)
	addEventHandler("BM2DLOADMAP", root, self.m_LoadMap)
	
	self.m_ChangeBlockSettings = bind(self.changeBlockSettings, self)
	addEvent("BM2DCHANGEBLOCKSETTINGS", true)
	addEventHandler("BM2DCHANGEBLOCKSETTINGS", root, self.m_ChangeBlockSettings)
end


function MapManagerC:loadMap(map)
	if (map) then
		self:resetMap()
		self.currentMap = map
		
		if (self.currentMap) then
		
			self.mapSize = self.currentMap.size
			self.mapScreenSize = self.screenHeight
			self.mapTileSize = self.mapScreenSize / self.mapSize

			self.startX = (self.screenWidth / 2) - (self.mapScreenSize / 2)
			self.startY = 0
			
			self.textures = self.mapTextures[self.currentMap.textureSet]
			
			for index, mapPart in pairs(self.currentMap) do
				if (mapPart) then
					if (type(mapPart) == "table") then
						if (mapPart.id) then
							local tileSettings = {}
							tileSettings.id = mapPart.id
							tileSettings.type = mapPart.type
							tileSettings.color = mapPart.color
							tileSettings.isBlocked = mapPart.isBlocked
							tileSettings.isSpawn = mapPart.isSpawn
							tileSettings.destroyable = mapPart.destroyable
							tileSettings.destroyed = mapPart.destroyed
							tileSettings.offSetX = mapPart.offSetX
							tileSettings.offSetY = mapPart.offSetY
							
							if (tileSettings.type == "wall") then
								tileSettings.texture = self.textures.wallTexture
							elseif (tileSettings.type == "spawn") then
								tileSettings.texture = self.textures.floorTexture
							elseif (tileSettings.type == "block") then
								tileSettings.texture = self.textures.blockTexture
							elseif (tileSettings.type == "floor") then
								tileSettings.texture = self.textures.floorTexture
							end
							
							tileSettings.x = self.startX + self.mapTileSize * (tileSettings.offSetX - 1)
							tileSettings.y = self.startY + self.mapTileSize * (tileSettings.offSetY - 1)
							tileSettings.size = self.mapTileSize
							
							if (not self.mapTiles[tileSettings.id]) then
								self.mapTiles[tileSettings.id] = new(MapTileC, self, tileSettings)
							end
						end
					end
				end
			end
		end
	end
end


function MapManagerC:changeBlockSettings(blockSettings)
	if (blockSettings) then
		if (self.mapTiles[blockSettings.id]) then
			self.mapTiles[blockSettings.id]:setType(blockSettings.type)
			self.mapTiles[blockSettings.id]:setBlocked(blockSettings.isBlocked)
			self.mapTiles[blockSettings.id]:setColor(blockSettings.color)
			
			outputChatBox("color: " .. tostring(blockSettings.color))
			self.mapTiles[blockSettings.id]:setTexture(self.textures.floorTexture)
		end
	end
end


function MapManagerC:update()
	if (self.renderTarget) then
		dxSetRenderTarget(self.renderTarget, true)

		for index, tileMap in pairs(self.mapTiles) do
			if (tileMap) then
				tileMap:update()
			end
		end
		
		dxSetRenderTarget()
	end
end


function MapManagerC:isTileType(id, typeIn)
	if (id) then
		if (self.mapTiles[id]) then
			if (self.mapTiles[id].type == typeIn) then
				return "true"
			end
		end
	end
	
	return "false"
end


function MapManagerC:getMapRender()
	return self.renderTarget
end


function MapManagerC:resetMap()
	for index, tileMap in pairs(self.mapTiles) do
		if (tileMap) then
			delete(tileMap)
			tileMap = nil
		end
	end
	
	self.mapTiles = {}
	self.currentMap = nil
end


function MapManagerC:deleteMap()
	removeEventHandler("BM2DLOADMAP", root, self.m_LoadMap)
	
	self:resetMap()
	
	for index, textures in pairs(self.mapTextures) do
		if (textures) then
			if (textures.blockTexture) then
				textures.blockTexture:destroy()
				textures.blockTexture = nil
			end
			
			if (textures.wallTexture) then
				textures.wallTexture:destroy()
				textures.wallTexture = nil
			end
			
			textures = nil
		end
	end
	
	if (self.spawnTexture) then
		self.spawnTexture:destroy()
		self.spawnTexture = nil
	end
	
	if (self.blockShadowTexture) then
		self.blockShadowTexture:destroy()
		self.blockShadowTexture = nil
	end
	
	if (self.renderTarget) then
		self.renderTarget:destroy()
		self.renderTarget = nil
	end
end


function MapManagerC:destructor()

	self:deleteMap()
	
	removeEventHandler("BM2DCHANGEBLOCKSETTINGS", root, self.m_ChangeBlockSettings)
	
	mainOutput("MapManagerC was deleted.")
end
