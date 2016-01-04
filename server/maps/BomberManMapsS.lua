--[[
	Name: BomberMan2D
	Filename: BomberManMapsS.lua
	Authors: Sam@ke
--]]

local maps = {}

	maps[1] = {}
	maps[1].name = "The Castle 1"
	maps[1].size = 17
	maps[1].skyColor = {r = 120, g = 180, b = 245}
	maps[1].textureSet = 1
	maps[1][1] 		= {"W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W"}
	maps[1][2] 		= {"W", "S", "F", "F", "F", "F", "F", "F", "W", "F", "F", "F", "F", "F", "F", "S", "W"}
	maps[1][3] 		= {"W", "F", "W", "W", "W", "F", "W", "F", "W", "F", "W", "F", "W", "W", "W", "F", "W"}
	maps[1][4] 		= {"W", "F", "W", "F", "F", "F", "W", "F", "F", "F", "W", "F", "F", "F", "W", "F", "W"}
	maps[1][5] 		= {"W", "F", "W", "F", "W", "F", "W", "W", "F", "W", "W", "F", "W", "F", "W", "F", "W"}
	maps[1][6] 		= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[1][7] 		= {"W", "F", "W", "W", "W", "F", "W", "F", "W", "F", "W", "F", "W", "W", "W", "F", "W"}
	maps[1][8] 		= {"W", "F", "F", "F", "W", "F", "F", "F", "F", "F", "F", "F", "W", "F", "F", "F", "W"}
	maps[1][9] 		= {"W", "W", "W", "F", "F", "F", "W", "F", "W", "F", "W", "F", "F", "F", "W", "W", "W"}
	maps[1][10] 	= {"W", "F", "F", "F", "W", "F", "F", "F", "F", "F", "F", "F", "W", "F", "F", "F", "W"}
	maps[1][11] 	= {"W", "F", "W", "W", "W", "F", "W", "F", "W", "F", "W", "F", "W", "W", "W", "F", "W"}
	maps[1][12] 	= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[1][13] 	= {"W", "F", "W", "F", "W", "F", "W", "W", "F", "W", "W", "F", "W", "F", "W", "F", "W"}
	maps[1][14] 	= {"W", "F", "W", "F", "F", "F", "W", "F", "F", "F", "W", "F", "F", "F", "W", "F", "W"}
	maps[1][15] 	= {"W", "F", "W", "W", "W", "F", "W", "F", "W", "F", "W", "F", "W", "W", "W", "F", "W"}
	maps[1][16] 	= {"W", "S", "F", "F", "F", "F", "F", "F", "W", "F", "F", "F", "F", "F", "F", "S", "W"}
	maps[1][17] 	= {"W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W"}
	
	maps[2] = {}
	maps[2].name = "The Castle 2"
	maps[2].size = 10
	maps[2].skyColor = {r = 245, g = 180, b = 120}
	maps[2].textureSet = 2
	maps[2][1] 		= {"W", "W", "W", "W", "W", "W", "W", "W", "W", "W"}
	maps[2][2] 		= {"W", "S", "F", "F", "F", "F", "F", "F", "S", "W"}
	maps[2][3] 		= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[2][4] 		= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[2][5] 		= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[2][6] 		= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[2][7] 		= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[2][8] 		= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[2][9] 		= {"W", "S", "F", "F", "F", "F", "F", "F", "S", "W"}
	maps[2][10] 	= {"W", "W", "W", "W", "W", "W", "W", "W", "W", "W"}



function getBomberManMaps()
	return maps
end