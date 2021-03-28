local font = dofile(minetest.get_modpath("digistuff")..DIR_DELIM.."gpu-font.lua")

local function explodebits(input,count)
	local output = {}
	if not count then count = 8 end
	for i=0,count-1,1 do
		output[i] = input%(2^(i+1)) >= 2^i
	end
	return output
end

local function implodebits(input,count)
	local output = 0
	if not count then count = 8 end
	for i=0,count-1,1 do
		output = output + (input[i] and 2^i or 0)
	end
	return output
end

local packtable = {}
local unpacktable = {}
for i=0,25,1 do
	packtable[i] = string.char(i+65)
	packtable[i+26] = string.char(i+97)
	unpacktable[string.char(i+65)] = i
	unpacktable[string.char(i+97)] = i+26
end
for i=0,9,1 do
	packtable[i+52] = tostring(i)
	unpacktable[tostring(i)] = i+52
end
packtable[62] = "+"
packtable[63] = "/"
unpacktable["+"] = 62
unpacktable["/"] = 63

local function packpixel(pixel)
	pixel = tonumber(pixel,16)
	if not pixel then return "AAAA" end
	local bits = explodebits(pixel,24)
	local block1 = {}
	local block2 = {}
	local block3 = {}
	local block4 = {}
	for i=0,5,1 do
		block1[i] = bits[i]
		block2[i] = bits[i+6]
		block3[i] = bits[i+12]
		block4[i] = bits[i+18]
	end
	local char1 = packtable[implodebits(block1,6)] or "A"
	local char2 = packtable[implodebits(block2,6)] or "A"
	local char3 = packtable[implodebits(block3,6)] or "A"
	local char4 = packtable[implodebits(block4,6)] or "A"
	return char1..char2..char3..char4
end

local function unpackpixel(pack)
	local block1 = unpacktable[pack:sub(1,1)] or 0
	local block2 = unpacktable[pack:sub(2,2)] or 0
	local block3 = unpacktable[pack:sub(3,3)] or 0
	local block4 = unpacktable[pack:sub(4,4)] or 0
	local out = block1+(2^6*block2)+(2^12*block3)+(2^18*block4)
	return string.format("%06X",out)
end

local function rgbtohsv(r,g,b)
	r = r/255
	g = g/255
	b = b/255
	max = math.max(r,g,b)
	min = math.min(r,g,b)
	delta = max-min
	local hue = 0
	if delta > 0 then
		if max == r then
			hue = (g-b)/delta
			hue = (hue%6)*60
		elseif max == g then
			hue = (b-r)/delta
			hue = 60*(hue+2)
		elseif max == b then
			hue = (r-g)/delta
			hue = 60*(hue+4)
		end
		hue = hue/360
	end
	local sat = 0
	if max > 0 then
		sat = delta/max
	end
	return math.floor(hue*255),math.floor(sat*255),math.floor(max*255)
end

local function hsvtorgb(h,s,v)
	h = h/255*360
	s = s/255
	v = v/255
	local c = s*v
	local x = (h/60)%2
	x = 1-math.abs(x-1)
	x = x*c
	local m = v-c
	local r = 0
	local g = 0
	local b = 0
	if h < 60 then
		r = c
		g = x
	elseif h < 120 then
		r = x
		g = c
	elseif h < 180 then
		g = c
		b = x
	elseif h < 240 then
		g = x
		b = c
	elseif h < 300 then
		r = x
		b = c
	else
		r = c
		b = x 
	end
	r = r+m
	g = g+m
	b = b+m
	return math.floor(r*255),math.floor(g*255),math.floor(b*255)
end

local function bitwiseblend(srcr,dstr,srcg,dstg,srcb,dstb,mode)
	local srbits = explodebits(srcr)
	local sgbits = explodebits(srcg)
	local sbbits = explodebits(srcb)
	local drbits = explodebits(dstr)
	local dgbits = explodebits(dstg)
	local dbbits = explodebits(dstb)
	for i=0,7,1 do
		if mode == "and" then
			drbits[i] = srbits[i] and drbits[i]
			dgbits[i] = sgbits[i] and dgbits[i]
			dbbits[i] = sbbits[i] and dbbits[i]
		elseif mode == "or" then
			drbits[i] = srbits[i] or drbits[i]
			dgbits[i] = sgbits[i] or dgbits[i]
			dbbits[i] = sbbits[i] or dbbits[i]
		elseif mode == "xor" then
			drbits[i] = srbits[i] ~= drbits[i]
			dgbits[i] = sgbits[i] ~= dgbits[i]
			dbbits[i] = sbbits[i] ~= dbbits[i]
		elseif mode == "xnor" then
			drbits[i] = srbits[i] == drbits[i]
			dgbits[i] = sgbits[i] == dgbits[i]
			dbbits[i] = sbbits[i] == dbbits[i]
		elseif mode == "not" then
			drbits[i] = not srbits[i]
			dgbits[i] = not sgbits[i]
			dbbits[i] = not sbbits[i]
		elseif mode == "nand" then
			drbits[i] = not (srbits[i] and drbits[i])
			dgbits[i] = not (sgbits[i] and dgbits[i])
			dbbits[i] = not (sbbits[i] and dbbits[i])
		elseif mode == "nor" then
			drbits[i] = not (srbits[i] or drbits[i])
			dgbits[i] = not (sgbits[i] or dgbits[i])
			dbbits[i] = not (sbbits[i] or dbbits[i])
		end
	end
	return string.format("%02X%02X%02X",implodebits(drbits),implodebits(dgbits),implodebits(dbbits))
end

local function blend(src,dst,mode,transparent)
	local srcr = tonumber(string.sub(src,1,2),16)
	local srcg = tonumber(string.sub(src,3,4),16)
	local srcb = tonumber(string.sub(src,5,6),16)
	local dstr = tonumber(string.sub(dst,1,2),16)
	local dstg = tonumber(string.sub(dst,3,4),16)
	local dstb = tonumber(string.sub(dst,5,6),16)
	local op = "normal"
	if type(mode) == "string" then op = string.lower(mode) end
	if op == "normal" then
		return src
	elseif op == "nop" then
		return dst
	elseif op == "overlay" then
		return (string.upper(src) == string.upper(transparent)) and dst or src
	elseif op == "add" then
		local r = math.min(255,srcr+dstr)
		local g = math.min(255,srcg+dstg)
		local b = math.min(255,srcb+dstb)
		return string.format("%02X%02X%02X",r,g,b)
	elseif op == "sub" then
		local r = math.max(0,dstr-srcr)
		local g = math.max(0,dstg-srcg)
		local b = math.max(0,dstb-srcb)
		return string.format("%02X%02X%02X",r,g,b)
	elseif op == "isub" then
		local r = math.max(0,srcr-dstr)
		local g = math.max(0,srcg-dstg)
		local b = math.max(0,srcb-dstb)
		return string.format("%02X%02X%02X",r,g,b)
	elseif op == "average" then
		local r = math.min(255,(srcr+dstr)/2)
		local g = math.min(255,(srcg+dstg)/2)
		local b = math.min(255,(srcb+dstb)/2)
		return string.format("%02X%02X%02X",r,g,b)
	elseif op == "and" or op == "or" or op == "xor" or op == "xnor" or op == "not" or op == "nand" or op == "nor" then
		return bitwiseblend(srcr,dstr,srcg,dstg,srcb,dstb,op)
	elseif op == "tohsv" or op == "rgbtohsv" then
		return string.format("%02X%02X%02X",rgbtohsv(srcr,srcg,srcb))
	elseif op == "torgb" or op == "hsvtorgb" then
		return string.format("%02X%02X%02X",hsvtorgb(srcr,srcg,srcb))
	else
		return src
	end
end

local function runcommand(pos,meta,command)
	if type(command) ~= "table" then return end
	if command.command == "createbuffer" then
		if type(command.buffer) ~= "number" or type(command.xsize) ~= "number" or type(command.ysize) ~= "number" then return end
		local bufnum = math.floor(command.buffer)
		if bufnum < 0 or bufnum > 7 then return end
		local xsize = math.min(64,math.floor(command.xsize))
		local ysize = math.min(64,math.floor(command.ysize))
		if xsize < 1 or ysize < 1 then return end
		local fillcolor = command.fill
		if type(fillcolor) ~= "string" or string.len(fillcolor) > 7 or string.len(fillcolor) < 6 then fillcolor = "000000" end
		if string.sub(fillcolor,1,1) == "#" then fillcolor = string.sub(fillcolor,2,7) end
		if not tonumber(fillcolor,16) then fillcolor = "000000" end
		local buffer = {}
		buffer.xsize = xsize
		buffer.ysize = ysize
		for y=1,ysize,1 do
			buffer[y] = {}
			for x=1,xsize,1 do
				buffer[y][x] = fillcolor
			end
		end
		meta:set_string("buffer"..bufnum,minetest.serialize(buffer))
	elseif command.command == "send" then
		if type(command.buffer) ~= "number" or type(command.channel) ~= "string" then return end
		local bufnum = math.floor(command.buffer)
		if bufnum < 0 or bufnum > 7 then return end
		local buffer = meta:get_string("buffer"..bufnum)
		if string.len(buffer) == 0 then return end
		buffer = minetest.deserialize(buffer)
		if type(buffer) == "table" then
			digiline:receptor_send(pos,digiline.rules.default,command.channel,buffer)
		end
	elseif command.command == "sendregion" then
		if type(command.buffer) ~= "number" or type(command.channel) ~= "string" then return end
		local bufnum = math.floor(command.buffer)
		if bufnum < 0 or bufnum > 7 then return end
		local buffer = meta:get_string("buffer"..bufnum)
		if string.len(buffer) == 0 then return end
		buffer = minetest.deserialize(buffer)
		if type(buffer) ~= "table" then return end
		if type(command.x1) ~= "number" or type(command.x2) ~= "number" or type(command.y1) ~= "number" or type(command.x2) ~= "number" then return end
		local x1 = math.min(64,math.floor(command.x1))
		local y1 = math.min(64,math.floor(command.y1))
		local x2 = math.min(64,math.floor(command.x2))
		local y2 = math.min(64,math.floor(command.y2))	
		if x1 < 1 or y1 < 1 or x2 < 1 or y2 < 1 then return end
		x2 = math.min(x2,buffer.xsize)
		y2 = math.min(y2,buffer.ysize)
		if x1 > x2 or y1 > y2 then return end
		local tempbuf = {}
		for y=y1,y2,1 do
			local dsty = y-y1+1
			tempbuf[dsty] = {}
			for x=x1,x2,1 do
				local dstx = x-x1+1
				tempbuf[dsty][dstx] = buffer[y][x]
			end
		end
		digiline:receptor_send(pos,digiline.rules.default,command.channel,tempbuf)
	elseif command.command == "drawrect" then
		if type(command.buffer) ~= "number" or type(command.x1) ~= "number" or type(command.y1) ~= "number" or type(command.x2) ~= "number" or type(command.y2) ~= "number" then return end
		local bufnum = math.floor(command.buffer)
		if bufnum < 0 or bufnum > 7 then return end
		local x1 = math.min(64,math.floor(command.x1))
		local y1 = math.min(64,math.floor(command.y1))
		local x2 = math.min(64,math.floor(command.x2))
		local y2 = math.min(64,math.floor(command.y2))
		if x1 < 1 or y1 < 1 or x2 < 1 or y2 < 1 then return end
		local buffer = meta:get_string("buffer"..bufnum)
		if string.len(buffer) == 0 then return end
		buffer = minetest.deserialize(buffer)
		if type(buffer) ~= "table" then return end
		x2 = math.min(x2,buffer.xsize)
		y2 = math.min(y2,buffer.ysize)
		if x1 > x2 or y1 > y2 then return end
		local fillcolor = command.fill
		if type(fillcolor) ~= "string" or string.len(fillcolor) > 7 or string.len(fillcolor) < 6 then fillcolor = "000000" end
		if string.sub(fillcolor,1,1) == "#" then fillcolor = string.sub(fillcolor,2,7) end
		if not tonumber(fillcolor,16) then fillcolor = "000000" end
		local edgecolor = command.edge
		if type(edgecolor) ~= "string" or string.len(edgecolor) > 7 or string.len(edgecolor) < 6 then edgecolor = fillcolor end
		if string.sub(edgecolor,1,1) == "#" then edgecolor = string.sub(edgecolor,2,7) end
		if not tonumber(edgecolor,16) then edgecolor = fillcolor end
		for y=y1,y2,1 do
			for x=x1,x2,1 do
				buffer[y][x] = fillcolor
			end
		end
		if fillcolor ~= edgecolor then
			for x=x1,x2,1 do
				buffer[y1][x] = edgecolor
				buffer[y2][x] = edgecolor
			end
			for y=y1,y2,1 do
				buffer[y][x1] = edgecolor
				buffer[y][x2] = edgecolor
			end
		end
		meta:set_string("buffer"..bufnum,minetest.serialize(buffer))
	elseif command.command == "drawline" then
		if type(command.buffer) ~= "number" or type(command.x1) ~= "number" or type(command.y1) ~= "number" or type(command.x2) ~= "number" or type(command.y2) ~= "number" then return end
		local bufnum = math.floor(command.buffer)
		if bufnum < 0 or bufnum > 7 then return end
		local x1 = math.min(64,math.floor(command.x1))
		local y1 = math.min(64,math.floor(command.y1))
		local x2 = math.min(64,math.floor(command.x2))
		local y2 = math.min(64,math.floor(command.y2))
		if x1 < 1 or y1 < 1 or x2 < 1 or y2 < 1 then return end
		local buffer = meta:get_string("buffer"..bufnum)
		if string.len(buffer) == 0 then return end
		buffer = minetest.deserialize(buffer)
		if type(buffer) ~= "table" then return end
		x2 = math.min(x2,buffer.xsize)
		y2 = math.min(y2,buffer.ysize)
		local color = command.color
		if type(color) ~= "string" or string.len(color) > 7 or string.len(color) < 6 then color = "000000" end
		if string.sub(color,1,1) == "#" then color = string.sub(color,2,7) end
		if not tonumber(color,16) then color = "000000" end
		local p1 = vector.new(x1,y1,0)
		local p2 = vector.new(x2,y2,0)
		local length = vector.distance(p1,p2)
		local dir = vector.direction(p1,p2)
		if length > 0 then
			for i=0,length,0.3 do
				local point = vector.add(p1,vector.multiply(dir,i))
				point = vector.floor(point)
				if command.antialias then
					buffer[point.y][point.x] = blend(buffer[point.y][point.x],color,"average")
				else
					buffer[point.y][point.x] = color
				end
			end
		end
		meta:set_string("buffer"..bufnum,minetest.serialize(buffer))
	elseif command.command == "drawpoint" then
		if type(command.buffer) ~= "number" or type(command.x) ~= "number" or type(command.y) ~= "number" then return end
		local bufnum = math.floor(command.buffer)
		if bufnum < 0 or bufnum > 7 then return end
		local x = math.floor(command.x)
		local y = math.floor(command.y)
		if x < 1 or y < 1 then return end
		local buffer = meta:get_string("buffer"..bufnum)
		if string.len(buffer) == 0 then return end
		buffer = minetest.deserialize(buffer)
		if type(buffer) ~= "table" then return end
		if x > buffer.xsize or y > buffer.ysize then return end
		local color = command.color
		if type(color) ~= "string" or string.len(color) > 7 or string.len(color) < 6 then color = "000000" end
		if string.sub(color,1,1) == "#" then color = string.sub(color,2,7) end
		if not tonumber(color,16) then color = "000000" end
		buffer[y][x] = color
		meta:set_string("buffer"..bufnum,minetest.serialize(buffer))
	elseif command.command == "copy" then
		if type(command.src) ~= "number" or type(command.dst) ~= "number" or type(command.srcx) ~= "number" or type(command.srcy) ~= "number" or type(command.dstx) ~= "number" or type(command.dsty) ~= "number" or type(command.xsize) ~= "number" or type(command.ysize) ~= "number" then return end
		local src = math.floor(command.src)
		if src < 0 or src > 7 then return end
		local dst = math.floor(command.dst)
		if dst < 0 or dst > 7 then return end
		local srcx = math.floor(command.srcx)
		local srcy = math.floor(command.srcy)
		local dstx = math.floor(command.dstx)
		local dsty = math.floor(command.dsty)
		local xsize = math.floor(command.xsize)
		local ysize = math.floor(command.ysize)
		if srcx < 1 or srcy < 1 or dstx < 1 or dsty < 1 or xsize < 1 or ysize < 1 then return end
		local sourcebuffer = meta:get_string("buffer"..src)
		local destbuffer = meta:get_string("buffer"..dst)
		if string.len(sourcebuffer) == 0 then return end
		sourcebuffer = minetest.deserialize(sourcebuffer)
		if type(sourcebuffer) ~= "table" then return end
		if string.len(destbuffer) == 0 then return end
		destbuffer = minetest.deserialize(destbuffer)
		if type(destbuffer) ~= "table" then return end
		if srcx + xsize-1 > sourcebuffer.xsize or srcy + ysize-1 > sourcebuffer.ysize then return end
		if dstx + xsize-1 > destbuffer.xsize or dsty + ysize-1 > destbuffer.ysize then return end
		local transparent = command.transparent
		if type(transparent) ~= "string" or string.len(transparent) > 7 or string.len(transparent) < 6 then transparent = "000000" end
		if string.sub(transparent,1,1) == "#" then transparent = string.sub(transparent,2,7) end
		if not tonumber(transparent,16) then transparent = "000000" end
		for y=0,ysize-1,1 do
			for x=0,xsize-1,1 do
				local srcpx = sourcebuffer[srcy+y][srcx+x]
				local destpx = destbuffer[dsty+y][dstx+x]
				destbuffer[dsty+y][dstx+x] = blend(srcpx,destpx,command.mode,transparent)
			end
		end
		meta:set_string("buffer"..dst,minetest.serialize(destbuffer))
	elseif command.command == "load" then
		if type(command.buffer) ~= "number" or type(command.x) ~= "number" or type(command.y) ~= "number" or type(command.data) ~= "table" then return end
		local bufnum = math.floor(command.buffer)
		if bufnum < 0 or bufnum > 7 then return end
		local xstart = math.floor(command.x)
		local ystart = math.floor(command.y)
		if xstart < 1 or ystart < 1 then return end
		local buffer = meta:get_string("buffer"..bufnum)
		if string.len(buffer) == 0 then return end
		buffer = minetest.deserialize(buffer)
		if type(buffer) ~= "table" then return end
		if type(command.data[1]) ~= "table" then return end
		if #command.data[1] < 1 then return end
		local ysize = #command.data
		local xsize = #command.data[1]
		if xstart+xsize-1 > buffer.xsize or ystart+ysize-1 > buffer.ysize then return end
		for y=1,ysize,1 do
			if type(command.data[y]) == "table" then
				for x=1,xsize,1 do
					local color = command.data[y][x]
					if type(color) == "string" then
						if string.len(color) == 7 then color = string.sub(color,2,7) end
						if tonumber(color,16) then
							buffer[ystart+y-1][xstart+x-1] = color
						end
					end
				end
			end
		end
		meta:set_string("buffer"..bufnum,minetest.serialize(buffer))
	elseif command.command == "text" then
		if type(command.buffer) ~= "number" or type(command.x) ~= "number" or type(command.y) ~= "number" or type(command.text) ~= "string" or string.len(command.text) < 1 then return end
		command.text = string.sub(command.text,1,16)
		local bufnum = math.floor(command.buffer)
		if bufnum < 0 or bufnum > 7 then return end
		local x = math.floor(command.x)
		local y = math.floor(command.y)
		if x < 1 or y < 1 then return end
		local buffer = meta:get_string("buffer"..bufnum)
		if string.len(buffer) == 0 then return end
		buffer = minetest.deserialize(buffer)
		if type(buffer) ~= "table" then return end
		if x > buffer.xsize or y > buffer.ysize then return end
		local color = command.color
		if type(color) ~= "string" or string.len(color) > 7 or string.len(color) < 6 then color = "ff6600" end
		if string.sub(color,1,1) == "#" then color = string.sub(color,2,7) end
		if not tonumber(color,16) then color = "ff6600" end
		for i=1,string.len(command.text),1 do
			local char = font[string.byte(string.sub(command.text,i,i))]
			for chary=1,12,1 do
				for charx=1,5,1 do
					local startx = x + (i*6-6)
					if char[chary][charx] and y+chary-1 <= buffer.ysize and startx+charx-1 <= buffer.xsize then
						local dstpx = buffer[y+chary-1][startx+charx-1]
						buffer[y+chary-1][startx+charx-1] = blend(color,dstpx,command.mode,"")
					end
				end
			end
		end
		meta:set_string("buffer"..bufnum,minetest.serialize(buffer))
	elseif command.command == "sendpacked" then
		if type(command.buffer) ~= "number" or type(command.channel) ~= "string" then return end
		local bufnum = math.floor(command.buffer)
		if bufnum < 0 or bufnum > 7 then return end
		local buffer = meta:get_string("buffer"..bufnum)
		if string.len(buffer) == 0 then return end
		buffer = minetest.deserialize(buffer)
		if type(buffer) == "table" then
			local packeddata = ""
			for y=1,buffer.ysize,1 do
				for x=1,buffer.xsize,1 do
					packeddata = packeddata..packpixel(buffer[y][x])
				end
			end
			digiline:receptor_send(pos,digiline.rules.default,command.channel,packeddata)
		end
	elseif command.command == "loadpacked" then
		if type(command.buffer) ~= "number" or type(command.data) ~= "string" then return end
		if type(command.x) ~= "number" or type(command.y) ~= "number" or type(command.xsize) ~= "number" or type(command.ysize) ~= "number" then return end
		command.x = math.floor(command.x)
		command.y = math.floor(command.y)
		command.xsize = math.floor(command.xsize)
		command.ysize = math.floor(command.ysize)
		if command.x < 1 or command.y < 1 or command.xsize < 1 or command.ysize < 1 then return end
		local bufnum = math.floor(command.buffer)
		if bufnum < 0 or bufnum > 7 then return end
		local buffer = meta:get_string("buffer"..bufnum)
		if string.len(buffer) == 0 then return end
		buffer = minetest.deserialize(buffer)
		if type(buffer) == "table" then
			if command.x + command.xsize - 1 > buffer.xsize then return end
			if command.y + command.ysize - 1 > buffer.ysize then return end
			for y=0,command.ysize-1,1 do
				local dsty = command.y+y
				for x=0,command.xsize-1,1 do
					local dstx = command.x+x
					local packidx = (y*command.xsize+x)*4+1
					local packeddata = string.sub(command.data,packidx,packidx+3)
					buffer[dsty][dstx] = unpackpixel(packeddata)
				end
			end
			meta:set_string("buffer"..bufnum,minetest.serialize(buffer))
		end
	end
end

minetest.register_node("digistuff:gpu", {
	description = "Digilines 2D Graphics Processor",
	groups = {cracky=3},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","field[channel;Channel;${channel}")
	end,
	tiles = {
		"digistuff_gpu_top.png",
		"jeija_microcontroller_bottom.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png"
	},
	inventory_image = "digistuff_gpu_top.png",
	drawtype = "nodebox",
	selection_box = {
		--From luacontroller
		type = "fixed",
		fixed = { -8/16, -8/16, -8/16, 8/16, -5/16, 8/16 },
	},
	_digistuff_channelcopier_fieldname = "channel",
	node_box = {
		--From Luacontroller
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, -7/16, 8/16}, -- Bottom slab
			{-5/16, -7/16, -5/16, 5/16, -6/16, 5/16}, -- Circuit board
			{-3/16, -6/16, -3/16, 3/16, -5/16, 3/16}, -- IC
		}
	},
	paramtype = "light",
	sunlight_propagates = true,
	on_receive_fields = function(pos, formname, fields, sender)
		local name = sender:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		if fields.channel then meta:set_string("channel",fields.channel) end
	end,
	digiline = 
	{
		receptor = {},
		effector = {
			action = function(pos,node,channel,msg)
				local meta = minetest.get_meta(pos)
				if meta:get_string("channel") ~= channel or type(msg) ~= "table" then return end
					if type(msg[1]) == "table" then
						for i=1,32,1 do
							if type(msg[i]) == "table" then
								runcommand(pos,meta,msg[i])
							end
						end
					else
						runcommand(pos,meta,msg)
					end
			end
		},
	},
})

minetest.register_craft({
	output = "digistuff:gpu",
	recipe = {
		{"","default:steel_ingot",""},
		{"digilines:wire_std_00000000","mesecons_luacontroller:luacontroller0000","digilines:wire_std_00000000"},
		{"dye:red","dye:green","dye:blue"},
	}
})
