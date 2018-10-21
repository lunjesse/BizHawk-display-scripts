memory.usememorydomain("EWRAM")
-- gui.DrawNew("native")
-- client.setwindowsize(2) --Sets size so that everything fits
-- client.SetGameExtraPadding(0, 0, 0, 20)
local peppermints = 0x3DE9 --6%+ total
local bottles = 0x3E11 --3% total
local brassHeart = 0x3E13 --6% total
local events = 0x3EA2 --17% total
local candyBox = 0x4730 --1% total
local keyItems = 0x4731 --11% total
local toys = 0x4732 --12% total
local toys2 = 0x4733 -- 10% total
local waterguns = 0x4734 --16% total
local gear = 0x4735 --12% total + 3% at gear+1
local characters = {'DJ','Chowder','Jenny'}
local water = {0x37D0,0x37D2,0x37D4}  --Water supply
local water2 = {0x3DF6,0x3DF8,0x3DFA} --Water capacity; only updates when gun is upgrade via chest
local pointerx = 0xB3D8
local player = {x = 0, y = 0, address = 0}
local character = 0x3DE8

--Checks the bit of 'mem' at position 'pos' and returns 'value' if it's 1
function addFlags(mem,pos,value)
	if bit.check(mem,pos) then return value
	else return 0 end
end

function check_percent(address, percent,...)
--checks address for bits from ..., then if it exists add percent to result.
	local l_address = memory.read_s8(address)
	local result = 0
	for i, v in ipairs({...}) do
		if bit.check(l_address, v) then result = result + percent end
	end
	return result
end

function percent()
	--splitting percentage for debug
	local misc_p, key_item_p, toy_p, watergun_p, gear_p, story_p = 0,0,0,0,0,0
	local percent_value = 0
	local percent = 0
  --Checks if the player has the peppermints
	misc_p = memory.read_s8(peppermints) + misc_p
  --Check if the player has all 3 bottles (1% each)
	misc_p = addFlags(memory.read_s8(bottles),0,1) + misc_p --All Bottles are 1%
	misc_p = addFlags(memory.read_s8(bottles),1,2) + misc_p --But getting the 2nd bottle makes the value for the above 0
  --Check if the player has a brass heart (2% each)
	misc_p = memory.read_s8(brassHeart) * 2 + misc_p
  --Check if the player has the Candy box (1%)
	misc_p = addFlags(memory.read_s8(candyBox),1,1) + misc_p
  --Checks if the player has the following: Fuse (3%), Dynamite (3%), Elevator Gear (3%), Walkie-Talkie (1%), Flashlight (1%)
	percent_value = 1
	key_item_p = key_item_p + check_percent(keyItems,percent_value,3,4)		--Flashlight, Walkie-Talkie
	percent_value = 3
	key_item_p = key_item_p + check_percent(keyItems,percent_value,5,6,7)	--Elevator Gear, Dynamite, Fuse
  --Checks if the player has the following: Rover's bone (2%), RC Car (2%), Chicken doll (2%), Boomerang (2%), Chowder's basketball (2%), Skull's action figure (2%)
	percent_value = 2
	toy_p = toy_p + check_percent(toys,percent_value,2,3,4,5,6,7)	--Skull's action figure, Chowder's basketball, Boomerang, Chicken doll, RC Car, Rover's bone
  --Checks if the player has the following: Watergun ugrade (DJ 1, 1%), ?? (1%), Wendy the Dancing Walrus doll (2%), Jenny's wagon (2%), Tricycle (2%),  Penguin doll (2%),  Bone's kite (2%)
	+ check_percent(toys2,percent_value,0,1,2,3,4)				--Bone's kite, Penguin doll, Tricycle, Jenny's wagon, Wendy the Dancing Walrus doll
	--Watergun upgrade for DJ
	--Checks if the player has the following: Watergun ugrade (Jenny 1, 2%), Watergun ugrade (Jenny 2, 2%), Watergun ugrade (Jenny 3, 2%), Watergun upgrade (Chowder 1, 2%), Watergun upgrade (Chowder 2, 2%), Watergun upgrade (Chowder 3, 2%), Watergun ugrade (DJ 2, 2%), Watergun ugrade (DJ 3, 2%)
	watergun_p = watergun_p + addFlags(memory.read_s8(toys2),7,1) + check_percent(waterguns,percent_value,0,1,2,3,4,5,6,7)
  --Checks if the player has the following: Trash can (1%), Slingshot upgrade (3%), Slingshot (1%), Cold Syrup (1%), Water balloon upgrade (3%), Water balloon (1%), Brass Key (1%)
	percent_value = 1
	gear_p = gear_p + check_percent(gear,percent_value,0,1,2,4,5,7) -- Camera, Brass Key, Water balloon, Cold Syrup, Slingshot, Trash Can
	percent_value = 3
	gear_p = gear_p + check_percent(gear,percent_value,3,6) + addFlags(memory.read_s8(gear+1),0,3)	--Water balloon, Slingshot & Camera upgrades
  --Checks the story events done
	if memory.read_s8(events) > 14 then story_p = story_p + 1 end
	if memory.read_s8(events) > 18 then story_p = story_p + 1 end
	if memory.read_s8(events) > 24 then story_p = story_p + 1 end
	if memory.read_s8(events) > 30 then story_p = story_p + 2 end
	if memory.read_s8(events) > 32 then story_p = story_p + 1 end
	if memory.read_s8(events) > 37 then story_p = story_p + 2 end
	if memory.read_s8(events) > 41 then story_p = story_p + 1 end
	if memory.read_s8(events) > 45 then story_p = story_p + 1 end
	if memory.read_s8(events) > 50 then story_p = story_p + 2 end
	if memory.read_s8(events) > 54 then story_p = story_p + 3 end
	if memory.read_s8(events) > 57 then story_p = story_p + 1 end
	if memory.read_s8(events) > 62 then story_p = story_p + 1 end
	percent = misc_p + key_item_p + toy_p + watergun_p + gear_p + story_p
	gui.text(0, client.screenheight()-32, 'misc: '..misc_p..' key: '..key_item_p..' toy '..toy_p..' gun '..watergun_p..' gear '..gear_p..' story '.. story_p)
	gui.text(0, client.screenheight()-42, 'Percent: '..percent)
	gui.text(0, client.screenheight()-52, 'events '..memory.read_s8(events))
end

function miscflags()
--[[
The following do not contribute to percentage. They instead indicate if certain events have been achieved:
* Unlocked doombringer (not saved in SRAM sadly)
* Checks if the player has obtained the Camera flash at least once
* Checks if the player has obtained candy at least once
* Checks if the player has obtained soda at least once
* Checks if the player has obtained marbles at least onced
* Checks if the player has obtained water at least once
* Checks if the player has obtained water bottle at least once
* Checks if the player has unlocked the Toys tab
 ]]--
	local doombringer = bit.check(memory.read_s8(toys2),6)
	local camera_flash = bit.check(memory.read_s8(candyBox),7)
	local candy = bit.check(memory.read_s8(candyBox),2)
	local soda = bit.check(memory.read_s8(candyBox),3)
	local marble = bit.check(memory.read_s8(candyBox),6)
	local water_drop = bit.check(memory.read_s8(keyItems),0)
	local bottle = bit.check(memory.read_s8(gear+1),1)
	local toy_tab = bit.check(memory.read_s8(keyItems),2)
end

function update()
	local ptr = memory.read_s32_le(pointerx)
	if ptr > 0x02000000 and ptr < 0x03000000 then
		return ptr - 0x02000000	--Minus (0x02000000) since BizHawk memory domains
	end
	return nil
end

function displaychar()
	local x,y = 0,0
	local ptr = update()
	if ptr ~= nil then
		player.x = memory.read_u32_le(ptr + 0x14)
		player.y = memory.read_u32_le(ptr + 0x18)
		player.address = ptr
		x = string.format('%.5f',player.x/65536.0)
		y = string.format('%.5f',player.y/65536.0)
	end
	local l_char = memory.read_s8(character)
	gui.text(0, 60, 'X: '..x..' Y: '..y)
	if l_char < 3 then  -- just in case
		local supply = memory.read_s16_le(water[l_char+1])  --Char uses 0,1,2 but lua arrays are 1,2,3
		local capacity = memory.read_s16_le(water2[l_char+1])
		gui.text(0, 75, characters[l_char+1]..'('..supply..'/'..capacity..')')
  end
end

while true do
  percent()
  -- miscflags()
  displaychar()
  emu.frameadvance()
end
