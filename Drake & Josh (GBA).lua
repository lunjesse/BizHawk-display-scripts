memory.usememorydomain("Combined WRAM")

	local Player = {ptr = 0x00F678, x = 0x000000, y = 0x000000, speedx = 0x000000, speedy = 0x000000, attention = 0x000000}
function update(name)
	if (name == "Player") then
		local char = memory.read_s32_le(Player.ptr) - 0x02000000
		Player.x = char  + 0xE4
		Player.y = char  + 0xE8
		Player.speedx = char + 0xEC
		Player.speedy = char + 0xF0
		Player.attention = char + 0x706
	end
end

while true do
	local Player_ptr = memory.read_s32_le(Player.ptr)
	if (Player_ptr ~= Player.x-0xE4+0x02000000 and Player_ptr ~= 0) then	--this will happen if changed rooms or just started script
		update("Player")	--placing this here as to not lag my computer :P
	end
	if (Player.x ~= 0x0) then
		gui.text(0,300,"Player:"..string.format('%.6f',memory.read_u32_le(Player.x)/65536.0)..","..string.format('%.6f',memory.read_u32_le(Player.y)/65536.0)..","..memory.read_s32_le(Player.speedx)..","..memory.read_s32_le(Player.speedy))
	gui.text(0,60,"Meter:"..memory.read_s16_le(Player.attention))
	end
	--[[
	gui.text(0,75,"Room ID: 0x"..bizstring.hex(memory.readbyte(0x0006B9)))
	]]--
	gui.text(0,90,"Pointer (Player): 0x"..bizstring.hex(memory.read_s32_le(Player.ptr)))	--debug--
	gui.text(0,105,"Pointer (Player): 0x"..bizstring.hex(Player.attention))	--debug--
	emu.frameadvance()
end
