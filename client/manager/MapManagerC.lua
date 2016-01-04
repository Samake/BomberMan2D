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

	self.screenWidth, self.screenHeight = guiGetScreenSize()
	self.renderTarget = dxCreateRenderTarget(self.screenWidth, self.screenHeight, true)
	
	self.m_LoadMap = bind(self.loadMap, self)
	addEvent("loadMap", true)
	addEventHandler("loadMap", root, self.m_LoadMap)
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
			
			local textures = self.mapTextures[self.currentMap.textureSet]
			
			for i = 1, self.mapSize do
				for j = 1, self.mapSize do
					local id = string.format("%02d", i) .. string.format("%02d", j)
					
					if (self.currentMap[id]) then
						local tileSettings = {}
						tileSettings.id = self.currentMap[id].id
						tileSettings.type = self.currentMap[id].type
						tileSettings.isBlocked = self.currentMap[id].isBlocked
						tileSettings.isSpawn = self.currentMap[id].isSpawn
						
						if (self.currentMap[id].type == "wall") then
							tileSettings.color = tocolor(100, 60, 0, 255)
							tileSettings.texture = textures.wallTexture
						elseif (self.currentMap[id].type == "spawn") then
							tileSettings.color = tocolor(220, 15, 15, 255)
							tileSettings.texture = textures.floorTexture
							tileSettings.spawnTexture = self.spawnTexture
						elseif (self.currentMap[id].type == "block") then
							tileSettings.color = tocolor(220, 220, 0, 255)
							tileSettings.texture = textures.blockTexture
						elseif (self.currentMap[id].type == "floor") then
							tileSettings.color = tocolor(0, 200, 0, 255)
							tileSettings.texture = textures.floorTexture
						end
						
						tileSettings.x = self.startX + self.mapTileSize * (j - 1)
						tileSettings.y = self.startY + self.mapTileSize * (i - 1)
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
	removeEventHandler("loadMap", root, self.m_LoadMap)
	
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
	
	if (self.renderTarget) then
		self.renderTarget:destroy()
		self.renderTarget = nil
	end
end


function MapManagerC:destructor()

	self:deleteMap()
	
	mainOutput("MapManagerC was deleted.")
end
