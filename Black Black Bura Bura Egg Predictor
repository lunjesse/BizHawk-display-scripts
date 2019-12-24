local hex = bizstring.hex
console.clear()
--r0:00000003 r1:02004B40 r2:000014BC r3:00000000 r4:02019690 r5:00000000 r6:00000000 r7:02005FE0 r8:00000000 r9:00000000 r10:00000000 r11:00000000 r12:02003B10 r13:03007BF4 r14:08004BA7 r15:080056CA r16:6000003F
r = {}
r[0] = 0x00000003
r[1] = 0x02004B40
r[2] = 0x000014BC
r[3] = 0
r[4] = 0x02019690
r[5] = 0
r[6] = 0
r[7] = 0x02005FE0
r[8] = 0
r[9] = 0
r[10] = 0
r[11] = 0
r[12] = 0x02003B10 
r[13] = 0x03007BF4
r[14] = 0x08004BA7
r[15] = 0x080056CA 
r[16] = 0x6000003F
r.CPSR = 0x6000003F
--Credits: http://lua-users.org/wiki/SimpleStack
-- GLOBAL
Stack = {}

-- Create a Table with stack functions
function Stack:Create()

  -- stack table
  local t = {}
  -- entry table
  t._et = {}

  -- push a value on to the stack
  function t:push(...)
    if ... then
      local targs = {...}
      -- add values
      for _,v in ipairs(targs) do
        table.insert(self._et, v)
      end
    end
  end

  -- pop a value from the stack
  function t:pop(num)

    -- get num values from stack
    local num = num or 1

    -- return table
    local entries = {}

    -- get values into entries
    for i = 1, num do
      -- get last entry
      if #self._et ~= 0 then
        table.insert(entries, self._et[#self._et])
        -- remove last value
        table.remove(self._et)
      else
        break
      end
    end
    -- return unpacked entries
    return unpack(entries)
  end

  -- get entries
  function t:getn()
    return #self._et
  end

  -- list values
  function t:list()
    for i,v in pairs(self._et) do
      print(i, hex(v))
    end
  end
  return t
end

function display_registers(registers)
	for i = 0, 16 do
		console.log("r["..i.."] = 0x"..hex(registers[i]))
	end
	console.log("r.CPSR = 0x"..hex(registers.CPSR))
	console.log("PC: "..hex(registers[15]+1))
	local N = bit.check(registers.CPSR, 31) and 1 or 0
	local Z = bit.check(registers.CPSR, 30) and 1 or 0
	local C = bit.check(registers.CPSR, 29) and 1 or 0
	local V = bit.check(registers.CPSR, 28) and 1 or 0
	local Q = bit.check(registers.CPSR, 27) and 1 or 0
	console.log("N: "..N.." Z: "..Z.." C: "..C.." V: "..V.." Q: "..Q)
end

--since bizhawk hates the 0x8/0x3/0x4 part, remove it
function load_biz_addr(addr, size)
	local destination
	local read_memory = memory.read_u32_le	--default
	if size == 8 then
		read_memory = memory.read_u8
	elseif size == 16 then
		read_memory = memory.read_u16_le
	elseif size == 24 then
		read_memory = memory.read_u24_le
	end
	if addr < 0x01000000 and addr > 0x00000000 then
		destination = read_memory(addr, "BIOS")
	elseif addr < 0x03000000 and addr > 0x02000000 then
		destination = read_memory(addr - 0x02000000,"EWRAM")
	elseif addr < 0x04000000 and addr > 0x03000000 then
		destination = read_memory(addr - 0x03000000,"IWRAM")
	elseif addr < 0x05000000 and addr > 0x04000000 then
		destination = read_memory(addr - 0x04000000,"System Bus")
	elseif addr < 0x09000000 and addr > 0x08000000 then
		destination = read_memory(addr - 0x08000000,"ROM")
	end
	return destination
end

function asm_080109AF(registers, stack)
	r = registers
	--do these 2 separately; both are from 080109AF
	stack:push(r[14])
	stack:push(r[4])	
	r[4] = r[0]	--080109B1
	r[14] = 0x080109B5
	r[15] = 0x0802C586
	return r, stack
end
--0802C587
function next_rng(registers, stack, value)
	--Only r0, r2, r3 changes
	--r0 = bottom 8 bits of new rng (LDRB at the end)
	--r2 = top 8 bits of new rng
	--r3 = bottom 8 bits of old rng
	--both pushes from 0802C587
	stack:push(r[14])
	stack:push(r[4])
	local r = registers
	r[0] = value
	r[0] = value + bit.lshift(value, 1)
	r[2] = bit.rshift(r[0],8)
	r[3] = bit.band(value, 0xFF)
	r[0] = bit.band(r[2] + r[3], 0xFF) + (r[2] * 256)
	local new_value = bit.band(r[0], 0xFFFF)
	r[0] = bit.band(new_value, 0xFF)
	r[2] = bit.rshift(bit.band(new_value, 0xFF00),8)
	r[3] = bit.band(value, 0xFF)
	r[4] = stack:pop()	--0802C5AD
	r[1] = stack:pop()	--0802C5AF
	r[13] = 0x03007BEC 	--Stack changed
	r[15] = r[1] + 1	--PC changed
	return r, stack, new_value 	--0802C5B1 BX
end

function asm_080109B7(registers, stack)
	local r = registers
	-- r[0] = bit.lshift(r[0],24)	--080109B7
	-- r[0] = bit.rshift(r[0],24)	--080109B9
	r[0] = r[0] % 0xFF	--Above should be same as this
	r[1] = 100
	r[14] = 0x080109BF	--LR = PC + 1
	r[15] = 0x08059B1E
	--08059B1F
	if r[1] == 0 then
		console.log("080109B7 Hi")
		return asm_08059BD5(r, stack)
	else
		console.log("080109B7 Hi 2")
		return asm_08059B23(r, stack)
	end
end

function asm_08059BD5(registers, stack)
	local r = registers
	stack:push(r[14])	--08059BD5
	r[14] = 0x08059BD9
	r[15] = 0x08059BDA	--0805999F
	r[0] = 0
	r[15] = stack:pop()
end

function asm_08059B23(registers, stack)
	local r = registers
	r[3] = 1
	--08059B25: technically, it's r0 >= r1, but since that being false makes it leave
	-- CMP		r0, r1
	-- BCS #+0	
	if (r[0] < r[1]) then
		console.log("08059B23 Hi")
		--08059B29
		r[15] = 0x080109C0
		return r, stack	--go to egg determination function
	else
	--08059B2B
		console.log("08059B23 Hi 2")
		stack:push(r[4])
		r[4] = 1
		r[4] = bit.lshift(r[4], 28)	--08059B2F
	--go to egg determination function after this function ends
		return asm_08059B31(r, stack, 1)
	end
end

function asm_08059B31(registers, stack, loop)
	local r = registers
	-- local cond = true
	-- while true do	--for the branch in 08059B3D
		-- --08059B31: technically r[1] >= r[4], but since it seems to cascade from 08059B35 to 08059B3F r[1] < r[4]
		-- -- CMP     r[1], r[4]
		-- -- BCS     #+8	-> Branch if r[1] >= r[4]
		-- if r[1] < r[4] then
			-- --08059B35: technically r[1] >= r[0]
			-- -- CMP		r[1], r[0]
			-- -- BCS		#+4		-> Branch if r[1] >= r[0]
			-- if r[1] < r[0] then
				-- --08059B39
				-- r[1] = bit.lshift(r[1], 4)
				-- r[3] = bit.lshift(r[3], 4)
			-- else
				-- --08059B3F
				-- r[4] = bit.lshift(r[4], 4)
				-- cond = false
				-- break
			-- end
		-- else
			-- --08059B3F
			-- r[4] = bit.lshift(r[4], 4)
			-- cond = false
			-- break
		-- end
	-- end
	if loop < 2 then	--don't do this again on 2nd loop+
		while (r[1] < r[4]) and (r[1] < r[0]) do
			--08059B39
			r[1] = bit.lshift(r[1], 4)
			r[3] = bit.lshift(r[3], 4)
		end
		--08059B3F
		r[4] = bit.lshift(r[4], 3)
		while (r[1] < r[4]) and (r[1] < r[0]) do
			--08059B49
			r[1] = bit.lshift(r[1], 1)
			r[3] = bit.lshift(r[3], 1)		
		end
	end
	--08059B4F
	r[2] = 0
	--08059B53: technically r[0] < r[1], but since it seems to cascade from 08059B54 to 08059B56 r[0] >= r[1]
	-- CMP     r[0], r[1]
	-- BCC     #+0	-> Branch if r[0] < r[1]
	if r[0] >= r[1] then
		-- console.log("08059B53")
		-- display(loop, r) 
		r[0] = r[0] - r[1]
	end
	-- 08059B56
	r[4] = bit.rshift(r[1], 1)
	-- 08059B5B: technically r[0] < r[4] but since it seems to cascade from 08059B5C to 08059B68 if r[0] >= r[4]
	-- CMP     r[0], r[4]
	-- BCC     #+10	-> Branch if r[0] < r[4]
	if r[0] >= r[4] then
		-- console.log("08059B5B")
		-- display(loop, r) 
		r[0] = r[0] - r[4]
		r[12] = r[3]
		r[4] = 1
		r[3] = bit.ror(r[3], r[4])
		r[2] = bit.bor(r[2], r[3])
		r[3] = r[12]
	end
	-- 08059B68
	r[4] = bit.rshift(r[1], 2)
	-- 08059B6D: technically r[0] < r[4], but since it seems to cascade from 08059B6E to 08059B7A if r[0] >= r[4]
	-- CMP     r[0], r[4]
	-- BCC     #+10	-> Branch if r[0] < r[4]
	if r[0] >= r[4] then
		-- console.log("08059B6D")
		-- display(loop, r) 
		r[0] = r[0] - r[4]
		r[12] = r[3]
		r[4] = 2
		r[3] = bit.ror(r[3], r[4])
		r[2] = bit.bor(r[2], r[3])
		r[3] = r[12]
	end
	-- 08059B7A
	r[4] = bit.rshift(r[1], 3)
	-- 08059B7F: technically r[0] < r[4], but since it seems to cascade from 08059B80 to 08059B8C if r[4] <= r[0]
	-- CMP     r[0], r[4]
	-- BCC     #+10	-> Branch if r[0] < r[4]
	if r[0] >= r[4] then
		-- console.log("08059B7F")
		-- display(loop, r) 
		r[0] = r[0] - r[4]
		r[12] = r[3]
		r[4] = 3
		r[3] = bit.ror(r[3], r[4])
		r[2] = bit.bor(r[2], r[3])
		r[3] = r[12]
	end
	-- 08059B8C
	r[12] = r[3]
	-- 08059B91: technically r[0] == 0, but since it seems to cascade from 08059B92 to 08059B9A if r[0] =/= 0
	-- CMP     r[0], #0
	-- BEQ     #+6	-> Branch if r[0] == 0
	if r[0] ~= 0 then
		-- console.log("08059B91")
		-- display(loop, r) 
		r[3] = bit.rshift(r[3], 4)
		-- 08059B95: technically r[3] == 0, but since it seems to cascade from 08059B96 to 08059B9A? if r[3] =/= 0
		-- LSR     r[3], r[3], #4
		-- BEQ     #+2
		if r[3] ~= 0 then
			-- 08059B97
			-- console.log("08059B97")
			-- display(loop, r) 
			r[1] = bit.rshift(r[1], 4)
			return asm_08059B31(r, stack, loop+1)
		end
	end
	--08059B9A
	r[4] = 14
	r[4] = bit.lshift(r[4], 28)
	r[2] = bit.band(r[2], r[4])
	-- 08059BA1: technically r[2] =/= 0, but since it seems to cascade from 08059BA2 to 08059BA6 if r[2] == 0
	if r[2] == 0 then
		-- console.log("08059BA1")
		-- display(loop, r) 
		r[4] = stack:pop()	--technically from stack
		r[13] = r[13] + 4	--Stack popped
		r[15] = 0x080109C0	--from link register
		return r, stack, loop
	end
	-- 08059BA6
	r[3] = r[12]
	r[4] = 3
	r[3] = bit.ror(r[3], r[4])
	-- 08059BAF: technically r[2] AND r[3] == 0, but since it seems to cascade from 08059BB0 to 08059BB4 if r[2] AND r[3] =/= 0
	if bit.band(r[2], r[3]) ~= 0 then
		-- console.log("08059BAF")
		-- display(loop, r) 
		r[4] = bit.lshift(r[1], 3)
		r[0] = r[0] + r[4]
	end
	-- 08059BB4
	r[3] = r[12]
	r[4] = 2
	r[3] = bit.ror(r[3], r[4])
	-- 08059BBD: technically r[2] AND r[3] == 0, but since it seems to cascade from 08059BBE to 08059BC2 if r[2] AND r[3] =/= 0
	if bit.band(r[2], r[3]) ~= 0 then
		-- console.log("08059BBD")
		-- display(loop, r) 
		r[4] = bit.rshift(r[1], 2)
		r[0] = r[0] + r[4]
	end
	-- 08059BC2
	r[3] = r[12]
	r[4] = 1
	r[3] = bit.ror(r[3], r[4])
	-- 08059BCB: technically r[2] AND r[3] == 0, but since it seems to cascade from 08059BCC to 08059BD0 if r[2] AND r[3] =/= 0
	if bit.band(r[2], r[3]) ~= 0 then
		-- console.log("08059BCB")
		-- display(loop, r) 
		r[4] = bit.rshift(r[1], 1)
		r[0] = r[0] + r[4]
	end
	-- 08059BD0
		-- console.log("08059BD0")
		-- display(loop, r) 
	r[4] = stack:pop() --from stack, should be 60
	r[13] = r[13] + 4	--Stack popped
	r[15] = 0x080109C0
	return r, stack, loop
end


function asm_080109C1(registers, stack, stuff)
	local r = registers
	r[0] = bit.lshift(r[0], 24)
	r[0] = bit.arshift(r[0], 24)
	r[0] = r[0] - r[4]
	r[0] = bit.lshift(r[0], 24)
	--080109C9
	-- CMP		r0, 0
	-- BLT #+2		-> Branch if less than 0; check bit 31 in this case
	-- if bit.check(r[0], 31) then
	-- --080109D1
		-- r[0] = 1
	-- else
	-- --080109CD
		-- r[0] = 0
	-- end
	r[0] = bit.check(r[0], 31) and 1 or 0	--should be same as above
	r[4] = stack:pop()	--080109D3
	r[1] = stack:pop()	--080109D5
	if r[1] == 0x080056CF then
		console.log("080109C1 Hi")
		--080056D1
		r[0] = bit.lshift(r[0], 24)
		--080056D3
		if r[0] == 0 then
			--080056DB
			r[0] = 30
			r[14] = 0x080056DF
			r[15] = 0x080109AE
			console.log("080109C1 Hi 2")
			r, stack = asm_080109AF(r, stack)
			--0802C587
			r, stack, stuff.RNG = next_rng(r, stack, stuff.RNG)
			r, stack = asm_080109B7(r, stack)
			return asm_080109C1(r, stack, stuff)
		else
			r[4] = 0	--080056D7
		end
	else
		--080056E1
		r[0] = bit.lshift(r[0], 24)
		-- r[4] = 2
		-- --080056E5: technically it's r[0] == 0, but since failing makes it go from 080056E9 to 080056EB anyways
		-- if r[0] ~= 0 then
			-- r[4] = 1
		-- end
		r[4] = (r[0] == 0) and 2 or 1	--should be the same as above
	end
	--080056EB
	r[0] = 0x030010B0	--from PC + 88; this + 0x2 is floor address
	r[1] = stuff.floor_number	--from 0x030010B2; 080056ED
	r[1] = r[1] - 7				--080056EF
	r[0] = bit.lshift(r[1], 1)	--080056F1
	r[0] = r[0] + r[1]			--080056F3
	r[3] = r[0] + r[4]			--080056F5
	--080056F9: technically it's r[3] <= 11, but since failing makes it go from 080056FB to 080056FD anyways
	r[3] = r[3] <= 11 and r[3] or 11
	r[2] = 0x02036BC4 -- from PC + 76; 080056FD
	r[0] = 0x030019AC -- from PC + 76; 080056FF
	r[0] = 0x03004470 -- from the address 0x030019AC
	r[4] = r[7]	--08005703
	r[4] = r[4] + 118	--should end up as 0x02006056; 08005705
	r[1] = stuff.dungeon == "A" and stuff.addr_44A0.A or stuff.addr_44A0.B	--address from r[0] + 48
	r[4] = stuff.type	--08005709
	r[0] = bit.lshift(r[4], 2)
	-- console.log(hex(r[0]))
	r[0] = r[0] + r[1]	--0800570D
	r[0] = load_biz_addr(r[0], 32)	--0800570F; doing this for now until I figure out memory things
	r[0] = r[0] + r[3]				--08005713; egg address
	r[0] = load_biz_addr(r[0], 8)	--08005715; egg id from ROM
	
	return r, stack, stuff
end
stack = Stack:Create()

local stuff = {}	--placeholder for memory address values
-- stuff.floor_number = 7
-- stuff.RNG = 0x700B
-- stuff.dungeon = "B"
--Fire Fog A F7
stuff.floor_number = 7
stuff.RNG = 0xCFD3
stuff.dungeon = "A"
stuff.addr_44A0 = {A = 0x0817636C, B = 0x0817210C}
stuff.addr_0817210C = {B = 0x081720DC}
stuff.type = 2	--seems to range from 0 to 4 (address 0x6056, EWRAM; displayed type value)
--[[
0	Electric
1	Water
2	Fire
3	Earth
4	Royal (doesn't appear in wild)
]]--
stuff.addr_817210C = {

}
--080056CB
r[0] = 60
--080056CD, 080056CF
r[14] = 0x080056CF
r[15] = 0x080109AE
r, stack = asm_080109AF(r, stack)
r, stack, stuff.RNG = next_rng(r, stack, stuff.RNG)
r, stack = asm_080109B7(r, stack)	--This should call either asm_08059BD5 or asm_08059B23; both end up with egg function

r, stack, stuff = asm_080109C1(r, stack, stuff)
display_registers(r)
console.log("Stack now")
stack:list()
