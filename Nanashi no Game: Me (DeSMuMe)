player = {x = 0x21347FC, y = 0x2134804, camx = 0x2134820, camy = 0x2134822} --camx in terms of upright view; same for camy. so camx looks up/down
regret = 0x2133828
local centerx = 127
local centery = 96
local l_sqrt = math.sqrt
local sformat = string.format
local l_rad = math.rad
local l_sin = math.sin
local l_cos = math.cos
--[[
These are not needed, since they are all offset by each other. Here for reference:
regret1 = {x = 0x2133828, y = 0x2133830, destx = 0x21338B8, desty = 0x21338C0, angle = 0x213384C}
regret2 = {x = 0x2133AD8, y = 0x2133AE0, destx = 0x2133B68, desty = 0x2133B70, angle = 0x2133AFC}
regret3= {x = 0x2133D88, y = 0x2133D90, angle = 0x2133DAC}
regret4= {x = 0x2134038, y = 0x2134040, angle = 0x213405C}

--the following when moving forward
--camy = 12.000 x decreases
--camy = 4.000 x increases; 0 degrees?
--camy = 8.000 y decreases
--camy = 0.000 y increases (this is same as 16); so this means 270 degrees
]]--

 --Declarations here
--[[
 GetStats by FatRatKnight
 http://tasvideos.org/forum/viewtopic.php?p=458672#458672
 ]]--
local function GetStats(addr,o)
    o = o or {} --Construct a table if we didn't get one
    o.X = memory.readlongsigned(addr)/4096.0
    o.Y = memory.readlongsigned(addr+0x8)/4096.0
    o.destX = memory.readlongsigned(addr+0x90)/4096.0
    o.destY = memory.readlongsigned(addr+0x98)/4096.0
    o.Angle = memory.readlongsigned(addr+0x24)/4096.0
    --... And so on
    return o
end

function to_Radian(cam)
	local short = 65535/4096.0  --short to 20.12 format
	local radian = short/l_rad(360)  --Divide this to convert to radians
	return (cam/radian)-l_rad(90)  --Apparently to make "0" point up
end

--function to return coords based on their position
function return_coords_x(player_x, enemy_x, enemy_diffx)
	if player_x == enemy_x then
		return centerx
	end
	if player_x < enemy_x then  --Enemy is to the right of player
		return centerx + enemy_diffx
	end
	if player_x > enemy_x then  --Enemy is to the left of player
		return centerx - enemy_diffx
	end
end

function return_coords_y(player_y, enemy_y, enemy_diffy)
	if player_y == enemy_y then
		return centery
	end
	if player_y < enemy_y then  --Enemy is "above" player (lower y == higher up in screen)
		return centery - enemy_diffy
	end
	if player_y > enemy_y then  --Enemy is "below" player (lower y == higher up in screen)
		return centery + enemy_diffy
	end
end

--returns difference depending on conditions
--see https://stackoverflow.com/questions/339961/difference-between-2-numbers
function difference(num1, num2)
	return (num1 > num2) and (num1 - num2) or (num2 - num1)
end

function display()
	local Enemy = {}
	local playerx = memory.readlongsigned(player.x)/4096.0
	local playery = memory.readlongsigned(player.y)/4096.0
	local playercamx = memory.readshort(player.camx)/4096.0
	local playercamy = memory.readshort(player.camy)/4096.0

	local regret_difx
	local regret_dify
--for their target destination coords
	local regret_difx_dest
	local regret_dify_dest
	local directionx = 20*l_cos(to_Radian(playercamy))+centerx
	local directiony = 20*l_sin(to_Radian(playercamy))+centery
	local regret_color = "white"
	for i= 1, 3 do
		Enemy[i] = GetStats(regret + (i-1)*0x2B0)  --i-1 for 1 offset array with 0 offset addresses. Horrifying, I know.
	end

  
--For reference
	gui.drawtext(0,0,"Player: ("..sformat('%.6f',playerx)..","..sformat('%.6f',playery)..")")
	gui.drawtext(0,10,"Camera: ("..sformat('%.6f',playercamx)..","..sformat('%.6f',playercamy)..")")
	gui.drawtext(0,20,"Regret 1: ("..sformat('%.6f',Enemy[1].X)..","..sformat('%.6f',Enemy[1].Y)..")"..sformat('%.6f',Enemy[1].Angle))
	gui.drawtext(0,30,"Regret 2: ("..sformat('%.6f',Enemy[2].X)..","..sformat('%.6f',Enemy[2].Y)..")"..sformat('%.6f',Enemy[2].Angle))
	gui.drawtext(0,40,"Regret 3: ("..sformat('%.6f',Enemy[3].X)..","..sformat('%.6f',Enemy[3].Y)..")"..sformat('%.6f',Enemy[3].Angle))
  
--Drawing for player
	gui.line(centerx-5,centery-5,centerx+5,centery+5,"white")
	gui.line(centerx-5,centery+5,centerx+5,centery-5,"white")
	gui.line(centerx,centery,directionx,directiony,"white") --My direction

--Display location of regrets relative to you, at the center
	for i = 1, 3 do
--Shitty heurestic to determine if regret is present
    if (Enemy[i].X ~= 0) and (Enemy[i].Y ~= 0) then	
		regret_difx = difference(playerx,Enemy[i].X)
		regret_dify = difference(playery,Enemy[i].Y)
		regret_difx_dest = difference(playerx,Enemy[i].destX)
		regret_dify_dest = difference(playery,Enemy[i].destY)

--Placement relative to player
		regret_difx = return_coords_x(playerx, Enemy[i].X, regret_difx)
		regret_dify = return_coords_y(playery, Enemy[i].Y, regret_dify)
		regret_difx_dest = return_coords_x(playerx, Enemy[i].destX, regret_difx_dest)
		regret_dify_dest = return_coords_y(playery, Enemy[i].destY, regret_dify_dest)

--Destination
		if (Enemy[i].X ~= Enemy[i].destX) or (Enemy[i].Y ~= Enemy[i].destY) then
			regret_color = "red"
			gui.line(regret_difx,regret_dify, regret_difx_dest, regret_dify_dest,regret_color)
			gui.drawtext(regret_difx_dest, regret_dify_dest,"D"..i,regret_color)
		else
			regret_color = "white"
		end
			regret_dirx = 20*l_cos(to_Radian(Enemy[i].Angle)) + regret_difx
			regret_diry = 20*l_sin(to_Radian(Enemy[i].Angle)) + regret_dify
			gui.drawtext(regret_difx, regret_dify,"R"..i,regret_color)
			gui.line(regret_difx,regret_dify,regret_dirx,regret_diry,regret_color)
		end
	end
end
gui.register(display)
