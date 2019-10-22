memory.usememorydomain("IWRAM")

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

--checks the mouse position during a click relative to the client and see if its within some range
function get_mouse_pos(x,y,width,height)
	mx = input.getmouse().X
	my = input.getmouse().Y
--input.getmouse() is already relative to client :)
	gui.drawRectangle(x, y, width, height, "red", nil) --So I know where the heck are the clickboxes
	if (mx >= x and mx <= x+width)  and (my >= y and my <= y+height) then
		return true
	end
	return false
end


local function GetStats(addr,o)
	o = o or {} --Construct a table if we didn't get one
	o.address = bizstring.hex(addr)
	o.exists = memory.readbyte(addr) > 0 
	o.arrival_state = memory.readbyte(addr)
	o.id = memory.readbyte(addr+2)
	o.level = memory.readbyte(addr+3)
	o.hp = memory.readbyte(addr+4)
	o.max_hp = memory.readbyte(addr+5)
	o.dp = memory.readbyte(addr+6)	--special attack points
	o.speed = memory.readbyte(addr+7)
	o.attack = memory.readbyte(addr+8)
	o.defence = memory.readbyte(addr+9)
	o.special = memory.readbyte(addr+10)
	o.nature = memory.readbyte(addr+12)
	o.fd = memory.readbyte(addr+13)	--something to do with phones
	o.arrival_time = memory.readbyte(addr+21)	--something to do with phones
	o.ally = memory.readbyte(addr+23)
	o.attack1 = memory.readbyte(addr+24)
	o.attack1_power = memory.readbyte(addr+25)
	o.attack2 = memory.readbyte(addr+32)
	o.attack2_power = memory.readbyte(addr+33)
	o.attack3 = memory.readbyte(addr+40)
	o.attack3_power = memory.readbyte(addr+41)
	o.attack4 = memory.readbyte(addr+48)
	o.attack4_power = memory.readbyte(addr+49)
	o.next_denjuu = memory.readbyte(addr+56) --next denjuu's arrival state
	--... And so on
	return o
end

function display_battle(address, toggle)
--give the function the addresses it needs
	local toggle_states = {["None"]=0,["NPC1"]=1,["NPC2"]=2,["NPC3"]=3,["All"]=4}	--to make the magic numbers below understandable
	local l_toggle
	local npc = {}	--table of npcs
	local line	--to make displaying lines readable
	local battle_state
	local battle_timer
	local critical
	local damage
	local move_selected
	local boss
	local state
	local counter
	local npc_count = 0
	--booleans
	local in_battle
	local display_individual
	local npc_present
	local offset
	if address ~= nil then	--make sure address is valid
		in_battle = (memory.readbyte(address.Game_State) == 5)
		battle_state = memory.readbyte(address.Battle_State)
		battle_timer = memory.readbyte(address.Battle_Event_Timer)
		damage = memory.readbyte(address.Damage)
		critical = memory.readbyte(address.Crit)
		move_selected = memory.readbyte(address.Move)
		boss = memory.readbyte(address.Boss)
		state = memory.readbyte(address.State)
		counter = memory.read_u32_le(address.Counter)
	else
		in_battle = false
	end
	l_toggle = (toggle ~= nil and toggle or toggle_states["None"])	--default value of 0
	local box_y = 150;
	local box_None_x = 40;
	local box_NPC_x = {[1] = 49, [2] = 58, [3] = 67};
	local box_All_x = 76;
	local box_width = 9;
	local box_height = 9;
	--[[Colors based on Denjuu state. 
	0 = DNE, 1 = Dead, 2 = Present, 3 = Travelling, 4 = Announcing arrival, 5 = Delayed, 6+ crap
	]]--
	local color = {[0] = "red", "red", "white", "yellow", "white", "gray"};
	local line_color = nil;	--To hold the colors and check if greater than 6
	if in_battle then
	--Interface for toggling display
	--Should appear as Denjuu X 1 2 3 A
	--Numbers are white if Denjuu exists, else red
		gui.drawText(0,box_y,"Denjuu",nil,nil,10,nil,nil) --Click these for info
		gui.drawText(box_None_x,box_y,"X",nil,nil,10,nil,nil) --Click these for info
		gui.drawText(box_All_x,box_y,"A",nil,nil,10,nil,nil) --Click these for info
		
		if (input.getmouse().Left and get_mouse_pos(box_None_x,box_y,box_width,box_height)) then
			l_toggle = toggle_states["None"]
		elseif (input.getmouse().Left and get_mouse_pos(box_NPC_x[1],box_y,box_width,box_height)) then 
			l_toggle = toggle_states["NPC1"]
		elseif (input.getmouse().Left and get_mouse_pos(box_NPC_x[2],box_y,box_width,box_height)) then 
			l_toggle =  toggle_states["NPC2"]
		elseif (input.getmouse().Left and get_mouse_pos(box_NPC_x[3],box_y,box_width,box_height)) then 
			l_toggle =  toggle_states["NPC3"]
		elseif (input.getmouse().Left and get_mouse_pos(box_All_x,box_y,box_width,box_height)) then 
			l_toggle =  toggle_states["All"]
		else
		end
	--Get opponent stats
		for i = 1, 3 do
			npc[i] = GetStats(address.Enemy[i])
			line_color = npc[i].arrival_state < 6 and color[npc[i].arrival_state] or "white" --Prevent errors if state somehow went over 5
			gui.drawText(box_NPC_x[i],box_y,i,line_color,nil,10,nil,nil)	--Draw the clickable box at bottom
			
			--Display only states, without moves		
			if toggle == toggle_states["All"] then
				if npc[i].exists and npc[i].hp > 0 then
					npc_count = npc_count + 1
					line = "E"..i.." ID:"..npc[i].id.." LV:"..npc[i].level.." HP:"..npc[i].hp.."/"..npc[i].max_hp.." DP:"..npc[i].dp
					--Don't add arrival if arrived
					if npc[i].arrival_time > 0 then
						line = line.." ("..npc[i].arrival_time..")"
					end
					gui.drawText(0,10+(20*i),line,line_color,nil,10,nil,nil)
					line = "SPD:"..npc[i].speed.." ATK:"..npc[i].attack.." DEF:"..npc[i].defence.." SPEC:"..npc[i].special
					gui.drawText(0,20+(20*i),line,line_color,nil,10,nil,nil)
				end
			end
		end
		gui.drawText(0,20,"Denjuu left:"..npc_count,nil,nil,10,nil,nil)
	--Draw opponent stats
		display_individual = (l_toggle > toggle_states["None"] and l_toggle < toggle_states["All"])
		if display_individual then
			if npc[l_toggle].exists then
				offset = 30
				line = "E"..l_toggle.." "..Denjuu[npc[l_toggle].id].Name.." ID:"..npc[l_toggle].id
				gui.drawText(0,offset,line,nil,nil,10,nil,nil)
				line = "Ally:"..Denjuu[npc[l_toggle].ally].Name.." ID:"..npc[l_toggle].ally
				offset = offset + 10
				gui.drawText(0,offset,line,nil,nil,10,nil,nil)
				line = "LV:"..npc[l_toggle].level.." HP:"..npc[l_toggle].hp.."/"..npc[l_toggle].max_hp.." DP:"..npc[l_toggle].dp.." NAT:"..npc[l_toggle].nature
				offset = offset + 10
				gui.drawText(0,offset,line,nil,nil,10,nil,nil)
				line = "SPD:"..npc[l_toggle].speed.." ATK:"..npc[l_toggle].attack.." DEF:"..npc[l_toggle].defence.." SPEC:"..npc[l_toggle].special
				offset = offset + 10
				gui.drawText(0,offset,line,nil,nil,10,nil,nil)
				line = Attacks[npc[l_toggle].attack1].Name.."("..npc[l_toggle].attack1..") P"..npc[l_toggle].attack1_power..
				" | "..Attacks[npc[l_toggle].attack2].Name.."("..npc[l_toggle].attack2..") P"..npc[l_toggle].attack2_power..")\n"
				..Attacks[npc[l_toggle].attack3].Name.."("..npc[l_toggle].attack3..") P"..npc[l_toggle].attack3_power..
				" | "..Attacks[npc[l_toggle].attack4].Name.."("..npc[l_toggle].attack4..") P"..npc[l_toggle].attack4_power
				offset = offset + 10
				gui.drawText(0,offset,line,nil,nil,10,nil,nil)
			end
		end

	--Other things to display during a battle
			gui.text(0,235,"Battle State:"..battle_state.." DMG "..damage.."("..critical..")")
			gui.text(0,250,"Battle timer:"..battle_timer.." Counter:"..counter)
			gui.text(0,280,"BOSS: "..boss.." State: "..state)
				--Just in case something happens that causes a non-move value to appear (healing for instance)
		if Attacks[move_selected] ~= nil then
			gui.text(0,265,"Move: "..Attacks[move_selected].Name.." ("..move_selected..")")
		else
			gui.text(0,265,"Move: UNDEFINED ("..move_selected..")")
		end
	end
	return l_toggle
end

function display_overworld_npc(address,toggle)
	local toggle_states = {["None"]=0,["View1"]=1,["View2"]=2}
	local npc = {x,y,xcam,ycam,state}
	local game_state
	local num = 0	--For NPC
	local overworld	--boolean
	local addr
	if address ~= nil then	--make sure address is valid
		game_state = memory.readbyte(address.Game_State)
	end
	--Checking if overworld music is playing to display npc data
	overworld = game_state ~= nil and (game_state == 10) or false
	addr = (version() == "Power" and 0x34E0 or 0x34D0)
	for i = addr, 0x3810, 0x20 do	--Power and Speed is offsetted by +0x10 difference
		if memory.readbyte(i) ~= 0 then
			npc.xcam = memory.read_u16_le(i+2)
			npc.ycam = memory.read_u16_le(i+4)
			npc.x = string.format('%.1f',memory.read_u32_le(i+12)/65536.0)
			npc.y = string.format('%.1f',memory.read_u32_le(i+16)/65536.0)
			npc.state = memory.readbyte(i+31)
			num = math.floor((i-addr)/0x20)+1	--So it would be 1 offset
			if toggle == toggle_states["View1"] then
				gui.drawText(npc.xcam-20,npc.ycam,"X"..npc.x.." Y"..npc.y.."s"..npc.state,nil,nil,10,nil,nil)
				gui.drawText(npc.xcam-5,npc.ycam-20,num,nil,nil,10,nil,nil)
			elseif toggle == toggle_states["View2"] then
				gui.drawText(0,num*10,"X"..npc.x.." Y"..npc.y.."s"..npc.state.." #"..num,nil,nil,10,nil,nil)
				gui.drawText(npc.xcam-5,npc.ycam-20,num,nil,nil,10,nil,nil)
			end
		end
	end
	gui.text(0,295,"NPCs: "..num)
end

function display_overworld(address,toggle)
	local toggle_states = {["None"]=0,["View1"]=1,["View2"]=2}
	local l_toggle
	local l_map
	local x
	local y
	local rng
	local counter
	local money
	local music
	local game_state
	local box_width = 9
	local box_height = 9
	--boolean
	local in_overworld
	local display_npc
	if address ~= nil then	--make sure address is valid
		l_map = memory.readbyte(address.Map)
		x = memory.read_u32_le(address.Player_X)
		y = memory.read_u32_le(address.Player_Y)
		rng = memory.read_u32_le(address.RNG1)
		counter = memory.read_u32_le(address.Counter)
		money = memory.read_u32_le(address.Money)
		game_state = memory.readbyte(address.Game_State)
		music = memory.readbyte(address.Music)
	end
	l_toggle = (toggle ~= nil and toggle or toggle_states["None"])	--default value of 0
	
	in_overworld = game_state ~= nil and (game_state == 10) or false
	if in_overworld then
	--only check toggle out of battle
		local box_x = 58
		gui.drawText(0,150,"NPC Info:",nil,nil,10,nil,nil) 
		--Click these for info; making them seperate so as to make it not change size with begining text
		gui.drawText(box_x,150,"1",nil,nil,10,nil,nil)
		gui.drawText(box_x+9,150,"2",nil,nil,10,nil,nil)
		gui.drawText(box_x+18,150,"X",nil,nil,10,nil,nil) 
		
		if (input.getmouse().Left and get_mouse_pos(box_x,150,box_width,box_height)) then
			l_toggle = toggle_states["View1"]
		elseif (input.getmouse().Left and get_mouse_pos(box_x+9,150,box_width,box_height)) then
			l_toggle = toggle_states["View2"]
		elseif (input.getmouse().Left and get_mouse_pos(box_x+18,150,box_width,box_height)) then
			l_toggle = toggle_states["None"]
		end
		
		gui.text(0,250,"X:"..string.format('%.6f',x/65536.0).." Y:"..string.format('%.6f',y/65536.0))
		gui.text(0,265,"RNG:"..rng.." Counter:"..counter)
		gui.text(0,280,"Music:"..music.." $:"..money)
		--Just in case something happens that causes map to go above 170
		if Map[l_map] ~= nil then
			gui.text(0,235,Map[l_map].."("..l_map..")")
		end
		display_npc = (l_toggle ~= toggle_states["None"])
		if display_npc then
			display_overworld_npc(address,l_toggle)
		end
	end
	return l_toggle
end

local battle_toggle = 0	--so this won't get set back to 0 over and over
local npc_toggle = 0
while true do
local Addresses
	while version() ~= "NA" do
		Addresses = (version() == "Power" and Power or Speed)
		battle_toggle = display_battle(Addresses,battle_toggle)
		npc_toggle = display_overworld(Addresses,npc_toggle)
		emu.frameadvance()
	end
	emu.frameadvance()
end
