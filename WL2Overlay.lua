-- Original source: http://tasvideos.org/userfiles/info/19833044932372339
-- By Slamo, with modifications from me and mugg
memory.usememorydomain("WRAM")
local x, y, camx, camy, tref, ttype, ttypehigh, tcolor, warpdest
local address = {
	gbc = {
		npc_base = 0x0000,
		x = 0x153c,
		y = 0x153a,
		camx = 0x660,
		camy = 0x65f,
		tref = 0x704,
		warpdest = 0xa1,
		stageid = 0x1510
	},
	gb = {
		x = 0x053c,
		y = 0x053a,
		npc_base = 0x1000,
		camx = 0x1652,
		camy = 0x1651,
		tref = 0x16EB,
		stageid = 0x0510
	}
}

local tiles = {
	gbc = {
		[0x47bc] = "Switch platform",
		[0x493a] = "Slideable slope (left)", --From Stage 5
		[0x495e] = "Slideable slope (right)", --Press down to roll
		[0x49cb] = "Slideable slope (left)", --Press down to roll
		[0x4a10] = "Platform",
		[0x4a33] = "Platform (NPC)", --NPCs can walk on them, you cannot
		[0x4a5d] = "Platform",	--From Stage 5
		[0x4a70] = "Breakable",	--(ttype>0x4a70) and (ttype<0x4d9f) or (ttype==0x4a10) 
		[0x4a72] = "Breakable", --From Stage 5
		[0x4a7e] = "Breakable", --From Stage 34
		[0x4b62] = "Breakable", --From Stage 5
		[0x4b66] = "Breakable", --From Stage 3
		[0x4b6a] = "Breakable", --From Stage 8
		[0x4bc6] = "Breakable", --From Stage 5
		[0x4bca] = "Breakable", --From Stage 3
		[0x4bce] = "Breakable", --From Stage 8
		[0x4bd2] = "Breakable", --From Stage 34
		[0x4b6e] = "Breakable", --From Stage 34
		[0x4ce7] = "Breakable", --From Stage 2
		[0x4cef] = "Breakable", --From Stage 34
		[0x4cf3] = "Breakable", --From Stage 0
		[0x4cf7] = "Breakable", --From Stage 1
		[0x4cfb] = "Breakable", --From Stage 0
		[0x4cff] = "Breakable", --From Stage 0
		[0x4d03] = "Breakable", --From Stage 0
		[0x4d6b] = "Breakable (Fire)",--From Stage 26
		[0x4d6f] = "Breakable (Fire)",--From Stage 6
		[0x4d73] = "Breakable (Food)",--From Stage 8
		[0x4d9c] = "Breakable (NPC)", --throw npcs to destroy them
		[0x4d9f] = "Breakable",
		[0x4da0] = "Breakable (NPC)", --throw npcs to destroy them; Fromm stage 25
		[0x4da4] = "Breakable (NPC)", --throw npcs to destroy them
		[0x4e8a] = "Water",
		[0x4ea7] = "Warp",		--From Stage 1
		[0x4eba] = "Warp",		--From Stage 5
		[0x4ecd] = "Door",		--From Stage 0
		[0x4edb] = "Door",
		[0x4ef6] = "Boss door",	--varies by stage
		[0x4f3a] = "Exit",
		[0x4f60] = "Secret exit",
		[0x4f86] = "Door",		--From Stage 2
		[0x4f1f] = "Door",		--From Stage 5
		[0x4fbe] = "Minigame",	--varies by stage
		[0x4fda] = "Minigame",	--From Stage 2
		[0x4ffb] = "Switch",
		[0x50ff] = "Water",		--Current
		[0x510f] = "Water",		--Current
		[0x511f] = "Water",		--Current
		[0x5236] = "Spike",		--From stage 36
		[0x53bb] = "Light"		--Cures zombieism
	},
	gb = {
		[0x47bc] = "Switch platform",
		[0x493a] = "Slideable slope (left)", --From Stage 5
		[0x49cb] = "Slideable slope (left)",
		[0x495e] = "Slideable slope (right)",
		[0x4a10] = "Platform",
		[0x4a33] = "Platform (NPC)", --NPCs can walk on them, you cannot
		[0x4a5d] = "Platform",	--From Stage 5
		[0x4a70] = "Breakable",	--(ttype>0x4a70) and (ttype<0x4d9f) or (ttype==0x4a10) 
		[0x4ae1] = "Breakable", --From Stage 34
		[0x4b66] = "Breakable", --From Stage 3
		[0x4b6a] = "Breakable", --From Stage 8
		[0x4b6e] = "Breakable", --From Stage 34
		[0x4bce] = "Breakable", --From Stage 8
		[0x4bd2] = "Breakable", --From Stage 34
		[0x4bca] = "Breakable", --From Stage 3
		[0x4ce7] = "Breakable",	--From Stage 2
		[0x4cef] = "Breakable",	--From Stage 4; apparently could be invisible
		[0x4cf3] = "Breakable",	--From Stage 0
		[0x4cf7] = "Breakable",	--From Stage 1
		[0x4cfb] = "Breakable",	--From Stage 0
		[0x4cff] = "Breakable",	--From Stage 0
		[0x4d03] = "Breakable",	--From Stage 0
		[0x4d64] = "Breakable (Fire)",
		[0x4d6c] = "Breakable (Fire)", --Need to recheck
		[0x4d9f] = "Breakable",
		[0x4d95] = "Breakable (NPC)", --throw npcs to destroy them
		[0x4d99] = "Breakable (NPC)", --throw npcs to destroy them
		[0x4e83] = "Water",
		[0x4ea0] = "Warp",		--From Stage 1
		[0x4eb3] = "Warp",		--From Stage 5
		[0x4fb7] = "Minigame",
		[0x4ec6] = "Door",		--From Stage 0
		[0x4ed4] = "Door",
		[0x4eef] = "Boss door",
		[0x4f18] = "Door",		--From Stage 5
		[0x4f33] = "Exit",
		[0x4f59] = "Secret exit",
		[0x4f7f] = "Door",		--From Stage 2
		[0x4fd3] = "Minigame",	--From Stage 2
		[0x4ff4] = "Switch",
		[0x50fb] = "Water",
		[0x510b] = "Water",		--Current
		[0x5374] = "Light"		--Cures zombieism
	},
	colors = {
		["Door"] = "DARKGRAY",
		["Boss door"] = "Green",
		["Minigame"] = "PURPLE",
		["Exit"] = "CYAN",
		["Secret exit"] = "GOLD",
		["Water"] = "BLUE",
		["Warp"] = "DIMGRAY",
		["Platform"] = "WHITE",
		["Platform (NPC)"] = "LIGHTGRAY",
		["Slideable slope (left)"] = "BROWN",
		["Slideable slope (right)"] = "BROWN",
		["Breakable"] = "PINK",
		["Breakable (NPC)"] = "DEEPPINK",
		["Breakable (Fire)"] = "DEEPPINK",
		["Breakable (Food)"] = "DEEPPINK",
		["Light"] = "LIME"
	}
}


function bitswap (swappy)
	nib2 = bit.band(swappy,0xF)
	return (nib2*0x10+bit.rshift(swappy,4))
end

function gettile (wx,wy)
	hix = bit.rshift(bit.band(0xFF00,wx),8)
	hiy = bit.rshift(bit.band(0xFF00,wy),8)
	lox = bit.band(0xFF,wx)
	loy = bit.band(0xFF,wy)
	ccea = bit.band(bitswap(bit.band(hiy,0x0F))+bit.band(bitswap(loy),0x0F)+0xA0,0xFF)
	cceb = bitswap(bit.band(hix,0x0F))+bit.band(bitswap(lox),0x0F)
	rawloc = ccea*0x100+cceb -- not the final location!!! can vary if above 0xa000
	return (rawloc)
	-- return (bit.band(0x2000 + 0x100*math.floor(wy/16+1) + math.floor(wx/16),0x7FFF)) works for most space, not glitch rooms
end

function tileid (ntile)
	if (ntile >= 0xa000) then
		realloc = ntile - 0x8000
		tlookup = memory.readbyte(realloc,'CartRAM') -- where normal level data is
	else
		realloc = ntile
		tlookup = memory.readbyte(realloc,'System Bus')
	end
	local address = 0x7c002+tref+bit.band(tlookup*2,0xFF)
	local result = memory.read_u16_le(address,'ROM')
	-- -- if result == 0x4f60 then 
	-- if result == 0x4f3a then 
		-- -- memory.write_u16_le(address,0x4f3a)
		-- memory.write_u16_le(address,0x4f60)
	-- end
	return result
end

-- Original source: https://pastebin.com/DFGBfiEF
-- Written by mugg, modified by me to use WRAM instead.
function display_npc(base, x, y, camx, camy)
	for i = base, base+0xFF, 32 do
		 if memory.readbyte(i+0) > 0 then	--coins grabbed seems to make it 2 or 3
			local xenemy = memory.read_u16_le(i+5)
			local yenemy = memory.read_u16_le(i+3)
			local id = memory.readbyte(i+9)
			local ecamx = (xenemy-x)+camx
			local ecamy = (yenemy-y)+camy
			gui.drawBox(ecamx-16,ecamy-32,ecamx,ecamy-16,0x8611759E)
			gui.pixelText(ecamx-16,ecamy-39,id)
			gui.pixelText(ecamx-16,ecamy-32,"X:"..xenemy)
			gui.pixelText(ecamx-16,ecamy-25,"Y:"..xenemy)
		end
	end
end

local game_address = address.gbc
local game_tiles = tiles.gbc

while true do
	if memory.read_u16_le(0x000134, "ROM") == 0x4743 then --ROM says CGB
		game_address = address.gbc
		game_tiles = tiles.gbc
	else
		game_address = address.gb
		game_tiles = tiles.gb
	end
	x = mainmemory.read_u16_be(game_address.x) -- position in level
	y = mainmemory.read_u16_be(game_address.y)
	camx = mainmemory.readbyte(game_address.camx) -- position relative to upper left camera edge
	camy = mainmemory.readbyte(game_address.camy)
	tref = mainmemory.read_u16_be(game_address.tref)
	stageid = memory.readbyte(game_address.stageid)
	display_npc(game_address.npc_base, x, y, camx, camy)
	-- warpdest = mainmemory.readbyte(game_address.warpdest) -- sector coordinates for a warp (??)
	-- 160x144
	-- gui.drawText(3,130,string.format("%X",bit.rshift(warpdest,4))..' '..string.format("%X",bit.band(warpdest,0xF)))
	for i = -1,17,1 do
		for j = -1,17,1 do
			ttype = tileid(gettile(x-camx+15+16*i,y-camy+15+16*j))
			ttypehigh = bit.band(ttype,0xFF00)
			if (ttype~=0x47ab) and (ttype~=0x49a7) and not ((ttype>=0x4e29) and (ttype<=0x4e39)) and not ((ttype>=0x5400) and (ttype<=0x54ff)) then
			--if (ttype~=0x47ab) and (ttype~=0x4cf3) and (ttype~=0x4cef) and (ttype~=0x4d03) and (ttype~=0x4cff) and (ttype~=0x4e29) and (ttype~=0x4e35) and (ttype~=0x4f3a) then
				-- if (ttype==0x4ecd) or (ttype==0x4edb) or (ttype==0x4f3a) or (ttype==0x4f60) then -- door, minigame, exit
					-- tcolor = 'GREEN' 
				if game_tiles[ttype] ~= nil then
					tcolor = tiles.colors[game_tiles[ttype]]
					tcolor = (tcolor ~= nil) and tcolor or "RED"
				end
				gui.drawBox((camx-x)%16-8+16*i,(camy-y)%16-16+16*j,(camx-x)%16+7+16*i,(camy-y)%16+16*j-1,tcolor)
			end
		end
	end
	gui.drawText(3,3,string.format("%X",gettile(x,y-32))..' '..string.format("%X",tileid(gettile(x,y-32))))
	gui.drawText(3,12,string.format("%X",gettile(x,y-16))..' '..string.format("%X",tileid(gettile(x,y-16))))
	gui.drawText(3,21,string.format("%X",gettile(x,y))..' '..string.format("%X",tileid(gettile(x,y))),"BLACK","BLACK")
	gui.drawText(4,22,string.format("%X",gettile(x,y))..' '..string.format("%X",tileid(gettile(x,y))))
	gui.drawText(3,31,"X:"..x.." Y:"..y,"BLACK","BLACK")
	gui.drawText(4,32,"X:"..x.." Y:"..y,"WHITE")
	gui.drawText(3,40,"Stage:"..stageid)
	emu.frameadvance()
end
