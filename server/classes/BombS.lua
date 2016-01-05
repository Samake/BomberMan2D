--[[
	Name: BomberMan2D
	Filename: BombS.lua
	Authors: Sam@ke
--]]

BombS = {}

function BombS:constructor(parent, bombSettings)

	self.bombManager = parent
	
	self.id = bombSettings.id
	self.owner = bombSettings.player
	self.element = createElement("BM2DBOMB", self.id)
	
	self.lifeTime = 3000
	self.startTime = getTickCount()
	
	self.element:setData("BM2DBOMBPOSITION", self.id, true)

	mainOutput("Bomb " .. self.id .. " was loaded.")
end


function BombS:update()
	self.currentTime = getTickCount()
	
	if ((self.currentTime - self.startTime) > self.lifeTime) then
		self.bombManager:deleteBomb(self.id)
	end
end


function BombS:destructor()

	if (self.element) then
		self.element:destroy()
		self.element = nil
	end

	mainOutput("Bomb " .. self.id .. " was deleted.")
end
