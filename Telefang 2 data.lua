--Makes spreadsheet-able tables for some data about this game
--Refer to: http://datacrystal.romhacking.net/wiki/Keitai_Denjuu_Telefang_2:ROM_map
--table1 is a list of denjuu, and all 5 moves they could learn
--lvl of 255 means the denjuu does not learn anything that replaces move 2 (ie. no move 5)
--table2 is a list of moves, and all denjuu which can learn it
--move 0 means that denjuu lacks move 5
local telefang_data = require 'Keitai Denjū Telefang 2 data'
local Speed = telefang_data.Speed
local Power = telefang_data.Power
local Attack = telefang_data.Attacks
local Denjuu = telefang_data.Denjuu
local Items = telefang_data.Items
local Map = telefang_data.Map

local offset = 0x17
local start = 0x4F68B8
local end_addr = 0x4F7A99
local move1 = 11
local move2 = 12
local move3 = 13
local move4 = 14
local move5_level = 15	--which level to replace move 2
local move5 = 16	--replaces move 2 at certain levels
function write_table()
	local denjuu_index = 0
	file = io.open("move data.txt","w")
	io.output(file)
	line = "ID\tPhoto\tName\tAttack 1\tType\tID\tAttack 2\tType\tID\tAttack 3\tType\tID\tAttack 4\tType\tID\tAttack 5\tType\tLvl\tID\n"
	io.write(line)
	for i = start, end_addr, offset do
		denjuu_index = math.floor((i-start)/offset)	--gives in terms of 1,2,3...199
		line = denjuu_index.."\t"..Denjuu[denjuu_index].Photo.."\t"..Denjuu[denjuu_index].Name.."\t"
		..Attack[memory.read_u8(i+move1,"ROM")].Name.."\t"..Attack[memory.read_u8(i+move1,"ROM")].Type.."\t"..memory.read_u8(i+move1,"ROM").."\t"
		..Attack[memory.read_u8(i+move2,"ROM")].Name.."\t"..Attack[memory.read_u8(i+move2,"ROM")].Type.."\t"..memory.read_u8(i+move2,"ROM").."\t"
		..Attack[memory.read_u8(i+move3,"ROM")].Name.."\t"..Attack[memory.read_u8(i+move3,"ROM")].Type.."\t"..memory.read_u8(i+move3,"ROM").."\t"
		..Attack[memory.read_u8(i+move4,"ROM")].Name.."\t"..Attack[memory.read_u8(i+move4,"ROM")].Type.."\t"..memory.read_u8(i+move4,"ROM").."\t"
		..Attack[memory.read_u8(i+move5,"ROM")].Name.."\t"..Attack[memory.read_u8(i+move5,"ROM")].Type.."\t"..memory.read_u8(i+move5_level,"ROM").."\t"..memory.read_u8(i+move5,"ROM").."\n"
		io.write(line)
		-- console.log(line)
	end
	io.close(file)
end

function match_any_of(target,...)
	for i, v in ipairs({...}) do
		if v == target then return true end
	end
	return false
end

function write_table2()
	local move1_id
	local move2_id
	local move3_id
	local move4_id
	local move5_id
	local count = 0
	local denjuu_index = 0
	local denjuu_str
	file = io.open("move data2.txt","w")
	io.output(file)
	line = "Move\tType\tID\t#\n"
	io.write(line)
	for i = 0, 199 do
		count = 0
		denjuu_str = ""
		line = Attack[i].Name.."\t"..Attack[i].Type.."\t"..i.."\t"
		for j = start, end_addr, offset do
			move1_id = memory.read_u8(j+move1,"ROM")
			move2_id = memory.read_u8(j+move2,"ROM")
			move3_id = memory.read_u8(j+move3,"ROM")
			move4_id = memory.read_u8(j+move4,"ROM")
			move5_id = memory.read_u8(j+move5,"ROM")
			--checck if the current move exists in this Denjuu; prob a better way possible
			if match_any_of(i,move1_id,move2_id,move3_id,move4_id,move5_id) then			
				denjuu_index = math.floor((j-start)/offset)	--gives in terms of 1,2,3...199
				denjuu_str = denjuu_str..Denjuu[denjuu_index].Name.."\t"..denjuu_index.."\t"
				count = count + 1
			end
		end
		line = line..count.."\t"..denjuu_str.."\n"
		io.write(line)
	end
	io.close(file)
end

write_table()
write_table2()
console.log("Done")
