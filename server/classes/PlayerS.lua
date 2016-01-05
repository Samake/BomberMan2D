--[[
	Name: BomberMan2D
	Filename: PlayerS.lua
	Authors: Sam@ke
--]]

PlayerS = {}

function PlayerS:constructor(parent, playerSettings)

	self.playerManager = parent
	
	self.id = playerSettings.id
	self.player = playerSettings.player
	self.name = self.player:getName()
	self.position = playerSettings.position
	self.direction = "S"
	
	self.m_MovePlayer = bind(self.movePlayer, self)
	addEvent("BM2DMOVEPLAYER", true)
	addEventHandler("BM2DMOVEPLAYER", root, self.m_MovePlayer)
	
	triggerClientEvent(self.player, "BM2DSETPLAYERDETAILS", self.player, playerSettings)

	mainOutput("Player " .. self.name .. " was loaded with id: " .. self.id)
end


function PlayerS:update()
	
end


function PlayerS:movePlayer(newPos)
	if (source == self.player) then
		if (newPos) then
			if (self.playerManager:isBlocked(newPos) == "false") then
				self.position = newPos
			end
		end
	end
end


function PlayerS:getID()
	return self.id
end


function PlayerS:getPlayer()
	return self.player
end


function PlayerS:getPlayerName()
	return self.name
end


function PlayerS:getPosition()
	return self.position
end


function PlayerS:getDirection()
	return self.direction
end


function PlayerS:destructor()

	removeEventHandler("BM2DMOVEPLAYER", root, self.m_MovePlayer)

	mainOutput("Player " .. self.name .. " was deleted with id: " .. self.id)
end
