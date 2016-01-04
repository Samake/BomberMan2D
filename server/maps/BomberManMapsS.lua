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
	maps[1][2] 		= {"W", "S", "F", "F", "B", "F", "F", "S", "W", "S", "F", "F", "B", "F", "F", "S", "W"}
	maps[1][3] 		= {"W", "F", "W", "W", "W", "B", "W", "F", "W", "F", "W", "B", "W", "W", "W", "F", "W"}
	maps[1][4] 		= {"W", "F", "W", "S", "F", "F", "W", "F", "B", "F", "W", "F", "F", "S", "W", "F", "W"}
	maps[1][5] 		= {"W", "B", "W", "F", "W", "B", "W", "W", "B", "W", "W", "B", "W", "F", "W", "B", "W"}
	maps[1][6] 		= {"W", "F", "B", "F", "B", "B", "B", "B", "B", "B", "B", "B", "B", "F", "B", "F", "W"}
	maps[1][7] 		= {"W", "F", "W", "W", "W", "B", "W", "B", "W", "B", "W", "B", "W", "W", "W", "F", "W"}
	maps[1][8] 		= {"W", "S", "F", "F", "W", "B", "B", "B", "B", "B", "B", "B", "W", "F", "F", "S", "W"}
	maps[1][9] 		= {"W", "W", "W", "B", "B", "B", "W", "B", "W", "B", "W", "B", "B", "B", "W", "W", "W"}
	maps[1][10] 	= {"W", "S", "F", "F", "W", "B", "B", "B", "B", "B", "B", "B", "W", "F", "F", "S", "W"}
	maps[1][11] 	= {"W", "F", "W", "W", "W", "B", "W", "B", "W", "B", "W", "B", "W", "W", "W", "F", "W"}
	maps[1][12] 	= {"W", "F", "B", "F", "B", "B", "B", "B", "B", "B", "B", "B", "B", "F", "B", "F", "W"}
	maps[1][13] 	= {"W", "B", "W", "F", "W", "B", "W", "W", "B", "W", "W", "B", "W", "F", "W", "B", "W"}
	maps[1][14] 	= {"W", "F", "W", "S", "F", "F", "W", "F", "B", "F", "W", "F", "F", "S", "W", "F", "W"}
	maps[1][15] 	= {"W", "F", "W", "W", "W", "B", "W", "F", "W", "F", "W", "B", "W", "W", "W", "F", "W"}
	maps[1][16] 	= {"W", "S", "F", "F", "B", "F", "F", "S", "W", "S", "F", "F", "B", "F", "F", "S", "W"}
	maps[1][17] 	= {"W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W"}
	
	maps[2] = {}
	maps[2].name = "The Castle 2"
	maps[2].size = 17
	maps[2].skyColor = {r = 245, g = 180, b = 120}
	maps[2].textureSet = 2
	maps[2][1] 		= {"W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W"}
	maps[2][2] 		= {"W", "S", "F", "F", "B", "F", "F", "S", "W", "S", "F", "F", "B", "F", "F", "S", "W"}
	maps[2][3] 		= {"W", "F", "W", "W", "W", "B", "W", "F", "W", "F", "W", "B", "W", "W", "W", "F", "W"}
	maps[2][4] 		= {"W", "F", "W", "S", "F", "F", "W", "F", "B", "F", "W", "F", "F", "S", "W", "F", "W"}
	maps[2][5] 		= {"W", "B", "W", "F", "W", "B", "W", "W", "B", "W", "W", "B", "W", "F", "W", "B", "W"}
	maps[2][6] 		= {"W", "F", "B", "F", "B", "B", "B", "B", "B", "B", "B", "B", "B", "F", "B", "F", "W"}
	maps[2][7] 		= {"W", "F", "W", "W", "W", "B", "W", "B", "W", "B", "W", "B", "W", "W", "W", "F", "W"}
	maps[2][8] 		= {"W", "S", "F", "F", "W", "B", "B", "B", "B", "B", "B", "B", "W", "F", "F", "S", "W"}
	maps[2][9] 		= {"W", "W", "W", "B", "B", "B", "W", "B", "W", "B", "W", "B", "B", "B", "W", "W", "W"}
	maps[2][10] 	= {"W", "S", "F", "F", "W", "B", "B", "B", "B", "B", "B", "B", "W", "F", "F", "S", "W"}
	maps[2][11] 	= {"W", "F", "W", "W", "W", "B", "W", "B", "W", "B", "W", "B", "W", "W", "W", "F", "W"}
	maps[2][12] 	= {"W", "F", "B", "F", "B", "B", "B", "B", "B", "B", "B", "B", "B", "F", "B", "F", "W"}
	maps[2][13] 	= {"W", "B", "W", "F", "W", "B", "W", "W", "B", "W", "W", "B", "W", "F", "W", "B", "W"}
	maps[2][14] 	= {"W", "F", "W", "S", "F", "F", "W", "F", "B", "F", "W", "F", "F", "S", "W", "F", "W"}
	maps[2][15] 	= {"W", "F", "W", "W", "W", "B", "W", "F", "W", "F", "W", "B", "W", "W", "W", "F", "W"}
	maps[2][16] 	= {"W", "S", "F", "F", "B", "F", "F", "S", "W", "S", "F", "F", "B", "F", "F", "S", "W"}
	maps[2][17] 	= {"W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W", "W"}
	
	--[[maps[3] = {}
	maps[3].name = "The Castle 3"
	maps[3].size = 10
	maps[3].skyColor = {r = 245, g = 180, b = 120}
	maps[3].textureSet = 2
	maps[3][1] 		= {"W", "W", "W", "W", "W", "W", "W", "W", "W", "W"}
	maps[3][2] 		= {"W", "S", "F", "F", "F", "F", "F", "F", "S", "W"}
	maps[3][3] 		= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[3][4] 		= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[3][5] 		= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[3][6] 		= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[3][7] 		= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[3][8] 		= {"W", "F", "F", "F", "F", "F", "F", "F", "F", "W"}
	maps[3][9] 		= {"W", "S", "F", "F", "F", "F", "F", "F", "S", "W"}
	maps[3][10] 	= {"W", "W", "W", "W", "W", "W", "W", "W", "W", "W"}]]



function getBomberManMaps()
	return maps
end