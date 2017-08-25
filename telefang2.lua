memory.usememorydomain("IWRAM")

--[[
Example for the below:
41F2 - EID
41F3 - ELV
41F4 - EHP(Current)
41F5 - EHP(Max)
41F6 - EDP
41F7 - ESPD
41F8 - EATK
41F9 - EDEF
41FA - ESPEC
41FC - Nature
41FD - FD
4207 - 1st move
4209 - 1st move power
4210 - 2nd move
4211 - 2nd move power
4218 - 3rd move
4219 - 3rd move power
4220 - 4th move
4221 - 4th move power
4228 - next denjuu's turn
]]--

local Map = {}
--Because some of the maps have values all over the place
function assign_multi(string,...)
	for i, v in ipairs(arg) do
		Map[v] = string
	end
end

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
	if (mx >= x and mx <= x+width)  and (my >= y and my <= y+height) then
		return true
	end
	return false
end

assign_multi("Bandit's Hideout",98,99,100,101,102,103,104)
assign_multi("Barusuta Forest",63,64,65,66,67,68,69,70)
assign_multi("Bijinia Desert",75,76,77,78)
assign_multi("Bijinia Village",20,46,97,131,132)
assign_multi("Chiawata Cave",49,50,51,52,53)
assign_multi("Chiawata Forest",2,3,133)
assign_multi("Chiawata Village",47,87,139,167)
assign_multi("Helchika Desert",71,72,73,74)
assign_multi("Helchika Village",96,129,130,140)
assign_multi("Hiero Loophole",25,26,27,28)
assign_multi("Holy Land Iasuka",136,142,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164)
assign_multi("Human World",48,128,134,143,165)
assign_multi("Kamishino Ruins",106,107,108,109,110,111,112,113,114,115)
assign_multi("Karatsumu Cave",116,117,118,119,120,121,122,123,124,125,126,127)
Map[82] = "Kiwatora Coast"
assign_multi("Kiwatora Field",6,7)
assign_multi("Kiwatora Village",19,45,81,95)
assign_multi("Kufumoku Mountain",15,23,24)
assign_multi("Meribaro Forest",4,5)
assign_multi("Meribaro Village",18,44,80,93,170)
assign_multi("Takedama Cave",21,22)
Map[0] = "Takedama Forest"
assign_multi("Takedama Village",16,39,40,41,42,138)
assign_multi("Tekku Sea",135,137)
assign_multi("Tokaribe Coast",83,84,86)
assign_multi("Tokaribe Field",1,85)
assign_multi("Tokaribe Village",17,43,79,94,169)
assign_multi("Ujichichi Mountain",29,30,31,32,33,34,35,36,37,38,89,90,91,92)
assign_multi("Uraani Cave",54,55,56,57,58,59,60,61,62,105)
assign_multi("Uraani Forest",8,9,11,12,13,14)
Map[10] = "Uraani Tides"
assign_multi("Uraani Village",88,141,166,168)

local Picture_Book = {
[0] = 15,[1] = 16,[2] = 17,[3] = 176,[4] = 177,[5] = 18,[6] = 19,[7] = 20,[8] = 21,[9] = 22,
[10] = 23,[11] = 24,[12] = 25,[13] = 26,[14] = 27,[15] = 28,[16] = 29,[17] = 30,[18] = 31,[19] = 32,
[20] = 37,[21] = 38,[22] = 39,[23] = 40,[24] = 33,[25] = 34,[26] = 35,[27] = 36,[28] = 41,[29] = 42,
[30] = 43,[31] = 44,[32] = 45,[33] = 46,[34] = 47,[35] = 48,[36] = 49,[37] = 178,[38] = 179,[39] = 180,
[40] = 50,[41] = 51,[42] = 52,[43] = 53,[44] = 54,[45] = 55,[46] = 56,[47] = 57,[48] = 58,[49] = 59,
[50] = 60,[51] = 61,[52] = 62,[53] = 63,[54] = 64,[55] = 65,[56] = 66,[57] = 67,[58] = 68,[59] = 69,
[60] = 70,[61] = 71,[62] = 72,[63] = 73,[64] = 74,[65] = 75,[66] = 76,[67] = 77,[68] = 78,[69] = 79,
[70] = 80,[71] = 81,[72] = 82,[73] = 83,[74] = 84,[75] = 85,[76] = 86,[77] = 87,[78] = 181,[79] = 182,
[80] = 183,[81] = 184,[82] = 185,[83] = 186,[84] = 187,[85] = 88,[86] = 89,[87] = 90,[88] = 188,[89] = 189,
[90] = 190,[91] = 191,[92] = 192,[93] = 193,[94] = 91,[95] = 92,[96] = 93,[97] = 94,[98] = 194,[99] = 195,
[100] = 95,[101] = 96,[102] = 97,[103] = 98,[104] = 99,[105] = 100,[106] = 101,[107] = 102,[108] = 103,[109] = 196,
[110] = 197,[111] = 104,[112] = 105,[113] = 106,[114] = 107,[115] = 108,[116] = 109,[117] = 110,[118] = 111,[119] = 112,
[120] = 113,[121] = 114,[122] = 115,[123] = 116,[124] = 117,[125] = 118,[126] = 119,[127] = 120,[128] = 121,[129] = 122,
[130] = 123,[131] = 124,[132] = 125,[133] = 198,[134] = 199,[135] = 126,[136] = 127,[137] = 128,[138] = 129,[139] = 130,
[140] = 131,[141] = 132,[142] = 133,[143] = 134,[144] = 135,[145] = 136,[146] = 137,[147] = 138,[148] = 139,[149] = 140,
[150] = 141,[151] = 142,[152] = 143,[153] = 144,[154] = 145,[155] = 146,[156] = 147,[157] = 148,[158] = 149,[159] = 150,
[160] = 151,[161] = 152,[162] = 153,[163] = 154,[164] = 155,[165] = 156,[166] = 157,[167] = 158,[168] = 159,[169] = 160,
[170] = 161,[171] = 162,[172] = 163,[173] = 164,[174] = 165,[175] = 166,[176] = 167,[177] = 168,[178] = 169,[179] = 170,
[180] = 0,[181] = 1,[182] = 2,[183] = 3,[184] = 4,[185] = 5,[186] = 6,[187] = 7,[188] = 8,[189] = 9,
[190] = 10,[191] = 11,[192] = 12,[193] = 13,[194] = 14,[195] = 171,[196] = 172,[197] = 173,[198] = 174,[199] = 175}

--Attack names
local Attacks = {
[0] = "????",[1] = "Spark",[2] = "Falling Star",[3] = "Pillar of Fire",[4] = "Small Fire",[5] = "Will-o\'-the-Wisp",[6] = "Flame Shot",[7] = "Raging Fire",[8] = "Fire Wheel",[9] = "Disk Cutter",
[10] = "Wheel",[11] = "Chainsaw",[12] = "Drill",[13] = "Rocket Punch",[14] = "Twin Drill",[15] = "Rotation Cutter",[16] = "Spiral Cutter",[17] = "Waterfall",[18] = "Soap Ball",[19] = "Water Drop",
[20] = "Water Gun",[21] = "Wave Crash",[22] = "Squall",[23] = "Icicle Trap",[24] = "Watersprout",[25] = "Rock Claw",[26] = "Boulder Roll",[27] = "Sand Vortex",[28] = "Boulder Ball",[29] = "Boulder Avalanche",[30] = "Shake-Out",
[31] = "Falling Rocks",[32] = "Small Quake",[33] = "Vaccum Cutter",[34] = "Shock Wave",[35] = "Whirlwind",[36] = "Gust",[37] = "Flap",[38] = "Tornado",[39] = "Gale",
[40] = "Kamaitachi",[41] = "Ion Ball",[42] = "Positive Electricity",[43] = "Electric Claw",[44] = "Discharge",[45] = "Electric Shock",[46] = "Electric Arrow",[47] = "Big Electric Current",[48] = "Electric Field",[49] = "Claw",
[50] = "Iron Claw",[51] = "Scales",[52] = "Ring",[53] = "Bite",[54] = "Beak",[55] = "Kicking",[56] = "Continuous Kicking",[57] = "Sabre",[58] = "Tail",[59] = "Suddenness (1)",
[60] = "Suddenness (2)",[61] = "Jump",[62] = "Tentacle",[63] = "Numb Tentacle",[64] = "Body Blow",[65] = "Spit Spray",[66] = "Headbutt",[67] = "Suddenness (3)",[68] = "Horn",[69] = "Iron Horn",
[70] = "Wing",[71] = "Thorn",[72] = "Rush",[73] = "Drain",[74] = "Bloodsuck",[75] = "Strike",[76] = "Razor Punch",[77] = "Hammer Punch",[78] = "Lick",[79] = "Needle",
[80] = "Suddenness (4)",[81] = "Scissors",[82] = "Petal",[83] = "Feather Sabre",[84] = "Feather Knife",[85] = "Acupuncture",[86] = "Poison Sting",[87] = "Numbing Sting",[88] = "Hoof",[89] = "Suddenness (5)",
[90] = "Suddenness (6)",[91] = "Whiplash",[92] = "Electric Wire",[93] = "Digestive Fluids",[94] = "Melting Fluids",[95] = "Stab",[96] = "Continuous Stab",[97] = "Ice Rock",[98] = "Big Wave",[99] = "Whirling Tides",
[100] = "Ice Bullet",[101] = "Blizzard",[102] = "Big Water Pressure",[103] = "Big Tsunami",[104] = "Ion Beam",[105] = "Small Bolt",[106] = "Plasma Laser",[107] = "Lightning Strike",[108] = "Thunder Storm",[109] = "Mega Bolt",
[110] = "Electric Hell",[111] = "Ibo Ibo Missile",[112] = "Gatling Gun",[113] = "Rapid-Fire Missile",[114] = "Bazooka",[115] = "Drill Missile",[116] = "Homing Missile",[117] = "Bombing",[118] = "Wave Attack",[119] = "Aura Wave",
[120] = "Sandstorm",[121] = "Big Stream Pressure",[122] = "Vacuum Hole",[123] = "Hurricane",[124] = "Black Hole",[125] = "Heat Beam",[126] = "Small Burn",[127] = "Small Flame",[128] = "Flamethrower",[129] = "Fire Breath",
[130] = "Big Burn",[131] = "Suddenness (7)",[132] = "Bomb Rock",[133] = "Small Rock",[134] = "Sand Prison",[135] = "Mega Quake",[136] = "Mega Rock",[137] = "Meteor Drop",[138] = "Diamond Rain",[139] = "Mushroom Bomb",
[140] = "Egg Bomb",[141] = "Bomb",[142] = "Wave Beam",[143] = "Beam Light",[144] = "Blaster",[145] = "Suicide Attack",[146] = "String Discard",[147] = "Adhesive Liquid",[148] = "Smokescreen",[149] = "Flash",
[150] = "Dust Cloud",[151] = "Recovery",[152] = "Big Recovery",[153] = "Shout",[154] = "Stare",[155] = "Glare",[156] = "Quick Step",[157] = "Speed Up",[158] = "Charging",[159] = "Big Charging",
[160] = "Ultrasonic",[161] = "Curse Song",[162] = "Iron Defense",[163] = "Venom",[164] = "Poison Gas",[165] = "Numb Gas",[166] = "Cure",[167] = "Alarm Clock",[168] = "Roar",[169] = "Hot Wind",
[170] = "Shrill Voice",[171] = "Cold Air",[172] = "Sleep Gas",[173] = "Lullaby",[174] = "Meditate",[175] = "Denma Barrier",[176] = "Persist",[177] = "Support",[178] = "Defense",[179] = "Shield",
[180] = "Blessing",[181] = "Contemplate",[182] = "Hide",[183] = "Dive",[184] = "Skin Thicken",[185] = "Avoid",[186] = "Spore Shed",[187] = "Tongue Sticking Out",[188] = "Provoke",[189] = "Denma Seal",
[190] = "Denma Drain",[191] = "Twister Song",[192] = "Energy Break",[193] = "Mega Break",[194] = "Count Down",[195] = "Strawberry Kiss",[196] = "Injection Plug",[197] = "Deflation Spiral",[198] = "Hot Bath",[199] = "Nove Smasher"}

--List of Denjuu by names, sorted by Index
local Denjuu = {
[0] = "Muscovy (Basic)",[1] = "Muscovy (Natural)",[2] = "Muscovy (Aquatic)",[3] = "Major (Basic)",[4] = "Major (Grassland)",[5] = "Fraby (Basic)",[6] = "Fraby (Mountain)",[7] = "Fraby (Sky)",[8] = "Kagu (Basic)",[9] = "Kagu (Natural)",
[10] = "Purchera (Basic)",[11] = "Purchera (Sky)",[12] = "Purchera (Forest)",[13] = "Mentalis (Basic)",[14] = "Mentalis (Natural)",[15] = "Mentalis (Forest)",[16] = "Mentalis (Grassland)",[17] = "Karinota (Basic)",[18] = "Karinota (Grassland)",[19] = "Karinota (Mountain)",
[20] = "Chukar (Basic)",[21] = "Chukar (Natural)",[22] = "Chukar (Mountain)",[23] = "Chukar (Aquatic)",[24] = "Laperouse (Basic)",[25] = "Laperouse  (Natural)",[26] = "Laperouse (Desert)",[27] = "Laperouse (Grassland)",[28] = "Anpipitto (Basic)",[29] = "Anpipitto (Sky)",
[30] = "Anpipitto (Desert)",[31] = "Ruficors (Basic)",[32] = "Ruficors (Grassland)",[33] = "Ruficors (Aquatic)",[34] = "Cotta (Basic)",[35] = "Cotta (Natural)",[36] = "Cotta (Desert)",[37] = "Rupicola (Basic)",[38] = "Rupicola (Grassland)",[39] = "Rupicola (Sky)",
[40] = "Willcock (Basic)",[41] = "Willcock (Natural)",[42] = "Willcock (Forest)",[43] = "Skrippa (Basic)",[44] = "Skrippa (Aquatic)",[45] = "Cabot (Basic)",[46] = "Cabot (Natural)",[47] = "Makyuretto (Basic)",[48] = "Makyuretto (Natural)",[49] = "Makyuretto (Grassland)",
[50] = "Makyuretto (Forest)",[51] = "Coronet (Basic)",[52] = "Coronet (Aquatic)",[53] = "Coronet (Grassland)",[54] = "Tataupa (Basic)",[55] = "Tataupa (Desert)",[56] = "Tataupa (Forest)",[57] = "Chigomozu (Basic)",[58] = "Chigomozu (Natural)",[59] = "Koikaru (Basic)",
[60] = "Koikaru (Natural)",[61] = "Koikaru (Forest)",[62] = "Pewee (Basic)",[63] = "Pewee (Natural)",[64] = "Pewee (Aquatic)",[65] = "Pewee (Mountain)",[66] = "Chapmani (Basic)",[67] = "Chapmani (Natural)",[68] = "Hyuming (Basic)",[69] = "Hyuming (Natural)",
[70] = "Hyuming (Mountain)",[71] = "Pamirio (Basic)",[72] = "Pamirio (Natural)",[73] = "Pamirio (Sky)",[74] = "Pamirio (Desert)",[75] = "Mistashi (Basic)",[76] = "Mistashi (Forest)",[77] = "Mistashi (Aquatic)",[78] = "Parrotto (Basic)",[79] = "Parrotto (Natural)",
[80] = "Nebularia (Basic)",[81] = "Nebularia (Natural)",[82] = "Granti (Basic)",[83] = "Granti (Nautral)",[84] = "Granti (Desert)",[85] = "Penelope (Basic)",[86] = "Penelope (Aquatic)",[87] = "Penelope (Mountain)",[88] = "Ardea (Basic)",[89] = "Ardea (Natural)",
[90] = "Ardea (Forest)",[91] = "Cerator (Basic)",[92] = "Cerator (Natural)",[93] = "Cerator (Mountain)",[94] = "Alpina (Basic)",[95] = "Alpina (Natural)",[96] = "Alpina (Aquatic)",[97] = "Alpina (Sky)",[98] = "Isuka (Basic)",[99] = "Isuka (Grassland)",
[100] = "Bicolour (Basic)",[101] = "Bicolour (Natural)",[102] = "Hermit (Basic)",[103] = "Hermit (Natural)",[104] = "Hermit (Desert)",[105] = "Hermit (Grassland)",[106] = "Phoebe (Basic)",[107] = "Phoebe (Aquatic)",[108] = "Phoebe (Desert)",[109] = "Blossom (Basic)",
[110] = "Blossom (Mountain)",[111] = "Rabricol (Basic)",[112] = "Rabricol (Natural)",[113] = "Rabricol (Aquatic)",[114] = "Demerus (Basic)",[115] = "Demerus (Natural)",[116] = "Demerus (Desert)",[117] = "Sparsa (Basic)",[118] = "Sparsa (Natural)",[119] = "Sparsa (Forest)",
[120] = "Purprea (Basic)",[121] = "Purprea (Sky)",[122] = "Purprea (Grassland)",[123] = "Etopirika (Basic)",[124] = "Etopirika (Natural)",[125] = "Etopirika (Forest)",[126] = "Regulus (Basic)",[127] = "Regulus (Desert)",[128] = "Regulus (Sky)",[129] = "Akretto (Basic)",
[130] = "Akretto (Natural)",[131] = "Akretto (Grassland)",[132] = "Akretto (Mountain)",[133] = "Seiran (Basic)",[134] = "Seiran (Mountain)",[135] = "Tectus (Basic)",[136] = "Tectus (Natural)",[137] = "Serrata (Basic)",[138] = "Serrata (Sky)",[139] = "Serrata (Forest)",
[140] = "Kaya (T2)",[141] = "Beebalm (T2)",[142] = "Easydog (T2)",[143] = "Ruscus (T2)",[144] = "Ryuuguu (T2)",[145] = "Kanzou (T2)",[146] = "Ornithogalum (T2)",[147] = "Teletel (T2)",[148] = "Dendel (T2)",[149] = "Suguri (T2)",
[150] = "Suguline (T2)",[151] = "Saiguliger (T2)",[152] = "Punica (T2)",[153] = "Punisto (T2)",[154] = "Oshe (T2)",[155] = "Barriarm (T2)",[156] = "Bashou (T2)",[157] = "Gentiana (T2)",[158] = "Gonum (T2)",[159] = "Gust (T2)",
[160] = "Storm (T2)",[161] = "Tsunonasu (T2)",[162] = "Gigagigearth (T2)",[163] = "Liriope (T2)",[164] = "Lirimonarch (T2)",[165] = "Waratah (T2)",[166] = "Enteiou (T2)",[167] = "Gumi (T2)",[168] = "Gymnos (T2)",[169] = "Gymbaron (T2)",
[170] = "Gymzyrus (T2)",[171] = "Gymzatan (T2)",[172] = "Angios (T2)",[173] = "Angigorgo (T2)",[174] = "Angipower (T2)",[175] = "Angioros (T2)",[176] = "Fungus (T2)",[177] = "Fungwar (T2)",[178] = "Funboost (T2)",[179] = "Funblade (T2)",
[180] = "Rex (Basic)",[181] = "Rex (Natural-1)",[182] = "Rex (Desert)",[183] = "Rex (Forest)",[184] = "Rex (Natural-2)",[185] = "Doon (Basic)",[186] = "Doon (Natural-1)",[187] = "Doon (Sky)",[188] = "Doon (Aquatic)",[189] = "Doon (Natural-2)",
[190] = "Gyuun (Basic)",[191] = "Gyuun (Natural-1)",[192] = "Gyuun (Aquatic)",[193] = "Gyuun (Forest)",[194] = "Gyuun (Natural-2)",[195] = "Diablos (Basic)",[196] = "Diablos (Natural-1)",[197] = "Diablos (Mountain)",[198] = "Diablos (Grassland)",[199] = "Diablos (Natural-2)"}
--Addresses I'm interested regarding speed version
local Speed = {
Enemy = {0x41F2,0x422A,0x4262},
State = 0x042C,
Map = 0x4F90,
Player_X = 0x4CF8,
Player_Y = 0x4CFC,
Money = 0x4CF4,
Boss = 0x2888,
Move = 0x2B06,
Story = 0x4DD7,
Music = 0x4AE2,	--Seems like it's the background music ID; can use this to check if in battle
Counter = 0x0840
}

--Addresses I'm interested regarding power version
local Power = {
Enemy = {0x4202,0x423A,0x4272},
State = 0x043C,
Map = 0x4FA0,
Player_X = 0x4D08,
Player_Y = 0x4D0C,
Money = 0x4D04,
Boss = 0x2898,
Move = 0x2B16,
Story = 0x4DE7,
Music = 0x4AF2,
Counter = 0x0850
}

local Enemy_data = {
Level,
HP_Max,
HP_Now,
DP,
Speed,
Attack,
Defence,
Special,
Nature,
FD,
Friend,
Attack1,
Attack2,
Attack3,
Attack4,
Next
}

while true do
local Addresses
local toggle = 0
local NPC = {x,y,xcam,ycam,state}
local num = 0	--For NPC
	while version() ~= "NA" do
		Addresses = (version() == "Power" and Power or Speed)
		gui.text(0,55,"BOSS: "..memory.readbyte(Addresses.Boss).." State: "..memory.readbyte(Addresses.State).."Story:"..memory.readbyte(Addresses.Story))
		gui.text(0,250,"("..string.format('%.6f',memory.read_u32_le(Addresses.Player_X)/65536.0)..","..string.format('%.6f',memory.read_u32_le(Addresses.Player_Y)/65536.0)..")")
		gui.text(0,265,"$: "..memory.read_u32_le(Addresses.Money))
		gui.text(0,280,"Move: "..Attacks[memory.readbyte(Addresses.Move)].." ("..memory.readbyte(Addresses.Move)..")")
		
	--Just in case something happens that causes map to go above 170
		if Map[memory.readbyte(Addresses.Map)] ~= nil then
			gui.text(0,235,Map[memory.readbyte(Addresses.Map)].."("..memory.readbyte(Addresses.Map)..")")
		end
		--Checking if in battle
		if (memory.readbyte(Addresses.Music) >= 5 and memory.readbyte(Addresses.Music) <= 9) then
			gui.drawText(0,150,"Denjuu X 1 2 3 A ",null,null,10,null,null) --Click these for info
			if (input.getmouse().Left and get_mouse_pos(30,150,24,10)) then
				toggle = 0
			elseif (input.getmouse().Left and get_mouse_pos(55,150,9,10)) then 
				toggle = 1
			elseif (input.getmouse().Left and get_mouse_pos(65,150,11,10)) then 
				toggle =  2
			elseif (input.getmouse().Left and get_mouse_pos(78,150,11,10)) then 
				toggle =  3
			elseif (input.getmouse().Left and get_mouse_pos(90,150,10,10)) then 
				toggle =  4
			else
			end
			
			if toggle > 0 and toggle < 4 and memory.readbyte(Addresses.Enemy[toggle]+1) > 0 then
				--gui.drawText(0,30,"E"..toggle..Denjuu[memory.readbyte(Addresses.Enemy[toggle])].."("..memory.readbyte(Addresses.Enemy[toggle])..")".."&"..Denjuu[memory.readbyte(Addresses.Enemy[toggle]+21)].."("..memory.readbyte(Addresses.Enemy[toggle]+21)..")",null,null,10,null,null)
				gui.drawText(0,30,"E"..toggle.." ID:"..memory.readbyte(Addresses.Enemy[toggle]).." Friend:"..memory.readbyte(Addresses.Enemy[toggle]+21),null,null,10,null,null)
				gui.drawText(0,40,"LV:"..memory.readbyte(Addresses.Enemy[toggle]+1).." HP:"..memory.readbyte(Addresses.Enemy[toggle]+2).."/"..memory.readbyte(Addresses.Enemy[toggle]+3).." DP:"..memory.readbyte(Addresses.Enemy[toggle]+4).." ",null,null,10,null,null)
				gui.drawText(0,50,"SPD:"..memory.readbyte(Addresses.Enemy[toggle]+5).." ATK:"..memory.readbyte(Addresses.Enemy[toggle]+6).." DEF:"..memory.readbyte(Addresses.Enemy[toggle]+7).." SPEC:"..memory.readbyte(Addresses.Enemy[toggle]+8).." ",null,null,10,null,null)
				gui.drawText(0,60,Attacks[memory.readbyte(Addresses.Enemy[toggle]+22)].." | "..Attacks[memory.readbyte(Addresses.Enemy[toggle]+30)].." ",null,null,10,null,null)
				gui.drawText(0,70,Attacks[memory.readbyte(Addresses.Enemy[toggle]+38)].." | "..Attacks[memory.readbyte(Addresses.Enemy[toggle]+46)].." ",null,null,10,null,null)
			end
			
			if toggle == 4 then
				for i=1,3 do
					if memory.readbyte(Addresses.Enemy[i]+1) > 0 then	--Since id can be 0, check if level is greater than 0 instead. Also make sure it only appears during battle
						gui.drawText(0,10+(20*i),"E"..i.." ID:"..memory.readbyte(Addresses.Enemy[i]).." LV:"..memory.readbyte(Addresses.Enemy[i]+1).." HP:"..memory.readbyte(Addresses.Enemy[i]+2).."/"..memory.readbyte(Addresses.Enemy[i]+3).." DP:"..memory.readbyte(Addresses.Enemy[i]+4),null,null,10,null,null)
						gui.drawText(0,20+(20*i),"SPD:"..memory.readbyte(Addresses.Enemy[i]+5).." ATK:"..memory.readbyte(Addresses.Enemy[i]+6).." DEF:"..memory.readbyte(Addresses.Enemy[i]+7).." SPEC:"..memory.readbyte(Addresses.Enemy[i]+8),null,null,10,null,null)
					end
				end
			end
		end
		
	--Checking if overworld music is playing to display npc data
		if memory.readbyte(Addresses.Music) >= 17 and memory.readbyte(Addresses.Music) <= 43 then
			for i = (version() == "Power" and 0x34E0 or 0x34D0), 0x3810, 0x20 do	--Power and Speed is offsetted by +0x10 difference
				if memory.readbyte(i) ~= 0 then
					NPC.xcam = memory.read_u16_le(i+0x2)
					NPC.ycam = memory.read_u16_le(i+0x4)
					NPC.x = string.format('%.1f',memory.read_u32_le(i+0xC)/65536.0)
					NPC.y = string.format('%.1f',memory.read_u32_le(i+0x10)/65536.0)
					NPC.state = memory.readbyte(i+0x1F)
					num = math.floor((i-0x34D0)/0x20)+1	--So it would be 1 offset
					gui.drawText(NPC.xcam-20,NPC.ycam,"X"..NPC.x.." Y"..NPC.y.."s"..NPC.state,null,null,10,null,null)
					gui.drawText(NPC.xcam-5,NPC.ycam-20,num,null,null,10,null,null)
				end
			end
		gui.text(0,295,"NPCs: "..num.." Counter: "..memory.read_u32_le(Addresses.Counter))
		end
		
	emu.frameadvance()
	end
	emu.frameadvance()
end