memory.usememorydomain("EWRAM")
gui.DrawNew("native")
client.setwindowsize(2) --Sets size so that everything fits
client.SetGameExtraPadding(0, 0, 0, 20)
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

--Checks the bit of 'mem' at position 'pos' and returns 'value' if it's 1
function addFlags(mem,pos,value)
if bit.check(mem,pos) then return value
else return 0 end
end

function percent()
  local percent = 0
  --Checks if the player has the peppermints
  percent = memory.read_s8(peppermints) + percent
  --Check if the player has all 3 bottles (1% each)
  percent = addFlags(memory.read_s8(bottles),0,1) + percent --All Bottles are 1%
  percent = addFlags(memory.read_s8(bottles),1,2) + percent --But getting the 2nd bottle makes the value for the above 0
  --Check if the player has a brass heart (2% each)
  percent = memory.read_s8(brassHeart) * 2 + percent
  --Check if the player has the Candy box (1%)
  percent = addFlags(memory.read_s8(candyBox),1,1) + percent
  --Checks if the player has the following: Fuse (3%), Dynamite (3%), Elevator Gear (3%), Walkie-Talkie (1%), Flashlight (1%)
  percent = addFlags(memory.read_s8(keyItems),3,1) + percent  --Flashlight
  percent = addFlags(memory.read_s8(keyItems),4,1) + percent  --Walkie-Talkie
  percent = addFlags(memory.read_s8(keyItems),5,3) + percent  --Elevator Gear
  percent = addFlags(memory.read_s8(keyItems),6,3) + percent  --Dynamite
  percent = addFlags(memory.read_s8(keyItems),7,3) + percent  --Fuse
  --Checks if the player has the following: Rover's bone (2%), RC Car (2%), Chicken doll (2%), Boomerang (2%), Chowder's basketball (2%), Skull's action figure (2%)
  percent = addFlags(memory.read_s8(toys),2,2) + percent --Skull's action figure
  percent = addFlags(memory.read_s8(toys),3,2) + percent --Chowder's basketball
  percent = addFlags(memory.read_s8(toys),4,2) + percent --Boomerang
  percent = addFlags(memory.read_s8(toys),5,2) + percent --Chicken doll
  percent = addFlags(memory.read_s8(toys),6,2) + percent --RC Car
  percent = addFlags(memory.read_s8(toys),7,2) + percent --Rover's bone
  --Checks if the player has the following: Watergun ugrade (DJ 1, 1%), ?? (1%), Wendy the Dancing Walrus doll (2%), Jenny's wagon (2%), Tricycle (2%),  Penguin doll (2%),  Bone's kite (2%)
  percent = addFlags(memory.read_s8(toys2),0,2) + percent --Bone's kite
  percent = addFlags(memory.read_s8(toys2),1,2) + percent --Penguin doll
  percent = addFlags(memory.read_s8(toys2),2,2) + percent --Tricycle
  percent = addFlags(memory.read_s8(toys2),3,2) + percent --Jenny's wagon
  percent = addFlags(memory.read_s8(toys2),4,2) + percent --Wendy the Dancing Walrus doll
  percent = addFlags(memory.read_s8(toys2),6,0) + percent --Doombringer unlocked; placeholder for this script
  percent = addFlags(memory.read_s8(toys2),7,1) + percent --Watergun upgrade for DJ
  --Checks if the player has the following: Watergun ugrade (Jenny 1, 2%), Watergun ugrade (Jenny 2, 2%), Watergun ugrade (Jenny 3, 2%), Watergun upgrade (Chowder 1, 2%), Watergun upgrade (Chowder 2, 2%), Watergun upgrade (Chowder 3, 2%), Watergun ugrade (DJ 2, 2%), Watergun ugrade (DJ 3, 2%)
  percent = addFlags(memory.read_s8(waterguns),0,2) + percent --Watergun upgrade for DJ
  percent = addFlags(memory.read_s8(waterguns),1,2) + percent --Watergun upgrade for DJ
  percent = addFlags(memory.read_s8(waterguns),2,2) + percent --Watergun upgrade for Chowder
  percent = addFlags(memory.read_s8(waterguns),3,2) + percent --Watergun upgrade for Chowder
  percent = addFlags(memory.read_s8(waterguns),4,2) + percent --Watergun upgrade for Chowder
  percent = addFlags(memory.read_s8(waterguns),5,2) + percent --Watergun upgrade for Jenny
  percent = addFlags(memory.read_s8(waterguns),6,2) + percent --Watergun upgrade for Jenny
  percent = addFlags(memory.read_s8(waterguns),7,2) + percent --Watergun upgrade for Jenny
  --Checks if the player has the following: Trash can (1%), Slingshot upgrade (3%), Slingshot (1%), Cold Syrup (1%), Water balloon upgrade (3%), Water balloon (1%), Brass Key (1%)
  percent = addFlags(memory.read_s8(gear),0,1) + percent  --Camera
  percent = addFlags(memory.read_s8(gear),1,1) + percent  --Brass Key
  percent = addFlags(memory.read_s8(gear),2,1) + percent  --Water balloon
  percent = addFlags(memory.read_s8(gear),3,3) + percent  --Water balloon upgrade
  percent = addFlags(memory.read_s8(gear),4,1) + percent  --Cold Syrup
  percent = addFlags(memory.read_s8(gear),5,1) + percent  --Slingshot
  percent = addFlags(memory.read_s8(gear),6,3) + percent  --Slingshot upgrade
  percent = addFlags(memory.read_s8(gear),7,1) + percent  --Trash Can
  percent = addFlags(memory.read_s8(gear+1),0,3) + percent  --Camera upgrade
  --Checks the story events done
  if memory.read_s8(events) > 14 then percent = percent + 1 end
  if memory.read_s8(events) > 18 then percent = percent + 1 end
  if memory.read_s8(events) > 24 then percent = percent + 1 end
  if memory.read_s8(events) > 30 then percent = percent + 2 end
  if memory.read_s8(events) > 32 then percent = percent + 1 end
  if memory.read_s8(events) > 37 then percent = percent + 2 end
  if memory.read_s8(events) > 41 then percent = percent + 1 end
  if memory.read_s8(events) > 45 then percent = percent + 1 end
  if memory.read_s8(events) > 50 then percent = percent + 2 end
  if memory.read_s8(events) > 54 then percent = percent + 3 end
  if memory.read_s8(events) > 57 then percent = percent + 1 end
  if memory.read_s8(events) > 62 then percent = percent + 1 end
  gui.text(0, client.screenheight()-42, 'Percent: '..percent)
end

function miscflags()
  local y = client.screenheight()-10
  gui.text(0, y-18, 'Flags: ')
  --Checks if the player has obtained the Camera flash at least once
  if bit.check(memory.read_s8(candyBox),7) then gui.drawRectangle(0, y, 4, 10, 'WHITE', 'WHITE') end
  --Checks if the player has obtained candy at least once
  if bit.check(memory.read_s8(candyBox),2) then gui.drawRectangle(5, y, 4, 10, 'RED', 'RED') end
  --Checks if the player has obtained soda at least once
  if bit.check(memory.read_s8(candyBox),3) then gui.drawRectangle(10, y, 4, 10, 'GREEN', 'GREEN') end
  --Checks if the player has obtained marbles at least once
  if bit.check(memory.read_s8(candyBox),6) then gui.drawRectangle(15, y, 4, 10, 'BLUE', 'BLUE') end
  --Checks if the player has obtained water at least once
  if bit.check(memory.read_s8(keyItems),0) then gui.drawRectangle(20, y, 4, 10, 'AQUA', 'AQUA') end
  --Checks if the player has obtained water bottle at least once
  if bit.check(memory.read_s8(gear+1),1) then gui.drawRectangle(25, y, 4, 10, 'DARKCYAN', 'DARKCYAN') end
  --Checks if the player has unlocked the Toys tab
  if bit.check(memory.read_s8(keyItems),2) then gui.drawRectangle(30, y, 4, 10, 'DARKKHAKI', 'DARKKHAKI') end
end

function displaychar()
  local x = (memory.read_u32_le(0xF9D8)+30720)/65536.0  --Adds 30720 for actual X
  local y = (memory.read_u32_le(0xF9DC)+20480)/65536.0  --Adds 20480 for actual Y
  gui.text(0, 60, 'X: '..string.format('%.5f',x) ..' Y: '..string.format('%.5f',y))
  local char = memory.read_s8(0x3DE8)
  if char < 3 then  -- just in case
  local supply = memory.read_s16_le(water[char+1])  --Char uses 0,1,2 but lua arrays are 1,2,3
  local capacity = memory.read_s16_le(water2[char+1])
  gui.text(0, 75, characters[char+1]..'('..supply..'/'..capacity..')')
  end
end

while true do
  percent()
  miscflags()
  displaychar()
  emu.frameadvance()
end