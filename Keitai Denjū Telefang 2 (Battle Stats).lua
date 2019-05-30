memory.usememorydomain("IWRAM")

--[[
This script creates a text file that displays the following:
* Which frame will the move miss
* Which frame will the move land a critical hit, and how much damage
* Which frame will the Denjuu's partner/ally appear
* Which frame will the enemy choose which move
This is for assisting making a TAS, and is completely useless in normal play
]]--
local telefang_data = require 'telefang2 data'
local Speed = telefang_data.Speed
local Power = telefang_data.Power
local Attacks = telefang_data.Attacks
local Denjuu = telefang_data.Denjuu
local Items = telefang_data.Items
local Map = telefang_data.Map

--Check if power or speed version; they have addresses in different places
function version()
	if memory.read_u32_le(0x0000A8,"ROM") == 0x574F5032 then
		return "Power"
	elseif memory.read_u32_le(0x0000A8,"ROM") == 0x45505332 then
		return "Speed"
	else
		return "NA"
	end
end

local framelimit = 500
--[[
Since its determined as 
"Move used" followed by
"Miss/Hit" followed by 
"Damage/Crit" followed by
"Ally"
in that order, all separately, it makes more sense to have a toggle rather than record all 4
Toggle parameters are Crit, Moves, Miss, or Ally
]]--
local toggle = {[5]="Crit",[31]="Ally",[36]="Moves",[63]="Miss"}
--for readability later
local value_names = {["Crit"] = 5, ["Ally"] = 31, ["Moves"] = 36, ["Miss"] = 63}
--In Hex, the above is 0x5, 0x1F, 0x24, 0x3F,  respectively
while true do
local Addresses
local RNG1 
local RNG2
local miss
local crit
local ally
while version() ~= "NA" do
		Addresses = (version() == "Power" and Power or Speed)
		State = memory.readbyte(Addresses.Battle_State)
		RNG1 = memory.read_u32_le(Addresses.RNG1)
		RNG2 = memory.read_u32_le(Addresses.RNG2)
		if toggle[State] == nil then
			console.log("Please start the script at the states 5, 31, 36 or 63")
			console.log("In Hex, the above is 0x5, 0x1F, 0x24, 0x3F respectively")
			console.log("RNG is:")
			console.log(memory.read_u32_le(0x5E08).."\t"..memory.read_u32_le(0x5E10))
			client.pause()
		end
	--Just in case something happens that causes map to go above 170
		--Checking if in battle
		if (memory.readbyte(Addresses.Music) >= 6 and memory.readbyte(Addresses.Music) <= 9) then
			gui.text(0,235,"Battle State: "..memory.readbyte(Addresses.Battle_State))
			savestate.saveslot(1)
			if toggle[State] == "Crit" then
				file = io.open("Crit.txt","w")
				io.output(file)
				io.write("Frames\tCounter\tDamage\tCrit\r\n")
				for i = 0, framelimit do
					memory.writebyte(Addresses.Battle_State,value_names["Crit"])	--To keep it at 5
					memory.write_u32_le(Addresses.RNG1,RNG1)
					memory.write_u32_le(Addresses.RNG2,RNG2)
					crit = (memory.readbyte(Addresses.Crit) == 1 and "Yes" or "No")
					io.write(emu.framecount().."\t"..memory.read_u32_le(Addresses.Counter).."\t"..memory.readbyte(Addresses.Damage).."\t"..crit.."\r\n")
					emu.frameadvance()
				end
				io.close(file)
			elseif toggle[State] == "Moves" then
				file = io.open("Moves.txt","w")
				io.output(file)
				io.write("Frames\tCounter\tMove\r\n")
				for i = 0, framelimit do
					memory.writebyte(Addresses.Battle_State,value_names["Moves"])	--To keep it at 0x24
					memory.write_u32_le(Addresses.RNG1,RNG1)
					memory.write_u32_le(Addresses.RNG2,RNG2)
					if (memory.readbyte(Addresses.Move) > 199) then
						io.write(emu.framecount().."\t"..memory.read_u32_le(Addresses.Counter).."\t"..Attacks[0].." ("..memory.readbyte(Addresses.Move)..")\r\n")
					else
						io.write(emu.framecount().."\t"..memory.read_u32_le(Addresses.Counter).."\t"..Attacks[memory.readbyte(Addresses.Move)].." ("..memory.readbyte(Addresses.Move)..")\r\n")
					end
					emu.frameadvance()
				end
				io.close(file)
			elseif toggle[State] == "Miss" then
				file = io.open("Miss.txt", "w")
				io.output(file)
				io.write("Frames\tCounter\tMiss\tValue\r\n")
				for i = 0, framelimit do
					memory.writebyte(Addresses.Battle_State,value_names["Miss"])	--To keep it at 0x3F
					memory.write_u32_le(Addresses.RNG1,RNG1)
					memory.write_u32_le(Addresses.RNG2,RNG2)
					if (memory.readbyte(Addresses.Miss) == 61) then
						miss = "Hit"
					elseif (memory.readbyte(Addresses.Miss) == 64) then
						miss = "Miss"
					else
						miss = "UNDEF"
					end
					io.write(emu.framecount().."\t"..memory.read_u32_le(Addresses.Counter).."\t"..miss.."\t"..memory.readbyte(Addresses.Miss).."\r\n")
					emu.frameadvance()
				end
				io.close(file)
			elseif toggle[State] == "Ally" then
				file = io.open("Ally.txt", "w")
				io.output(file)
				io.write("Frames\tCounter\tAlly\tValue\r\n")
				for i = 0, framelimit do
					memory.writebyte(Addresses.Battle_State,value_names["Ally"])	--To keep it at 0x1F, or else it goes away
					--press A once in 0x1F to get 0x88, then another frame to find result
					savestate.saveslot(1)
					joypad.set({A = 1})
					emu.frameadvance()
					emu.frameadvance()
					if (memory.readbyte(Addresses.Battle_State) == 0x89) then
						ally = "No"
					elseif (memory.readbyte(Addresses.Battle_State) == 0x55) then
						ally = "Yes"
					else
						ally = "UNDEF"
					end
					io.write(emu.framecount().."\t"..memory.read_u32_le(Addresses.Counter).."\t"..ally.."\t"..memory.readbyte(Addresses.Battle_State).."\r\n")
					savestate.loadslot(1)
					emu.frameadvance()
				end
				io.close(file)
			end
		end
		break
	end
	client.pause()
	break
end
