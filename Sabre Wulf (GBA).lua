memory.usememorydomain("IWRAM")

--[[
Pointer at 0x1418
+0x0 - X pos
+0x4 - Y pos
+0x20 - pheonix
+0x38 - X speed
+0x3C - Y speed

]]--

local player = {X = 0, Y = 0, Z = 0, XSpeed = 0, YSpeed = 0, Phoenix = 0, Pointer = 0x1418}
local wolf = {X = 0, Y = 0, Z = 0, XSpeed = 0, YSpeed = 0, Pointer = 0x42FC}
local area = {[0] = "Campsite Clearing", "River Crossing", "Blown Away", "Blackwyche Swamp", "Outlaw Inn", "Eastern Karnath", "Wishing Well", "Blackwyche Laboratory", "Karnath Canopy", "Tangle Terror", "Lower Karnath Mines", "Overgrown Outpost", "Knightlore Falls", "Upper Karnath Mines", "Tangle Terror Lookout", "Karnath Laboratory", "Torchlight Torment", "Deep Dark Dugout", "Stinky Cavern", "Mining Mayhem", "Lookout Ledge", "Crumble Crevice", "Stranglehold Swamp", "Underwurlde Laboratory", "Stinger Strangle", "Frantic Fissure", "Hobbled Hamlet", "Stinkhorn Swamp", "Rocky Mount", "Viper Vines", "Terror Temple", "Entombed Laboratory", "Snowy Knoll", "Frosty's Grotto", "Shivery Peaks", "Wafty Shaft", "Icy Nook", "Gusty Gully", "Coalhouse Climb", "Knightlore Laboratory", "Flames of Fury", "Ritval Ruins", "Filthy Factory", "Mortar Mountain", "Industrial Carnage", "House on the Hill", "Heavy Metal", "Nightshade Laboratory", "Tumbledown Temple", "Watch Out Below", "Magical Mayhem", "Town and Out", "Wings of Steel", "Craggy Crack", "This Old House", "Imhotep Laboratory", "Rooftop Rampage", "Temple Plains", "Cluster Keep", "Factory Furnace", "Bind Alley", "Firing Squad", "Cobbled Courtyard", "Dragonskulle Laboratory"}
local fade_frame = 0

function update(address)
	local pointer = memory.read_u32_le(address)
	if pointer > 0x3000000 and pointer < 0x4000000 then
		return pointer-0x3000000	--Minus (0x3000000) since BizHawk memory domains
	end
	return nill
end

while true do
	local pointer = update(player.Pointer)
	local pointer_wolf = update(wolf.Pointer)
	local fade_timer = memory.read_s8(0x5354)
	local map = memory.read_s8(0x01A4)
	local frame = memory.read_u32_le(0x0190)	--In stage timer in frames
	if area[map] ~= nil then
		--gui.drawText(50,0,map,null,null,10,null,null)
		gui.drawText(50,0,area[map],null,null,10,null,null)
	end
	if pointer ~= nill then
		player.X = memory.read_u32_le(pointer)	--Address pointed by pointer + 0x0
		player.Y = memory.read_u32_le(pointer+0x4)	--Address pointed by pointer + 0x4
		player.Z = memory.read_u32_le(pointer+0x8)	--Address pointed by pointer + 0x8
		player.XSpeed = memory.read_s32_le(pointer+0x38)	--Address pointed by pointer + 0x38
		player.YSpeed = memory.read_s32_le(pointer+0x3C)	--Address pointed by pointer + 0x3C
		player.Phoenix = memory.read_u32_le(pointer+0x20) 
		if pointer_wolf ~= nill then
			if memory.read_s32_le(pointer_wolf) > 0 and memory.readbyte(pointer_wolf+0x66) == 3 then	--Wolf is present, and also awake
			wolf.X = memory.read_u32_le(pointer_wolf)	--Address pointed by pointer + 0x0
			wolf.Y = memory.read_u32_le(pointer_wolf+0x4)	--Address pointed by pointer + 0x4
			wolf.Z = memory.read_u32_le(pointer_wolf+0x8)	--Address pointed by pointer + 0x8
			wolf.XSpeed = memory.read_s32_le(pointer_wolf+0x38)	--Address pointed by pointer + 0x38
			wolf.YSpeed = memory.read_s32_le(pointer_wolf+0x3C)	--Address pointed by pointer + 0x3C	
			
			gui.drawText(0,70,"wolf",null,null,10,null,null)
			gui.drawText(0,80,"X"..string.format('%.6f',wolf.X/65536.0).." Y"..string.format('%.6f',wolf.Y/65536.0),null,null,10,null,null)
			gui.drawText(0,90,"SpdX"..string.format('%.6f',wolf.XSpeed/65536.0).." SpdY"..string.format('%.6f',wolf.YSpeed/65536.0),null,null,10,null,null)
			gui.drawText(0,100,"Z"..string.format('%.6f',wolf.Z/65536.0),null,null,10,null,null)
			gui.drawText(0,110,bizstring.hex(pointer_wolf),null,null,10,null,null)
			--Predict when will screen fade
			if fade_timer > 0 then
				fade_frame = fade_timer+emu.framecount()+22		--frame ends on 21, but lags 1 frame
				
			end	
			gui.drawText(0,120,"Fade frame:"..fade_frame,null,null,10,null,null)
			
			
			end
			
		end
		gui.drawText(0,30,"X"..string.format('%.6f',player.X/65536.0).." Y"..string.format('%.6f',player.Y/65536.0),null,null,10,null,null)
		gui.drawText(0,40,"SpdX"..string.format('%.6f',player.XSpeed/65536.0).." SpdY"..string.format('%.6f',player.YSpeed/65536.0),null,null,10,null,null)
		gui.drawText(0,50,"Z"..string.format('%.6f',player.Z/65536.0),null,null,10,null,null)
		
		--Pointer for debugging
		gui.drawText(50,10,bizstring.hex(pointer),null,null,10,null,null)
		
		--Frame counter thing that determines end acceleration
		gui.drawText(0,60,"Frame:"..frame,null,null,10,null,null)
		
		if (player.Phoenix > 0) then	--Since when wulf appears, you cannot use the pheonix, this shouldn't be able to overlap. Probably.
			gui.drawText(0,70,"Birb:"..player.Phoenix,null,null,10,null,null)
		end
		--lab lift
			gui.drawText(50,20,memory.read_s8(0x57AA),null,null,10,null,null)

		end
	emu.frameadvance()
end
