-- Original source: http://tasvideos.org/userfiles/info/19833044932372339
-- By Slamo, with modifications from me and mugg
memory.usememorydomain("WRAM")
local x, y, camx, camy, tref, ttype, ttypehigh, tcolor, warpdest
local address = {
	gbc = {
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
		camx = 0x1652,
		camy = 0x1651,
		tref = 0x16EB,
		stageid = 0x0510
	}
}

local tiles = {
	gbc = {
		[0x47bc] = "Switch platform",
		[0x49cb] = "Slideable slope (left)", --Press down to roll
		[0x495e] = "Slideable slope (right)", --Press down to roll
		[0x4a10] = "Platform",
		[0x4a33] = "Platform (NPC)", --NPCs can walk on them, you cannot
		[0x4a70] = "Breakable",	--(ttype>0x4a70) and (ttype<0x4d9f) or (ttype==0x4a10) 
		[0x4a7e] = "Breakable", --From Stage 34
		[0x4bd2] = "Breakable", --From Stage 34
		[0x4b6e] = "Breakable", --From Stage 34
		[0x4cef] = "Breakable", --From Stage 34
		[0x4d9f] = "Breakable",
		[0x4da0] = "Breakable (NPC)", --throw npcs to destroy them
		[0x4e8a] = "Water",
		[0x4fbe] = "Minigame",	--varies by stage
		[0x4ecd] = "Minigame",	--varies by stage
		[0x4edb] = "Door",
		[0x4ef6] = "Boss door",	--varies by stage
		[0x4f3a] = "Exit",
		[0x4f60] = "Secret exit",
		[0x4ffb] = "Switch",
		[0x50ff] = "Water Current",
		[0x53bb] = "Light"		--Cures zombieism
	},
	gb = {
		[0x47bc] = "Switch platform",
		[0x49cb] = "Slideable slope (left)",
		[0x495e] = "Slideable slope (right)",
		[0x4a10] = "Platform",
		[0x4a33] = "Platform (NPC)", --NPCs can walk on them, you cannot
		[0x4a70] = "Breakable",	--(ttype>0x4a70) and (ttype<0x4d9f) or (ttype==0x4a10) 
		[0x4ae1] = "Breakable", --From Stage 34
		[0x4b6e] = "Breakable", --From Stage 34
		[0x4bd2] = "Breakable", --From Stage 34
		[0x4cf3] = "Breakable",	--From Stage 0
		[0x4cfb] = "Breakable",	--From Stage 0
		[0x4cff] = "Breakable",	--From Stage 0
		[0x4d03] = "Breakable",	--From Stage 0
		[0x4d9f] = "Breakable",
		[0x4d95] = "Breakable (NPC)", --throw npcs to destroy them
		[0x4d99] = "Breakable (NPC)", --throw npcs to destroy them
		[0x4e83] = "Water",
		[0x4fb7] = "Minigame",
		[0x4ec6] = "Door",		--From Stage 0
		[0x4ed4] = "Door",
		[0x4eef] = "Boss door",
		[0x4f33] = "Exit",
		[0x4f59] = "Secret exit",
		[0x4cef] = "Breakable (Invisible)",
		[0x4ff4] = "Switch",
		[0x50fb] = "Water",
		[0x5374] = "Light"		--Cures zombieism
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
function display_npc(x, y, camx, camy)
	for i = 0x1000, 0x10FF, 32 do
		 if memory.readbyte(i+0) > 0 then	--coins grabbed seems to make it 2 or 3
			local xenemy = memory.read_u16_le(i+5)
			local yenemy = memory.read_u16_le(i+3)
			local ecamx = (xenemy-x)+camx
			local ecamy = (yenemy-y)+camy
			gui.drawBox(ecamx-16,ecamy-32,ecamx,ecamy-16,0x8611759E)
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
	display_npc(x, y, camx, camy)
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
					if (game_tiles[ttype]=="Door") then --Regular door
						tcolor = 'SILVER' 
					elseif (game_tiles[ttype]=="Boss door") then --Boss door
						tcolor = 'GREEN'
					elseif (game_tiles[ttype]=="Minigame") then -- Minigame
						tcolor = 'PURPLE'
					elseif (game_tiles[ttype]=="Exit") then -- exit
						tcolor = 'CYAN'
					elseif (game_tiles[ttype]=="Secret exit") then --secret exit
						tcolor = 'GOLD'
						console.log("!!")
					elseif (game_tiles[ttype]=="Water") then -- water
						tcolor = 'BLUE'
					elseif (game_tiles[ttype]=="Platform") then -- platform
						tcolor = 'WHITE'
					elseif (game_tiles[ttype]=="Platform (NPC)") then -- platform
						tcolor = 'GREY'
					elseif (game_tiles[ttype]=="Slideable slope (left)") or (game_tiles[ttype]=="Slideable slope (right)")  then -- platform
						tcolor = 'BROWN'
					elseif (ttype>0x4a70) and (ttype<0x4d9f) then -- breakable
						tcolor = 'PINK'
					elseif (game_tiles[ttype]=="Breakable") then 
						tcolor = 'PINK'
					elseif (game_tiles[ttype]=="Breakable (NPC)") then
						tcolor = 'DEEPPINK'
					elseif (game_tiles[ttype]=="Light") then
						tcolor = 'LIME'
					else -- solid or unknown
						tcolor = 'RED' 
					end
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
	emu.frameadvance()
end