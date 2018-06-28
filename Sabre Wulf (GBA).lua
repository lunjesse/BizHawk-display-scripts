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
--area consist of name, story boolean, frames until silver, frames until bronze
--story boolean is if the first visit is a story item, or treasure
--frames to X means how many frames you can mess around before the treasure devalues
--c_ variables mean challenge mode times
local area = {[0] = 
--Blackwyche Village
{name = "Campsite Clearing", story = true, silver = 1200, bronze = 1800, c_gold = 510, c_silver = 660, c_bronze = 780}, 
{name = "River Crossing", story = true, silver = 900, bronze = 1800, c_gold = 540, c_silver = 900, c_bronze = 1500},
{name = "Blown Away", story = true, silver = 900, bronze = 1800, c_gold = 480, c_silver = 900, c_bronze = 1500},
{name = "Blackwyche Swamp", story = false, silver = 1200, bronze = 2400, c_gold = 570, c_silver = 840, c_bronze = 1440}, 
{name = "Outlaw Inn", story = false, silver = 1200, bronze = 2400, c_gold = 720, c_silver = 900, c_bronze = 1500}, 
{name = "Eastern Karnath", story = false, silver = 1500, bronze = 2700, c_gold = 870, c_silver = 2100, c_bronze = 2700}, 
{name = "Wishing Well", story = false, silver = 1500, bronze = 2880, c_gold = 840, c_silver = 1500, c_bronze = 2100}, 
{name = "Blackwyche Laboratory", story = true, silver = 0, bronze = 0, c_gold = 0, c_silver = 0, c_bronze = 0},
 --Karnath Jungle
{name = "Karnath Canopy", story = false, silver = 1500, bronze = 2880, c_gold = 840, c_silver = 1200, c_bronze = 1800}, 
{name = "Tangle Terror", story = false, silver = 1500, bronze = 2880, c_gold = 840, c_silver = 1380, c_bronze = 1980}, 
{name = "Lower Karnath Mines", story = true, silver = 1800, bronze = 3300, c_gold = 1410, c_silver = 1980, c_bronze = 2580}, 
{name = "Overgrown Outpost", story = false, silver = 1800, bronze = 3300, c_gold = 600, c_silver = 720, c_bronze = 1320}, 
{name = "Knightlore Falls", story = false, silver = 2400, bronze = 4200, c_gold = 720, c_silver = 960, c_bronze = 1560}, 
{name = "Upper Karnath Mines", story = false, silver = 2400, bronze = 4200, c_gold = 1740, c_silver = 2280, c_bronze = 2880}, 
{name = "Tangle Terror Lookout", story = true, silver = 2100, bronze = 3780, c_gold = 840, c_silver = 1920, c_bronze = 2520}, 
{name = "Karnath Laboratory", story = true, silver = 0, bronze = 0, c_gold = 0, c_silver = 0, c_bronze = 0}, 
--Underwurlde Mines
{name = "Torchlight Torment", story = false, silver = 1800, bronze = 3300, c_gold = 900, c_silver = 1380, c_bronze = 1980}, 
{name = "Deep Dark Dugout", story = true, silver = 1800, bronze = 3300, c_gold = 1140, c_silver = 1680, c_bronze = 2280}, 
{name = "Stinky Cavern", story = false, silver = 2400, bronze = 4200, c_gold = 960, c_silver = 1500, c_bronze = 2100},
{name = "Mining Mayhem", story = false, silver = 2100, bronze = 3780, c_gold = 1020, c_silver = 1500, c_bronze = 2100}, 
{name = "Lookout Ledge", story = false, silver = 2400, bronze = 4200, c_gold = 1380, c_silver = 1800, c_bronze = 2400}, 
{name = "Crumble Crevice", story = false, silver = 2400, bronze = 4200, c_gold = 1200, c_silver = 1500, c_bronze = 2100}, 
{name = "Stranglehold Swamp", story = false, silver = 1800, bronze = 3300, c_gold = 720, c_silver = 1620, c_bronze = 2220}, 
{name = "Underwurlde Laboratory", story = true, silver = 0, bronze = 0, c_gold = 0, c_silver = 0, c_bronze = 0}, 

{name = "Stinger Strangle", story = false, silver = 3000, bronze = 5100, c_gold = 900, c_silver = 2160, c_bronze = 2760},
{name = "Frantic Fissure", story = true, silver = 3600, bronze = 6000, c_gold = 1860, c_silver = 2580, c_bronze = 3180},
{name = "Hobbled Hamlet", story = true, silver = 2700, bronze = 4680, c_gold = 1260, c_silver = 1800, c_bronze = 2400},
{name = "Stinkhorn Swamp", story = false, silver = 2100, bronze = 3780, c_gold = 1080, c_silver = 1980, c_bronze = 2580},
{name = "Rocky Mount", story = false, silver = 1800, bronze = 3300, c_gold = 840, c_silver = 1200, c_bronze = 1800}, 
{name = "Viper Vines", story = true, silver = 2100, bronze = 3780, c_gold = 1020, c_silver = 2100, c_bronze = 2700},
{name = "Terror Temple", story = false, silver = 3600, bronze = 6000, c_gold = 1800, c_silver = 2400, c_bronze = 3000},
{name = "Entombed Laboratory", story = true, silver = 0, bronze = 0, c_gold = 0, c_silver = 0, c_bronze = 0},

{name = "Snowy Knoll", story = false, silver = 2400, bronze = 4200, c_gold = 1170, c_silver = 1560, c_bronze = 2160},
{name = "Frosty's Grotto", story = true, silver = 3300, bronze = 5580, c_gold = 2100, c_silver = 2700, c_bronze = 3300},
{name = "Shivery Peaks", story = true, silver = 2100, bronze = 3780, c_gold = 1140, c_silver = 1500, c_bronze = 2100},
{name = "Wafty Shaft", story = false, silver = 3000, bronze = 5100, c_gold = 1080, c_silver = 1680, c_bronze = 2280}, 
{name = "Icy Nook", story = false, silver = 3000, bronze = 5100, c_gold = 1710, c_silver = 2280, c_bronze = 2880},
{name = "Gusty Gully", story = true, silver = 2400, bronze = 4200, c_gold = 1080, c_silver = 1440, c_bronze = 2040},
{name = "Coalhouse Climb", story = true, silver = 5100, bronze = 8700, c_gold = 2160, c_silver = 3600, c_bronze = 4800}, 
{name = "Knightlore Laboratory", story = true, silver = 0, bronze = 0, c_gold = 0, c_silver = 0, c_bronze = 0},

{name = "Flames of Fury", story = false, silver = 2700, bronze = 4380, c_gold = 1500, c_silver = 2100, c_bronze = 2700},
{name = "Ritval Ruins", story = false, silver = 2400, bronze = 4200, c_gold = 1650, c_silver = 2400, c_bronze = 3000}, 
{name = "Filthy Factory", story = false, silver = 3000, bronze = 5100, c_gold = 1380, c_silver = 2100, c_bronze = 2700},
{name = "Mortar Mountain", story = false, silver = 2400, bronze = 4200, c_gold = 1500, c_silver = 2640, c_bronze = 3240}, 
{name = "Industrial Carnage", story = false, silver = 3000, bronze = 4680, c_gold = 1500, c_silver = 1920, c_bronze = 2520},
{name = "House on the Hill", story = false, silver = 4800, bronze = 8400, c_gold = 2520, c_silver = 3960, c_bronze = 4560},
{name = "Heavy Metal", story = true, silver = 4500, bronze = 7500, c_gold = 2100, c_silver = 3600, c_bronze = 4200},
{name = "Nightshade Laboratory", story = true, silver = 0, bronze = 0, c_gold = 0, c_silver = 0, c_bronze = 0},

{name = "Tumbledown Temple", story = false, silver = 3300, bronze = 5580, c_gold = 1560, c_silver = 2400, c_bronze = 3000}, 
{name = "Watch Out Below", story = true, silver = 2100, bronze = 3780, c_gold = 1200, c_silver = 1800, c_bronze = 2400},
{name = "Magical Mayhem", story = false, silver = 2400, bronze = 4200, c_gold = 1500, c_silver = 2520, c_bronze = 4200},
{name = "Town and Out", story = true, silver = 3300, bronze = 5580, c_gold = 2100, c_silver = 2400, c_bronze = 3000}, 
{name = "Wings of Steel", story = false, silver = 3600, bronze = 6000, c_gold = 1500, c_silver = 2580, c_bronze = 3180},
{name = "Craggy Crack", story = false, silver = 4800, bronze = 8400, c_gold = 1860, c_silver = 2520, c_bronze = 3000}, 
{name = "This Old House", story = true, silver = 2400, bronze = 4200, c_gold = 1380, c_silver = 2520, c_bronze = 3600}, 
{name = "Imhotep Laboratory", story = true, silver = 0, bronze = 0, c_gold = 0, c_silver = 0, c_bronze = 0},

{name = "Rooftop Rampage", story = false, silver = 2700, bronze = 4380, c_gold = 1830, c_silver = 3000, c_bronze = 3600},
{name = "Temple Plains", story = false, silver = 2700, bronze = 4380, c_gold = 1440, c_silver = 1980, c_bronze = 2580}, 
{name = "Cluster Keep", story = false, silver = 3000, bronze = 5100, c_gold = 2160, c_silver = 2280, c_bronze = 2880},
{name = "Factory Furnace", story = false, silver = 3300, bronze = 5580, c_gold = 1980, c_silver = 2640, c_bronze = 3600}, 
{name = "Bind Alley", story = false, silver = 3000, bronze = 5100, c_gold = 1920, c_silver = 3600, c_bronze = 4200}, 
{name = "Firing Squad", story = false, silver = 1800, bronze = 3300, c_gold = 1110, c_silver = 3000, c_bronze = 3600}, 
{name = "Cobbled Courtyard", story = false, silver = 5400, bronze = 8400, c_gold = 3000, c_silver = 4200, c_bronze = 4800}, 
{name = "Dragonskulle Laboratory", story = true, silver = 0, bronze = 0, c_gold = 0, c_silver = 0, c_bronze = 0}
}

local challenge_times =  {
--Blackwyche Village
[0] = area[0].c_gold, area[1].c_gold, area[2].c_gold, area[3].c_gold, area[4].c_gold, area[5].c_gold, area[6].c_gold,
--Karnath Jungle
 area[8].c_gold,  area[9].c_gold, area[10].c_gold, area[11].c_gold, area[12].c_gold, area[13].c_gold, area[14].c_gold,
--Underwurlde Mines
 area[16].c_gold,  area[17].c_gold, area[18].c_gold, area[19].c_gold, area[20].c_gold, area[21].c_gold, area[22].c_gold,
--Entombed Swamp
 area[24].c_gold,  area[25].c_gold, area[26].c_gold, area[27].c_gold, area[28].c_gold, area[29].c_gold, area[30].c_gold,
--Mount Knightlore
 area[32].c_gold,  area[33].c_gold, area[34].c_gold, area[35].c_gold, area[36].c_gold, area[37].c_gold, area[38].c_gold,
--Nightshade Mining Company
 area[40].c_gold,  area[41].c_gold, area[42].c_gold, area[43].c_gold, area[44].c_gold, area[45].c_gold, area[46].c_gold,
--Temple of Imhotep
 area[48].c_gold,  area[49].c_gold, area[50].c_gold, area[54].c_gold, area[52].c_gold, area[53].c_gold, area[51].c_gold,
--Dragonskulle Town
 area[56].c_gold,  area[57].c_gold, area[58].c_gold, area[59].c_gold, area[60].c_gold, area[61].c_gold, area[62].c_gold}

--Addresses
local map = 0x01A4	--read_s8
--If you want to change stages, use 0x1410 instead
local treasure_timer = 0x0230	--read_u32_le
local treasure_state = 0x53BA	--read_s8
local fade_timer = 0x5354	--read_s8
local frame = 0x0190	--read_u32_le
local lab_lift = 0x57AA	--read_s8
local challenge_timer = 0x4244
local c_record = 0x05E6
local c_record2 = 0x0654

function update(address)
	local pointer = memory.read_u32_le(address)
	if pointer > 0x3000000 and pointer < 0x4000000 then
		return pointer-0x3000000	--Minus (0x3000000) since BizHawk memory domains
	end
	return nill
end

function stage_info()
	local color = "white"
	local message = ""
	local l_map = memory.read_s8(map)
	local l_treasure_timer = memory.read_u32_le(treasure_timer)	--stage timer for treasures
	if area[l_map] ~= nil then
			--gui.drawText(50,0,map,null,null,10,null,null)
			if l_treasure_timer >= area[l_map].silver and l_treasure_timer < area[l_map].bronze then
				color = "silver"
				message = l_treasure_timer.."/"..area[l_map].bronze
			elseif treasure_timer >= area[l_map].bronze then
				color = "chocolate"
				message = "too late"
			else
				color = "white"
				message = l_treasure_timer.."/"..area[l_map].silver
			end
			gui.drawText(50,0,area[l_map].name.."("..l_map..")","white",null,10,null,null)
			gui.drawText(50,10,message,color,null,10,null,null)
		end
end

--For display things relevant everywhere else
function display_position_info()
	local l_fade_timer = memory.read_s8(fade_timer)
	local l_frame = memory.read_u32_le(frame)	--In stage timer in frames
	local pointer = update(player.Pointer)
	local pointer_wolf = update(wolf.Pointer)
	local fade_frame = 0
	if pointer ~= nill then	--this means player exists
		player.X = memory.read_u32_le(pointer)	--Address pointed by pointer + 0x0
		player.Y = memory.read_u32_le(pointer+0x4)	--Address pointed by pointer + 0x4
		player.Z = memory.read_u32_le(pointer+0x8)	--Address pointed by pointer + 0x8
		player.XSpeed = memory.read_s32_le(pointer+0x38)	--Address pointed by pointer + 0x38
		player.YSpeed = memory.read_s32_le(pointer+0x3C)	--Address pointed by pointer + 0x3C
		player.Phoenix = memory.read_u32_le(pointer+0x20) 
		--Place things that are relevant outside the chase below
		gui.drawText(0,30,"X"..string.format('%.6f',player.X/65536.0).." Y"..string.format('%.6f',player.Y/65536.0),null,null,10,null,null)
		gui.drawText(0,40,"SpdX"..string.format('%.6f',player.XSpeed/65536.0).." SpdY"..string.format('%.6f',player.YSpeed/65536.0),null,null,10,null,null)
		gui.drawText(0,50,"Z"..string.format('%.6f',player.Z/65536.0),null,null,10,null,null)
		
		--Pointer for debugging
		--gui.drawText(50,10,bizstring.hex(pointer),null,null,10,null,null)
		
		if (player.Phoenix > 0) then	--Since when wulf appears, you cannot use the pheonix, this shouldn't be able to overlap. Probably.
			gui.drawText(0,70,"Birb:"..player.Phoenix,null,null,10,null,null)
		end
		--lab lift
			--gui.drawText(50,20,memory.read_s8(0x57AA),null,null,10,null,null)
	end
end

--For display things relevant during the wolf chase
function display_chase_info()
	local l_fade_timer = memory.read_s8(fade_timer)
	local l_frame = memory.read_u32_le(frame)	--In stage timer in frames
	local pointer_wolf = update(wolf.Pointer)
	local fade_frame = 0
	if pointer_wolf ~= nill then	--this means wolf exists
		if memory.read_s32_le(pointer_wolf) > 0 and memory.readbyte(pointer_wolf+0x66) == 3 then	--Wolf is present, and also awake
		wolf.X = memory.read_u32_le(pointer_wolf)	--Address pointed by pointer + 0x0
		wolf.Y = memory.read_u32_le(pointer_wolf+0x4)	--Address pointed by pointer + 0x4
		wolf.Z = memory.read_u32_le(pointer_wolf+0x8)	--Address pointed by pointer + 0x8
		wolf.XSpeed = memory.read_s32_le(pointer_wolf+0x38)	--Address pointed by pointer + 0x38
		wolf.YSpeed = memory.read_s32_le(pointer_wolf+0x3C)	--Address pointed by pointer + 0x3C	
	--Place things that are relevant during the chase below.
		gui.drawText(0,70,"wolf",null,null,10,null,null)
		gui.drawText(0,80,"X"..string.format('%.6f',wolf.X/65536.0).." Y"..string.format('%.6f',wolf.Y/65536.0),null,null,10,null,null)
		gui.drawText(0,90,"SpdX"..string.format('%.6f',wolf.XSpeed/65536.0).." SpdY"..string.format('%.6f',wolf.YSpeed/65536.0),null,null,10,null,null)
		gui.drawText(0,100,"Z"..string.format('%.6f',wolf.Z/65536.0),null,null,10,null,null)
		--Pointer for debugging
		gui.drawText(0,110,bizstring.hex(pointer_wolf),null,null,10,null,null)
		--Predict when will screen fade; only relevant if wolf exists
			if l_fade_timer > 0 then
				fade_frame = l_fade_timer+emu.framecount()+22		--frame ends on 21, but lags 1 frame
			end	
			gui.drawText(0,120,"Fade frame:"..fade_frame,null,null,10,null,null)
			--Frame counter thing that determines end acceleration
			gui.drawText(0,60,"Frame:"..l_frame,null,null,10,null,null)
		end
	end
end

--Given the address, percent, and bits to check return %
function check_percent(address, percent,...)
	local l_address = memory.read_s8(address)
	local result = 0
	for i, v in ipairs({...}) do
		if bit.check(l_address, v) then result = result + percent end
	end
	return result
end

function challenge_percent()
	local record = 0
	local percent = 0
	for i = 0, 55, 1 do
		record = memory.read_u16_le(c_record+0x2*i)	--weird way to increment 0x05E6, sorry
		--Game does not count toward % if your record was 0 using cheats, so this check works
		if record <= challenge_times[i] and record > 0 then
			percent = percent + 0.1
		end
	end
	return percent
end

function display_percent()
	--split them to 0.1%, 0.3%, 0.4%, 0.5%, 1.0%, 1.1%, 1.5%, 2.0% for ease of debugging
	local p01, p03, p04, p05, p10, p11, p15, p20 = 0, 0, 0, 0, 0, 0, 0, 0
	local percent = 0
	--05E6 challenge mode best time 1st stage
	--0654 is last stage
	--Test by checking if the time is less than c_gold value for each stage.
	--56 stages; each 0.1%
	
	percent = 0.1
	p01 = p01 + check_percent(0x02B9,percent,7,6,5,4,3,2)
	+ check_percent(0x02BA,percent,7,6,5,4,3,2,1,0)
	+ check_percent(0x02BB,percent,7,6,5,4,3,2,1,0)
	+ check_percent(0x02BC,percent,7,6,5,4,3,2,1,0)
	+ check_percent(0x02BD,percent,7,6,5,4,3,2,1,0)
	+ check_percent(0x02BE,percent,7,6,5,4,3,2,1,0)
	+ check_percent(0x02BF,percent,7,6,5,4,3,2,1,0)
	+ check_percent(0x02C0,percent,7,6,5,4,3,2,1,0)
	+ check_percent(0x02C1,percent,1,0)
	+ check_percent(0x02C9,percent,2)
	+ check_percent(0x02CB,percent,6,5)
	+ check_percent(0x02CC,percent,6,5,4,0)
	+ check_percent(0x02CD,percent,7,6,5,4,3,0)
	+ check_percent(0x02CE,percent,4,3,2,1,0)
	
	--0.3% things; Mayor's key
	percent = 0.3
	p03 = p03 + check_percent(0x02C2,percent,3)
	
	--0.4% things
	percent = 0.4
	p04 = p04 + check_percent(0x02C2,percent,5)	--camera
	+ check_percent(0x02CE,percent,6)	--compass
	
	--0.5% things
	percent = 0.5
	--gold keys
	p05 = p05 + check_percent(0x02C1,percent,7,6,5,4,3)
	+ check_percent(0x02C2,percent,2,1,0)
	--Bonus rooms
	+ check_percent(0x02D0,percent,7,6,5,4)
	+ check_percent(0x02D1,percent,3,2,1,0)
	
	--1% things; almost all of it are treasure items
	percent = 1.00
	p10 = p10 + check_percent(0x02B2,percent,7,6,5,4,3,2)
	+ check_percent(0x02B3,percent,7,4,3,2,0)
	+ check_percent(0x02B4,percent,5,4,3,2,1)
	+ check_percent(0x02B5,percent,7,4,3,1,0)
	+ check_percent(0x02B6,percent,7,6,5,4,3,0)
	+ check_percent(0x02B7,percent,7,6,5,3,1,0)
	+ check_percent(0x02B8,percent,5,4,3,2,1,0)
	+ check_percent(0x02B9,percent,0)
	--medallions
	+ check_percent(0x02C3,percent,7,6,5,4,3,2,1,0)
	
	--1.1% things; almost all of it is story related
	percent = 1.10
	p11 = p11 + check_percent(0x02B2,percent,1,0)
	+ check_percent(0x02B3,percent,5,1)
	+ check_percent(0x02B4,percent,7,6,0)
	+ check_percent(0x02B5,percent,6,5,2)
	+ check_percent(0x02B6,percent,2,1)
	+ check_percent(0x02B7,percent,4,2)
	+ check_percent(0x02B8,percent,7,6)
	
	--1.5% things; cow costume
	percent = 1.5
	p15 = p15 + check_percent(0x02C9,percent,6)
	
	--2.0% things; all orchids
	percent = 2.0
	p20 = p20 + check_percent(0x02CE,percent,7)
	+ check_percent(0x02CF,percent,3,2,1,0)
	
	percent = p01 + p03 + p04 + p05 + p10 + p11 + p15 + p20 + challenge_percent()
	gui.drawText(0,100,"%"..percent,null,null,10,null,null)
	-- gui.drawText(0,115,"0.1%, 0.3%, 0.4%, 0.5%, 1.0%, 1.1%, 1.5%, 2.0%",null,null,10,null,null)
	-- gui.drawText(0,130,p01..", "..p03..", "..p04..", "..p05..", "..p10..", "..p11..", "..p15..", "..p20,null,null,10,null,null)
	
end



while true do
	--For treasure evaluation
	--local l_state = memory.read_s8(treasure_state)
	stage_info()
	display_position_info()
	display_chase_info()
	display_percent()
	emu.frameadvance()
end
