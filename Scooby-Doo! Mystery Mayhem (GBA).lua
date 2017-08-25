memory.usememorydomain("Combined WRAM")
--[[
Scooby's address + 0xBC is shaggy, so no need to find both
x = something
y = +0x4
speedx = +0x4 or +0x8
speedy = +0x4 or +0x8
ground bool = +0x2C
sneak status = +0x3D
character "state" = +0x3E
Addresses work on both (E) and (U) versions
Character addresses in terms of 0006B9
0006B8 - rooms you appear in
0006B9 - room
0006BA - door within room
Unused/Differences below:
0x00 - ASM
0x01 - Language Select (Only usually appears in (E) unless cheat)
0x02 - Stage intro dialogue (Library)
0x03 - Stage intro dialogue (Milton Bros Studio)
0x04 - Stage intro dialogue (Lab)
0x05 - Stage intro dialogue (Wild West)
0x06 - Stage intro dialogue (Bayou)
0x07 - Stage intro dialogue (Lab)
0x08 - Stage intro dialogue (Lab)
0x09 - Game over
0x0A - Stage intro + Menu
0x0B - Credits
0x0C - Stage intro dialgoue (Van)
0x12 - Despite being the boss stage for stage 1, entering it via cheats changes the pos addresses.
0x22 - Reuniting with Shaggy changes the positions
x = 0x029654, y = 0x029658, speedx = 0x02965C, speedy = 0x029660 - before 
x = 0x029708, y = 0x02970C, speedx = 0x029710, speedy = 0x029714 - after
0x60 - Copyright
0x61 - Developed by
0x62 - Options menu
0x68 - Load game
0x69 - THQ
0x6A - Start
0x6B - Warner Bros
]]--
	local posaddress = {
	[0x0D] = {x = 0x0156A8, y =0x0156AC, speedx = 0x0156B0, speedy = 0x0156B4},
	[0x0E] = {x = 0x01BB74, y = 0x01BB78, speedx = 0x01BB7C, speedy = 0x01BB80},
	[0x0F] = {x = 0x019EA0, y = 0x019EA4, speedx = 0x019EA8, speedy = 0x019EAA},
	[0x10] = {x = 0x01F488, y = 0x01F48A, speedx = 0x01F490, speedy = 0x01F494},
	[0x11] = {x = 0x020504, y = 0x020508, speedx = 0x02050C, speedy = 0x020510},
	[0x12] = {x = 0x0143AC, y = 0x0143B0, speedx = 0x0143B4, speedy = 0x0143B8},
	[0x13] = {x = 0x018FA4, y = 0x018FA8, speedx = 0x018FAC, speedy = 0x018FB0},
	[0x14] = {x = 0x01ABF0, y = 0x01ABF4, speedx = 0x01ABF8, speedy = 0x01ABFC},
	[0x15] = {x = 0x01F99C, y = 0x01F9A0, speedx = 0x01F9A4, speedy = 0x01F9A8},
	[0x16] = {x = 0x013BFC, y = 0x013C00, speedx = 0x013C04, speedy = 0x013C08},
	[0x17] = {x = 0x013ECC, y = 0x013ED0, speedx = 0x013ED4, speedy = 0x013ED8},
	[0x18] = {x = 0x013F5C, y = 0x013F60, speedx = 0x013F64, speedy = 0x013F68},
	[0x19] = {x = 0x013C8C, y = 0x013C90, speedx = 0x013C94, speedy = 0x013C98},
	[0x1A] = {x = 0x013D1C, y = 0x013D20, speedx = 0x013D24, speedy = 0x013D28},
	[0x1B] = {x = 0x013D1C, y = 0x013D20, speedx = 0x013D24, speedy = 0x013D28},
	[0x1C] = {x = 0x013D1C, y = 0x013D20, speedx = 0x013D24, speedy = 0x013D28},
	[0x1D] = {x = 0x013824, y = 0x013828, speedx = 0x01382A, speedy = 0x01382C},
	[0x1E] = {x = 0x013CD4, y = 0x013CD8, speedx = 0x013CDC, speedy = 0x013CE0},
	[0x1F] = {x = 0x013FEC, y = 0x013FF0, speedx = 0x013FF4, speedy = 0x013FF8},
	[0x20] = {x = 0x023C28, y = 0x023C2C, speedx = 0x023C30, speedy = 0x023C34},
	[0x21] = {x = 0x01B180, y = 0x01B184, speedx = 0x01B188, speedy = 0x01B18C},
	[0x22] = {x = 0x029708, y = 0x02970C, speedx = 0x029710, speedy = 0x029714},
	[0x23] = {x = 0x01E214, y = 0x01E218, speedx = 0x01E21C, speedy = 0x01E220},
	[0x24] = {x = 0x01933C, y = 0x019340, speedx = 0x019344, speedy = 0x019348}
	}
	local Scooby = {x = 0x000000, y = 0x000000, speedx = 0x000000, speedy = 0x000000}
			
--seems to change at 0x0006C0 = 0x4
--Alternately reassign every hotkey press
function inputdelay(inputs, delay)
	local is = input.get()
	local start = false
	if inputs ~= nil and (is[tostring(inputs)] ~=nil) then
		console.log(is)
		while (delay > 0) do
			emu.frameadvance()
			delay = delay -1
		end
		start = true
		return start
	end
	return start
end
function assign(room)
	if (posaddress[room] ~= nil) then
		Scooby.x = posaddress[room].x
		Scooby.y = posaddress[room].x + 0x4
		Scooby.speedx = posaddress[room].x + 0x8
		Scooby.speedy = posaddress[room].x + 0xC
	else
		Scooby.x = 0x000000
		Scooby.y = 0x000000
		Scooby.speedx = 0x000000
		Scooby.speedy = 0x000000
	end
end

while true do
	--local camx = client.transformPointX(memory.readbyte(Scooby.camx)-20)
	--local camy = client.transformPointY(memory.readbyte(Scooby.camy))
	if inputdelay("K",10) then
		gui.text(0,0,"Hi")	--debugging
		assign(memory.readbyte(0x0006B9))
	end
	if (Scooby.x ~= 0x0) then
		gui.text(0,0,"Scooby:"..string.format('%.6f',memory.read_u32_le(Scooby.x)/65536.0)..","..string.format('%.6f',memory.read_u32_le(Scooby.y)/65536.0)..","..memory.read_s32_le(Scooby.speedx)..","..memory.read_s32_le(Scooby.speedy))
		gui.text(0,30,"Shaggy:"..string.format('%.6f',memory.read_u32_le(Scooby.x+0xBC)/65536.0)..","..string.format('%.6f',memory.read_u32_le(Scooby.y+0xBC)/65536.0)..","..memory.read_s32_le(Scooby.speedx+0xBC)..","..memory.read_s32_le(Scooby.speedy+0xBC))
		gui.text(0,60,"Ghost HP:"..memory.readbyte(0x0113A4))
	end
	gui.text(0,75,"Room ID: 0x"..bizstring.hex(memory.readbyte(0x0006B9)))
	emu.frameadvance()
end
