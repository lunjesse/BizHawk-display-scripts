--Makes spreadsheet-able tables for some data about this game
--Refer to: http://datacrystal.romhacking.net/wiki/Keitai_Denjuu_Telefang_2:ROM_map
--table1 is a list of denjuu, and all 5 moves they could learn
--lvl of 255 means the denjuu does not learn anything that replaces move 2 (ie. no move 5)
--table2 is a list of moves, and all denjuu which can learn it
--move 0 means that denjuu lacks move 5
local Attack = {
[0] = {Name = "????", Type = "None"},
[1] = {Name = "Ember", Type = "Fire"},
[2] = {Name = "Fireball", Type = "Fire"},
[3] = {Name = "Fire Pillar", Type = "Fire"},
[4] = {Name = "Petit Fire", Type = "Fire"},
[5] = {Name = "Will o' Wisp", Type = "Fire"},
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
[199] = {Name = "Nove Smasher", Type = "Fire"},
[255] = {Name = "None", Type = "None"}
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
