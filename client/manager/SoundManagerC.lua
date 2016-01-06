--[[
	Name: BomberMan2D
	Filename: SoundManagerC.lua
	Authors: Sam@ke
--]]

SoundManagerC = {}

function SoundManagerC:constructor(parent)
	mainOutput("SoundManagerC was loaded.")
	
	self.mainClass = parent
	
	self.volumeMusic = 0.8
	self.volumeEffects = 1.0
	
	self.musicList = { 	"res/sounds/music_1.mp3",
						"res/sounds/music_2.mp3",
						"res/sounds/music_3.mp3",
						"res/sounds/music_4.mp3",
						"res/sounds/music_5.mp3",
						"res/sounds/music_6.mp3"}
						
	self.effectList = {}
	self.effectList[1] = "res/sounds/blop.wav"
	self.effectList[2] = "res/sounds/collect.wav"
	self.effectList[3] = "res/sounds/explosion.wav"
						
	
	self.m_StartMusic = bind(self.startMusic, self)
	addEvent("BM2DSTARTMUSIC", true)
	addEventHandler("BM2DSTARTMUSIC", root, self.m_StartMusic)
	
	self.m_PlayEffect = bind(self.playEffect, self)
	addEvent("BM2DSOUNDEFFECT", true)
	addEventHandler("BM2DSOUNDEFFECT", root, self.m_PlayEffect)
	
	self.m_StopMusic = bind(self.stopMusic, self)
	addEvent("BM2DSTOPMUSIC", true)
	addEventHandler("BM2DSTOPMUSIC", root, self.m_StopMusic)
end


function SoundManagerC:startMusic()
	if (not self.gameMusic) then
		local randomizer = math.random(1, #self.musicList)
		
		if (self.musicList[randomizer]) then
			self.gameMusic = playSound(self.musicList[randomizer], true)
			self.gameMusic:setVolume(self.volumeMusic)
		end
	end
end


function SoundManagerC:playEffect(effect)
	if (effect) then
		if (self.effectList[effect]) then
			local effectSound = playSound(self.effectList[effect], false)
			effectSound:setVolume(self.volumeEffects)
		end
	end
end


function SoundManagerC:stopMusic()
	if (self.gameMusic) then
		self.gameMusic:stop()
	end
end


function SoundManagerC:destructor()
	removeEventHandler("BM2DSTARTMUSIC", root, self.m_StartMusic)
	removeEventHandler("BM2DSTOPMUSIC", root, self.m_StopMusic)
	removeEventHandler("BM2DSOUNDEFFECT", root, self.m_PlayEffect)
	
	self:stopMusic()

	mainOutput("SoundManagerC was deleted.")
end
