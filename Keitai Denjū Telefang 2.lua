memory.usememorydomain("IWRAM")

local Map = {}
--Because some of the maps have values all over the place
function assign_multi(string,...)
	for i, v in ipairs({...}) do
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

--Attack names
local Attacks = {
[0] = {Name = "????", Type = "None"},
[1] = {Name = "Ember", Type = "Fire"},
[2] = {Name = "Fireball", Type = "Fire"},
[3] = {Name = "Fire Pillar", Type = "Fire"},
[4] = {Name = "Petit Fire", Type = "Fire"},
[5] = {Name = "	Will o' Wisp", Type = "Fire"},
[6] = {Name = "Flame Shot", Type ="Fire" },
[7] = {Name = "Blaze", Type = "Fire"},
[8] = {Name = "Fire Wheel", Type = "Fire"},
[9] = {Name = "Disk Cutter", Type = "Machine"},
[10] = {Name = "Wheel", Type = "Machine"},
[11] = {Name = "Chainsaw", Type = "Machine"},
[12] = {Name = "Drill", Type = "Machine"},
[13] = {Name = "Rocket Punch", Type = "Machine"},
[14] = {Name = "Twin Drill", Type = "Machine"},
[15] = {Name = "Spin Cutter", Type = "Machine"},
[16] = {Name = "Spiral Cut", Type = "Machine"},
[17] = {Name = "Waterfall", Type = "Water"},
[18] = {Name = "Bubble", Type = "Water"},
[19] = {Name = "Rainfall", Type = "Water"},
[20] = {Name = "Water Gun", Type = "Water"},
[21] = {Name = "Wave Crash", Type = "Water"},
[22] = {Name = "Squall", Type = "Water"},
[23] = {Name = "Icicle Drop", Type = "Water"},
[24] = {Name = "Watersprout", Type = "Water"},
[25] = {Name = "Rock Claw", Type = "Rock"},
[26] = {Name = "Rock Roll", Type = "Rock"},
[27] = {Name = "Dust Devil", Type = "Rock"},
[28] = {Name = "Rock Ball", Type = "Rock"},
[29] = {Name = "Rock Slide", Type = "Rock"},
[30] = {Name = "Sand Shot", Type = "Rock"},
[31] = {Name = "Rock Fall", Type = "Rock"},
[32] = {Name = "Petit Quake", Type = "Rock"},
[33] = {Name = "Vaccum Cutter", Type = "Wind"},
[34] = {Name = "Shockwave", Type = "Wind"},
[35] = {Name = "Whirlwind", Type = "Wind"},
[36] = {Name = "Gust", Type = "Wind"},
[37] = {Name = "Wing Beat", Type = "Wind"},
[38] = {Name = "Tornado", Type = "Wind"},
[39] = {Name = "Gale", Type = "Wind"},
[40] = {Name = "Kamaitachi", Type = "Wind"},
[41] = {Name = "Ion Ball", Type = "Electric"},
[42] = {Name = "Static", Type = "Electric"},
[43] = {Name = "Electric Claw", Type = "Electric"},
[44] = {Name = "Discharge", Type = "Electric"},
[45] = {Name = "Electric Shock", Type = "Electric"},
[46] = {Name = "Electric Arrow", Type = "Electric"},
[47] = {Name = "Voltage", Type = "Electric"},
[48] = {Name = "Electric Field", Type = "Electric"},
[49] = {Name = "Claw", Type = "Normal"},
[50] = {Name = "Iron Claw", Type = "Normal"},
[51] = {Name = "Scale Shot", Type = "Normal"},
[52] = {Name = "Ring", Type = "Normal"},
[53] = {Name = "Bite", Type = "Normal"},
[54] = {Name = "Beak", Type = "Normal"},
[55] = {Name = "Kick", Type = "Normal"},
[56] = {Name = "Multi-Kick", Type = "Normal"},
[57] = {Name = "Sabre", Type = "Normal"},
[58] = {Name = "Tail", Type = "Normal"},
[59] = {Name = "Removed (1)", Type = "None"},
[60] = {Name = "Removed (2)", Type = "None"},
[61] = {Name = "Jump", Type = "Normal"},
[62] = {Name = "Tentacle", Type = "Normal"},
[63] = {Name = "Stun Tentacle", Type = "Normal"},
[64] = {Name = "Tackle", Type = "Normal"},
[65] = {Name = "Spit Spray", Type = "Normal"},
[66] = {Name = "Headbutt", Type = "Normal"},
[67] = {Name = "Removed (3)", Type = "None"},
[68] = {Name = "Horn", Type = "Normal"},
[69] = {Name = "Iron Horn", Type = "Normal"},
[70] = {Name = "Wing", Type = "Normal"},
[71] = {Name = "Thorn", Type = "Normal"},
[72] = {Name = "Rush", Type = "Normal"},
[73] = {Name = "Drain", Type = "Normal"},
[74] = {Name = "Bloodsuck", Type = "Normal"},
[75] = {Name = "Strike", Type = "Normal"},
[76] = {Name = "Razor Punch", Type = "Normal"},
[77] = {Name = "Hammer Punch", Type = "Normal"},
[78] = {Name = "Lick", Type = "Normal"},
[79] = {Name = "Needle", Type = "Normal"},
[80] = {Name = "Removed (4)", Type = "None"},
[81] = {Name = "Scissor", Type = "Normal"},
[82] = {Name = "Petals", Type = "Normal"},
[83] = {Name = "Wing Sabre", Type = "Normal"},
[84] = {Name = "Feather Knife", Type = "Normal"},
[85] = {Name = "Sting", Type = "Normal"},
[86] = {Name = "Poison Sting", Type = "Normal"},
[87] = {Name = "Numbing Sting", Type = "Normal"},
[88] = {Name = "Hoof", Type = "Normal"},
[89] = {Name = "Removed (5)", Type = "None"},
[90] = {Name = "Removed (6)", Type = "None"},
[91] = {Name = "Whip", Type = "Normal"},
[92] = {Name = "Denma Wire", Type = "Normal"},
[93] = {Name = "Stomach Acid", Type = "Normal"},
[94] = {Name = "Acid", Type = "Normal"},
[95] = {Name = "Stab", Type = "Normal"},
[96] = {Name = "Multi-Stab", Type = "Normal"},
[97] = {Name = "Ice Rock", Type = "Water"},
[98] = {Name = "Big Wave", Type = "Water"},
[99] = {Name = "Whirlpool", Type = "Water"},
[100] = {Name = "Ice Bullet", Type = "Water"},
[101] = {Name = "Blizzard", Type = "Water"},
[102] = {Name = "Water Pressure", Type = "Water"},
[103] = {Name = "Big Tsunami", Type = "Water"},
[104] = {Name = "Ion Beam", Type = "Electric"},
[105] = {Name = "Petit Bolt", Type = "Electric"},
[106] = {Name = "Plasma Laser", Type = "Electric"},
[107] = {Name = "Lightning Strike", Type = "Electric"},
[108] = {Name = "Thunderstorm", Type = "Electric"},
[109] = {Name = "Mega Bolt", Type = "Electric"},
[110] = {Name = "Electric Prison", Type = "Electric"},
[111] = {Name = "Wart Missile", Type = "Machine"},
[112] = {Name = "Gatling Gun", Type = "Machine"},
[113] = {Name = "Rapid Missile", Type = "Machine"},
[114] = {Name = "Bazooka", Type = "Machine"},
[115] = {Name = "Drill Missile", Type = "Machine"},
[116] = {Name = "Homing Missile", Type = "Machine"},
[117] = {Name = "Bombing Run", Type = "Machine"},
[118] = {Name = "Wave Cutter", Type = "Wind"},
[119] = {Name = "Pulse Wave", Type = "Wind"},
[120] = {Name = "Sandstorm", Type = "Wind"},
[121] = {Name = "Pressure", Type = "Wind"},
[122] = {Name = "Vacuum Hole", Type = "Wind"},
[123] = {Name = "Hurricane", Type = "Wind"},
[124] = {Name = "Black Hole", Type = "Wind"},
[125] = {Name = "Heat Ray", Type = "Fire"},
[126] = {Name = "Petit Burn", Type = "Fire"},
[127] = {Name = "Petit Flame", Type = "Fire"},
[128] = {Name = "Flamethrower", Type = "Fire"},
[129] = {Name = "Fire Breath", Type = "Fire"},
[130] = {Name = "Big Burn", Type = "Fire"},
[131] = {Name = "Removed (7)", Type = "None"},
[132] = {Name = "Bomb Rock", Type = "Rock"},
[133] = {Name = "Petit Rock", Type = "Rock"},
[134] = {Name = "Sand Prison", Type = "Rock"},
[135] = {Name = "Mega Quake", Type = "Rock"},
[136] = {Name = "Mega Rock", Type = "Rock"},
[137] = {Name = "Meteor Drop", Type = "Rock"},
[138] = {Name = "Diamond Rain", Type = "Rock"},
[139] = {Name = "Mushroom Bomb", Type = "Normal"},
[140] = {Name = "Egg Bomb", Type = "Normal"},
[141] = {Name = "Bomb", Type = "Normal"},
[142] = {Name = "Pulse Beam", Type = "Normal"},
[143] = {Name = "Ray Beam", Type = "Normal"},
[144] = {Name = "Blaster", Type = "Normal"},
[145] = {Name = "Suicide Attack", Type = "Normal"},
[146] = {Name = "Silk Shot", Type = "Offence"},
[147] = {Name = "Sticky Goo", Type = "Offence"},
[148] = {Name = "Smokescreen", Type = "Offence"},
[149] = {Name = "Flash", Type = "Offence"},
[150] = {Name = "Dust Cloud", Type = "Offence"},
[151] = {Name = "Recover", Type = "Defence"},
[152] = {Name = "Restore", Type = "Defence"},
[153] = {Name = "Shout", Type = "Offence"},
[154] = {Name = "Stare", Type = "Offence"},
[155] = {Name = "Glare", Type = "Offence"},
[156] = {Name = "Quick Step", Type = "Defence"},
[157] = {Name = "Speed Up", Type = "Defence"},
[158] = {Name = "Charge", Type = "Defence"},
[159] = {Name = "Full Charge", Type = "Defence"},
[160] = {Name = "Ultrasonic", Type = "Offence"},
[161] = {Name = "Curse Song", Type = "Offence"},
[162] = {Name = "Iron Defense", Type = "Defence"},
[163] = {Name = "Poison", Type = "Normal"},
[164] = {Name = "Poison Gas", Type = "Normal"},
[165] = {Name = "Stun Gas", Type = "Offence"},
[166] = {Name = "Cure", Type = "Defence"},
[167] = {Name = "Awaken", Type = "Defence"},
[168] = {Name = "Roar", Type = "Offence"},
[169] = {Name = "Heat Wave", Type = "Offence"},
[170] = {Name = "Shriek", Type = "Offence"},
[171] = {Name = "Chill", Type = "Offence"},
[172] = {Name = "Sleep Gas", Type = "Offence"},
[173] = {Name = "Lullaby", Type = "Offence"},
[174] = {Name = "Focus", Type = "Defence"},
[175] = {Name = "Denma Barrier", Type = "Defence"},
[176] = {Name = "Brace", Type = "Defence"},
[177] = {Name = "Cheer", Type = "Defence"},
[178] = {Name = "Defend", Type = "Defence"},
[179] = {Name = "Shield", Type = "Defence"},
[180] = {Name = "Bless", Type = "Defence"},
[181] = {Name = "Meditate", Type = "Defence"},
[182] = {Name = "Dig", Type = "Defence"},
[183] = {Name = "Dive", Type = "Defence"},
[184] = {Name = "Fly", Type = "Defence"},
[185] = {Name = "Evade", Type = "Defence"},
[186] = {Name = "Spore Cloud", Type = "Defence"},
[187] = {Name = "Taunt", Type = "Offence"},
[188] = {Name = "Provoke", Type = "Offence"},
[189] = {Name = "Denma Seal", Type = "Offence"},
[190] = {Name = "Denma Drain", Type = "Offence"},
[191] = {Name = "Death Song", Type = "Offence"},
[192] = {Name = "Energy Break", Type = "Offence"},
[193] = {Name = "Mega Break", Type = "Offence"},
[194] = {Name = "Count Down", Type = "Offence"},
[195] = {Name = "Strawberry Kiss", Type = "Defence"},
[196] = {Name = "Injection Plug", Type = "Machine"},
[197] = {Name = "Deflation Spiral", Type = "Normal"},
[198] = {Name = "Healing Spring", Type = "Defence"},
[199] = {Name = "Nove Smasher", Type = "Fire"}
}

--List of Denjuu by names, sorted by Index
local Denjuu = {[0] = {Name = "Muscovy (Basic)", Photo = 15},
[1] = {Name = "Muscovy (Natural)", Photo = 16},
[2] = {Name = "Muscovy (Aquatic)", Photo = 17},
[3] = {Name = "Major (Basic)", Photo = 176},
[4] = {Name = "Major (Grassland)", Photo = 177},
[5] = {Name = "Fraby (Basic)", Photo = 18},
[6] = {Name = "Fraby (Mountain)", Photo = 19},
[7] = {Name = "Fraby (Sky)", Photo = 20},
[8] = {Name = "Kagu (Basic)", Photo = 21},
[9] = {Name = "Kagu (Natural)", Photo = 22},
[10] = {Name = "Purchera (Basic)", Photo = 23}, 
[11] = {Name = "Purchera (Sky)", Photo = 24},
[12] = {Name = "Purchera (Forest)", Photo = 25},
[13] = {Name = "Mentalis (Basic)", Photo = 26},
[14] = {Name = "Mentalis (Natural)", Photo = 27},
[15] = {Name = "Mentalis (Forest)", Photo = 28},
[16] = {Name = "Mentalis (Grassland)", Photo = 29},
[17] = {Name = "Karinota (Basic)", Photo = 30},
[18] = {Name = "Karinota (Grassland)", Photo = 31},
[19] = {Name = "Karinota (Mountain)", Photo = 32},
[20] = {Name = "Chukar (Basic)", Photo = 37}, 
[21] = {Name = "Chukar (Natural)", Photo = 38},
[22] = {Name = "Chukar (Mountain)", Photo = 39},
[23] = {Name = "Chukar (Aquatic)", Photo = 40},
[24] = {Name = "Laperouse (Basic)", Photo = 33},
[25] = {Name = "Laperouse  (Natural)", Photo = 34},
[26] = {Name = "Laperouse (Desert)", Photo = 35},
[27] = {Name = "Laperouse (Grassland)", Photo = 36},
[28] = {Name = "Anpipitto (Basic)", Photo = 41},
[29] = {Name = "Anpipitto (Sky)", Photo = 42},
[30] = {Name = "Anpipitto (Desert)", Photo = 43}, 
[31] = {Name = "Ruficors (Basic)", Photo = 44},
[32] = {Name = "Ruficors (Grassland)", Photo = 45},
[33] = {Name = "Ruficors (Aquatic)", Photo = 46},
[34] = {Name = "Cotta (Basic)", Photo = 47},
[35] = {Name = "Cotta (Natural)", Photo = 48},
[36] = {Name = "Cotta (Desert)", Photo = 49},
[37] = {Name = "Rupicola (Basic)", Photo = 178},
[38] = {Name = "Rupicola (Grassland)", Photo = 179},
[39] = {Name = "Rupicola (Sky)", Photo = 180},
[40] = {Name = "Willcock (Basic)", Photo = 50}, 
[41] = {Name = "Willcock (Natural)", Photo = 51},
[42] = {Name = "Willcock (Forest)", Photo = 52},
[43] = {Name = "Skrippa (Basic)", Photo = 53},
[44] = {Name = "Skrippa (Aquatic)", Photo = 54},
[45] = {Name = "Cabot (Basic)", Photo = 55},
[46] = {Name = "Cabot (Natural)", Photo = 56},
[47] = {Name = "Makyuretto (Basic)", Photo = 57},
[48] = {Name = "Makyuretto (Natural)", Photo = 58},
[49] = {Name = "Makyuretto (Grassland)", Photo = 59},
[50] = {Name = "Makyuretto (Forest)", Photo = 60}, 
[51] = {Name = "Coronet (Basic)", Photo = 61},
[52] = {Name = "Coronet (Aquatic)", Photo = 62},
[53] = {Name = "Coronet (Grassland)", Photo = 63},
[54] = {Name = "Tataupa (Basic)", Photo = 64},
[55] = {Name = "Tataupa (Desert)", Photo = 65},
[56] = {Name = "Tataupa (Forest)", Photo = 66},
[57] = {Name = "Chigomozu (Basic)", Photo = 67},
[58] = {Name = "Chigomozu (Natural)", Photo = 68},
[59] = {Name = "Koikaru (Basic)", Photo = 69},
[60] = {Name = "Koikaru (Natural)", Photo = 70}, 
[61] = {Name = "Koikaru (Forest)", Photo = 71},
[62] = {Name = "Pewee (Basic)", Photo = 72},
[63] = {Name = "Pewee (Natural)", Photo = 73},
[64] = {Name = "Pewee (Aquatic)", Photo = 74},
[65] = {Name = "Pewee (Mountain)", Photo = 75},
[66] = {Name = "Chapmani (Basic)", Photo = 76},
[67] = {Name = "Chapmani (Natural)", Photo = 77},
[68] = {Name = "Hyuming (Basic)", Photo = 78},
[69] = {Name = "Hyuming (Natural)", Photo = 79},
[70] = {Name = "Hyuming (Mountain)", Photo = 80}, 
[71] = {Name = "Pamirio (Basic)", Photo = 81},
[72] = {Name = "Pamirio (Natural)", Photo = 82},
[73] = {Name = "Pamirio (Sky)", Photo = 83},
[74] = {Name = "Pamirio (Desert)", Photo = 84},
[75] = {Name = "Mistashi (Basic)", Photo = 85},
[76] = {Name = "Mistashi (Forest)", Photo = 86},
[77] = {Name = "Mistashi (Aquatic)", Photo = 87},
[78] = {Name = "Parrotto (Basic)", Photo = 181},
[79] = {Name = "Parrotto (Natural)", Photo = 182},
[80] = {Name = "Nebularia (Basic)", Photo = 183}, 
[81] = {Name = "Nebularia (Natural)", Photo = 184},
[82] = {Name = "Granti (Basic)", Photo = 185},
[83] = {Name = "Granti (Nautral)", Photo = 186},
[84] = {Name = "Granti (Desert)", Photo = 187},
[85] = {Name = "Penelope (Basic)", Photo = 88},
[86] = {Name = "Penelope (Aquatic)", Photo = 89},
[87] = {Name = "Penelope (Mountain)", Photo = 90},
[88] = {Name = "Ardea (Basic)", Photo = 188},
[89] = {Name = "Ardea (Natural)", Photo = 189},
[90] = {Name = "Ardea (Forest)", Photo = 190}, 
[91] = {Name = "Cerator (Basic)", Photo = 191},
[92] = {Name = "Cerator (Natural)", Photo = 192},
[93] = {Name = "Cerator (Mountain)", Photo = 193},
[94] = {Name = "Alpina (Basic)", Photo = 91},
[95] = {Name = "Alpina (Natural)", Photo = 92},
[96] = {Name = "Alpina (Aquatic)", Photo = 93},
[97] = {Name = "Alpina (Sky)", Photo = 94},
[98] = {Name = "Isuka (Basic)", Photo = 194},
[99] = {Name = "Isuka (Grassland)", Photo = 195},
[100] = {Name = "Bicolour (Basic)", Photo = 95}, 
[101] = {Name = "Bicolour (Natural)", Photo = 96},
[102] = {Name = "Hermit (Basic)", Photo = 97},
[103] = {Name = "Hermit (Natural)", Photo = 98},
[104] = {Name = "Hermit (Desert)", Photo = 99},
[105] = {Name = "Hermit (Grassland)", Photo = 100},
[106] = {Name = "Phoebe (Basic)", Photo = 101},
[107] = {Name = "Phoebe (Aquatic)", Photo = 102},
[108] = {Name = "Phoebe (Desert)", Photo = 103},
[109] = {Name = "Blossom (Basic)", Photo = 196},
[110] = {Name = "Blossom (Mountain)", Photo = 197}, 
[111] = {Name = "Rabricol (Basic)", Photo = 104},
[112] = {Name = "Rabricol (Natural)", Photo = 105},
[113] = {Name = "Rabricol (Aquatic)", Photo = 106},
[114] = {Name = "Demerus (Basic)", Photo = 107},
[115] = {Name = "Demerus (Natural)", Photo = 108},
[116] = {Name = "Demerus (Desert)", Photo = 109},
[117] = {Name = "Sparsa (Basic)", Photo = 110},
[118] = {Name = "Sparsa (Natural)", Photo = 111},
[119] = {Name = "Sparsa (Forest)", Photo = 112},
[120] = {Name = "Purprea (Basic)", Photo = 113}, 
[121] = {Name = "Purprea (Sky)", Photo = 114},
[122] = {Name = "Purprea (Grassland)", Photo = 115},
[123] = {Name = "Etopirika (Basic)", Photo = 116},
[124] = {Name = "Etopirika (Natural)", Photo = 117},
[125] = {Name = "Etopirika (Forest)", Photo = 118},
[126] = {Name = "Regulus (Basic)", Photo = 119},
[127] = {Name = "Regulus (Desert)", Photo = 120},
[128] = {Name = "Regulus (Sky)", Photo = 121},
[129] = {Name = "Akretto (Basic)", Photo = 122},
[130] = {Name = "Akretto (Natural)", Photo = 123}, 
[131] = {Name = "Akretto (Grassland)", Photo = 124},
[132] = {Name = "Akretto (Mountain)", Photo = 125},
[133] = {Name = "Seiran (Basic)", Photo = 198},
[134] = {Name = "Seiran (Mountain)", Photo = 199},
[135] = {Name = "Tectus (Basic)", Photo = 126},
[136] = {Name = "Tectus (Natural)", Photo = 127},
[137] = {Name = "Serrata (Basic)", Photo = 128},
[138] = {Name = "Serrata (Sky)", Photo = 129},
[139] = {Name = "Serrata (Forest)", Photo = 130},
[140] = {Name = "Kaya (T2)", Photo = 131}, 
[141] = {Name = "Beebalm (T2)", Photo = 132},
[142] = {Name = "Easydog (T2)", Photo = 133},
[143] = {Name = "Ruscus (T2)", Photo = 134},
[144] = {Name = "Ryuuguu (T2)", Photo = 135},
[145] = {Name = "Kanzou (T2)", Photo = 136},
[146] = {Name = "Ornithogalum (T2)", Photo = 137},
[147] = {Name = "Teletel (T2)", Photo = 138},
[148] = {Name = "Dendel (T2)", Photo = 139},
[149] = {Name = "Suguri (T2)", Photo = 140},
[150] = {Name = "Suguline (T2)", Photo = 141}, 
[151] = {Name = "Saiguliger (T2)", Photo = 142},
[152] = {Name = "Punica (T2)", Photo = 143},
[153] = {Name = "Punisto (T2)", Photo = 144},
[154] = {Name = "Oshe (T2)", Photo = 145},
[155] = {Name = "Barriarm (T2)", Photo = 146},
[156] = {Name = "Bashou (T2)", Photo = 147},
[157] = {Name = "Gentiana (T2)", Photo = 148},
[158] = {Name = "Gonum (T2)", Photo = 149},
[159] = {Name = "Gust (T2)", Photo = 150},
[160] = {Name = "Storm (T2)", Photo = 151}, 
[161] = {Name = "Tsunonasu (T2)", Photo = 152},
[162] = {Name = "Gigagigearth (T2)", Photo = 153},
[163] = {Name = "Liriope (T2)", Photo = 154},
[164] = {Name = "Lirimonarch (T2)", Photo = 155},
[165] = {Name = "Waratah (T2)", Photo = 156},
[166] = {Name = "Enteiou (T2)", Photo = 157},
[167] = {Name = "Gumi (T2)", Photo = 158},
[168] = {Name = "Gymnos (T2)", Photo = 159},
[169] = {Name = "Gymbaron (T2)", Photo = 160},
[170] = {Name = "Gymzyrus (T2)", Photo = 161}, 
[171] = {Name = "Gymzatan (T2)", Photo = 162},
[172] = {Name = "Angios (T2)", Photo = 163},
[173] = {Name = "Angigorgo (T2)", Photo = 164},
[174] = {Name = "Angipower (T2)", Photo = 165},
[175] = {Name = "Angioros (T2)", Photo = 166},
[176] = {Name = "Fungus (T2)", Photo = 167},
[177] = {Name = "Fungwar (T2)", Photo = 168},
[178] = {Name = "Funboost (T2)", Photo = 169},
[179] = {Name = "Funblade (T2)", Photo = 170},
[180] = {Name = "Rex (Basic)", Photo = 0}, 
[181] = {Name = "Rex (Natural-1)", Photo = 1},
[182] = {Name = "Rex (Desert)", Photo = 2},
[183] = {Name = "Rex (Forest)", Photo = 3},
[184] = {Name = "Rex (Natural-2)", Photo = 4},
[185] = {Name = "Doon (Basic)", Photo = 5},
[186] = {Name = "Doon (Natural-1)", Photo = 6},
[187] = {Name = "Doon (Sky)", Photo = 7},
[188] = {Name = "Doon (Aquatic)", Photo = 8},
[189] = {Name = "Doon (Natural-2)", Photo = 9},
[190] = {Name = "Gyuun (Basic)", Photo = 10}, 
[191] = {Name = "Gyuun (Natural-1)", Photo = 11},
[192] = {Name = "Gyuun (Aquatic)", Photo = 12},
[193] = {Name = "Gyuun (Forest)", Photo = 13},
[194] = {Name = "Gyuun (Natural-2)", Photo = 14},
[195] = {Name = "Diablos (Basic)", Photo = 171},
[196] = {Name = "Diablos (Natural-1)", Photo = 172},
[197] = {Name = "Diablos (Mountain)", Photo = 173},
[198] = {Name = "Diablos (Grassland)", Photo = 174},
[199] = {Name = "Diablos (Natural-2)", Photo = 175}
}

--Addresses I'm interested regarding speed version
local Speed = {
Enemy = {0x41F2,0x422A,0x4262},
State = 0x042C,
Map = 0x4F90,
Player_X = 0x4CF8,
Player_Y = 0x4CFC,
Money = 0x4CF4,
Boss = 0x2888,
Story = 0x4DD7,
Music = 0x4AE2,	--Seems like it's the background music ID; can use this to check if in battle
Counter = 0x0840,
Win = 0x2870,
Battle_Event_Timer = 0x2BA0,
Battle_State = 0x2C16,
Miss = 0x2C14,
Crit = 0x2C22,
Move = 0x2B06,
Damage = 0x2A0B,
Talk = 0x50F4, --State of dialogue
RNG1 = 0x5E08,
RNG2 = 0x5E10
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
Story = 0x4DE7,
Music = 0x4AF2,
Counter = 0x0850,
Win = 0x2880,
Battle_Event_Timer = 0x2BB0,
Battle_State = 0x2C26,
Miss = 0x2C24,
Crit = 0x2C32,
Move = 0x2B16,
Damage = 0x2A1B,
Talk = 0x5104, --State of dialogue
RNG1 = 0x5E18,
RNG2 = 0x5E20
}

local function GetStats(addr,o)
	o = o or {} --Construct a table if we didn't get one
	o.address = bizstring.hex(addr)
	o.id = memory.readbyte(addr)
	o.level = memory.readbyte(addr+1)
	o.exists = memory.readbyte(addr+1) > 0	--unless glitched, level should always be greater than 0
	o.hp = memory.readbyte(addr+2)
	o.max_hp = memory.readbyte(addr+3)
	o.dp = memory.readbyte(addr+4)	--special attack points
	o.speed = memory.readbyte(addr+5)
	o.attack = memory.readbyte(addr+6)
	o.defence = memory.readbyte(addr+7)
	o.special = memory.readbyte(addr+8)
	o.nature = memory.readbyte(addr+10)
	o.fd = memory.readbyte(addr+11)	--something to do with phones
	o.ally = memory.readbyte(addr+21)
	o.attack1 = memory.readbyte(addr+22)
	o.attack1_power = memory.readbyte(addr+23)
	o.attack2 = memory.readbyte(addr+30)
	o.attack2_power = memory.readbyte(addr+31)
	o.attack3 = memory.readbyte(addr+38)
	o.attack3_power = memory.readbyte(addr+39)
	o.attack4 = memory.readbyte(addr+46)
	o.attack4_power = memory.readbyte(addr+47)
	o.next_turn = memory.readbyte(addr+54)
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
	local npc_count = 0
	--booleans
	local in_battle
	local display_individual
	local npc_present
	if address ~= nil then	--make sure address is valid
		in_battle = (memory.readbyte(address.Music) >= 5 and memory.readbyte(address.Music) <= 9)	--checking music to see if in battle
		battle_state = memory.readbyte(address.Battle_State)
		battle_timer = memory.readbyte(address.Battle_Event_Timer)
		damage = memory.readbyte(address.Damage)
		critical = memory.readbyte(address.Crit)
		move_selected = memory.readbyte(address.Move)
		boss = memory.readbyte(address.Boss)
		state = memory.readbyte(address.State)
	else
		in_battle = false
	end
	l_toggle = (toggle ~= nil and toggle or toggle_states["None"])	--default value of 0
	if in_battle then
	--Interface for toggling display
		gui.drawText(0,150,"Denjuu X 1 2 3 A ",null,null,10,null,null) --Click these for info
		if (input.getmouse().Left and get_mouse_pos(30,150,24,10)) then
			l_toggle = toggle_states["None"]
		elseif (input.getmouse().Left and get_mouse_pos(55,150,9,10)) then 
			l_toggle = toggle_states["NPC1"]
		elseif (input.getmouse().Left and get_mouse_pos(65,150,11,10)) then 
			l_toggle =  toggle_states["NPC2"]
		elseif (input.getmouse().Left and get_mouse_pos(78,150,11,10)) then 
			l_toggle =  toggle_states["NPC3"]
		elseif (input.getmouse().Left and get_mouse_pos(90,150,10,10)) then 
			l_toggle =  toggle_states["All"]
		else
		end
	--Get opponent stats
		for i = 1, 3 do
			npc[i] = GetStats(address.Enemy[i])
			if npc[i].exists then npc_count = npc_count + 1 end
		end
	--Draw opponent stats
		display_individual = (l_toggle > toggle_states["None"] and l_toggle < toggle_states["All"])
		if display_individual then
			if npc[l_toggle].exists then
				line = "E"..l_toggle.." "..Denjuu[npc[l_toggle].id].Name.." ID:"..npc[l_toggle].id
				gui.drawText(0,20,line,null,null,10,null,null)
				line = "Ally:"..Denjuu[npc[l_toggle].ally].Name.." ID:"..npc[l_toggle].ally
				gui.drawText(0,30,line,null,null,10,null,null)
				line = "LV:"..npc[l_toggle].level.." HP:"..npc[l_toggle].hp.."/"..npc[l_toggle].max_hp.." DP:"..npc[l_toggle].dp
				gui.drawText(0,40,line,null,null,10,null,null)
				line = "SPD:"..npc[l_toggle].speed.." ATK:"..npc[l_toggle].attack.." DEF:"..npc[l_toggle].defence.." SPEC:"..npc[l_toggle].special
				gui.drawText(0,50,line,null,null,10,null,null)
				line = Attacks[npc[l_toggle].attack1].Name.."("..npc[l_toggle].attack1..") P"..npc[l_toggle].attack1_power..
				" | "..Attacks[npc[l_toggle].attack2].Name.."("..npc[l_toggle].attack2..") P"..npc[l_toggle].attack2_power..")\n"
				..Attacks[npc[l_toggle].attack3].Name.."("..npc[l_toggle].attack3..") P"..npc[l_toggle].attack3_power..
				" | "..Attacks[npc[l_toggle].attack4].Name.."("..npc[l_toggle].attack4..") P"..npc[l_toggle].attack4_power
				gui.drawText(0,60,line,null,null,10,null,null)
			end
		end
	--Display only states, without moves		
		if toggle == toggle_states["All"] then
			for i=1,3 do
				if npc[i].exists then
					line = "E"..i.." ID:"..npc[i].id.." LV:"..npc[i].level.." HP:"..npc[i].hp.."/"..npc[i].max_hp.." DP:"..npc[i].dp
					gui.drawText(0,10+(20*i),line,null,null,10,null,null)
					line = "SPD:"..npc[i].speed.." ATK:"..npc[i].attack.." DEF:"..npc[i].defence.." SPEC:"..npc[i].special
					gui.drawText(0,20+(20*i),line,null,null,10,null,null)
				end
			end
			gui.drawText(0,20,"Denjuu left:"..npc_count,null,null,10,null,null)
		end
	--Other things to display during a battle
			gui.text(0,235,"Battle State:"..battle_state.." DMG "..damage.."("..critical..")")
			gui.text(0,250,"Battle timer:"..battle_timer)
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
	local music
	local num = 0	--For NPC
	local overworld	--boolean
	local addr
	if address ~= nil then	--make sure address is valid
		music = memory.readbyte(address.Music)
	end
	--Checking if overworld music is playing to display npc data
	overworld = music ~= nil and (music >= 17 and music <= 43) or false
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
				gui.drawText(npc.xcam-20,npc.ycam,"X"..npc.x.." Y"..npc.y.."s"..npc.state,null,null,10,null,null)
				gui.drawText(npc.xcam-5,npc.ycam-20,num,null,null,10,null,null)
			elseif toggle == toggle_states["View2"] then
				gui.drawText(0,num*10,"X"..npc.x.." Y"..npc.y.."s"..npc.state.." #"..num,null,null,10,null,null)
				gui.drawText(npc.xcam-5,npc.ycam-20,num,null,null,10,null,null)
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
	local box_width = 45
	local box_height = 10
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
		music = memory.readbyte(address.Music)
	end
	l_toggle = (toggle ~= nil and toggle or toggle_states["None"])	--default value of 0
	
	in_overworld = music ~= nil and (music >= 17 and music <= 43) or false
	if in_overworld then
	--only check toggle out of battle
		gui.drawText(0,150,"View 1  View 2 OFF",null,null,10,null,null) --Click these for info
		if (input.getmouse().Left and get_mouse_pos(0,150,box_width,box_height)) then
			l_toggle = toggle_states["View1"]
		elseif (input.getmouse().Left and get_mouse_pos(box_width,150,box_width,box_height)) then
			l_toggle = toggle_states["View2"]
		elseif (input.getmouse().Left and get_mouse_pos(box_width*2,150,box_width,box_height)) then
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
