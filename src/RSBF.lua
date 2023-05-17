args = {...}
if args[1] == "-help" then
	print("Usage")
	print("RSBF -help for help")
	print("RSBF [side] [code/path] [mode] {verbality}")
	print("Modes")
	print("extMem")
	print("stdMem")
	print("Varbality levels")
	print("None - log nothing")
	print("1 - log inputs & outputs")
	print("2 - log everything")
	print("Examples:")
	print("RSBF back file.bf stdMem 2 > this will log everything while running file.bf with stdMem and output @ back")
	print("RSBF top - extMem 1 > this will print 1 and crash (to avoid crash this should use stdMem)")
	print("RSBF front - stdMem   > this will output 15 @ front and log nothing (15 not 255 because its RSBF not BF)")
elseif #args < 2 then
	print("Usage")
	print("RSBF -help for help")
	print("RSBF [side] [code/path] [mode] {verbality}")
else
	if fs.exists(args[2]) then
		file = fs.open(args[2],"r")
		code = ""
		while true do
			i = file.readLine()
			if i == nil then
				file.close()
				break
			else
				code = code..i
			end
		end
	else
		code = args[2]
	end
	loops={}
	tape={}
	progCount = 0
	pointer = 1
	while true do
		instruction = string.sub(code,progCount,progCount)
		if instruction == "+" then
			if pointer > #tape then
				for i=#tape+1,pointer do
					tape[i] = 0
				end
				tape[pointer] = 1
			else
				if args[3] == "ext" then
					tape[pointer] = tape[pointer] + 1
				else
					if tape[pointer] == 15 then
						tape[pointer] = 0
					else
						tape[pointer] = tape[pointer] + 1
					end
				end
			end
			elseif instruction == "-" then
				if pointer > #tape then
					for i=#tape+1,pointer do
						tape[i] = 0
					end
					if args[3] == "ext" then
						tape[pointer] = -1
					else
						tape[pointer] = 15
					end
				else
					if args[3] == "ext" then
						tape[pointer] = tape[pointer] + 1
					else
						if tape[pointer] == 15 then
							tape[pointer] = 0
						else
							tape[pointer] = tape[pointer] + 1
						end
					end
			elseif instruction == "<" then
				if pointer < 1 then
					error("pointer out of bounds")
				else
					pointer = pointer - 1
				end
			elseif instruction == ">" then
				pointer = pointer + 1
			elseif instruction == "[" then
				loops[#loops+1] = progCount+1
			elseif instruction == "]" then
				if tape[pointer] == 0 then
					loops[#loops] = nil
				else
					progCount = loops[#loops]
				end
			elseif instruction == "," then
				sleep(1)
				tape[pointer] = rs.getAnalougeOutput(args[1])
				if args[4] == "1" or args[4] == "2" then
					print("input",tape[pointer])
				end
			elseif instruction == "." then
				sleep(1)
				rs.setAnalougeOutput(args[1],tape[pointer])
				if args[4] == "1" or args[4] == "2" then
					print("output",tape[pointer])
				end
			end
	end
end
	
