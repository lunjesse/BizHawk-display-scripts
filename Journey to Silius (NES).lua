memory.usememorydomain("RAM")
Stage = { 
   [5]   =   "STAGE 5", 
   [6]   =   "STAGE 5", 
   [7]   =   " FINAL ", 
   [16]   =   "STAGE 1", 
   [17]   =   "STAGE 2", 
   [18]   =   "STAGE 3", 
   [19]   =   "STAGE 4", 
   [20]   =   "STAGE 5", 
   [21]   =   "BOSS #1", 
   [22]   =   "BOSS #2", 
   [23]   =   "BOSS #3", 
   [24]   =   "BOSS #4", 
   [25]   =   "BOSS #5" 
}
-- Don't display the following 
   Blacklist = {0,1,2,3,4,5,6,13,53,55,57,60,61,76,77,89,90}
   
Player = {x = 0x0500, y = 0x0502, xpeed = 0x0504, yspeed = 0505, xcam = 0x0506, ycam = 0x0507, invincibility = 0x050E, hp = 0x00B0, ammo = 0x00B0}

function display()
	if Stage[memory.readbyte(0x00F2)] ~= nil then
		--Player x,y are 2 byte big endian fixed point 12.4 numbers.
		local playerx = memory.read_s16_be(Player.x)/16
		local playery = memory.read_s16_be(Player.y)/16
		gui.drawText(107,8, Stage[memory.readbyte(0x00F2)]) 
		--Display Player stuff
		 gui.drawText(0,200,"X:"..string.format('%.4f',playerx).." Y:"..string.format('%.4f',playery),null,null,8,null,null)	--gui.drawtext uses emulated space rather than client, so I don't have to worry about resizing emulator. Fontsize is 8
		 --Display NPCs
		 i = 17
		 if (Blacklist[i] ~= nil) then
		 gui.drawText(0,100,"Done")
		 end
			
end
end

while true do
	display()
	emu.frameadvance()
end
