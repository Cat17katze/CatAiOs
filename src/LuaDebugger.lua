error("THIS CODE IS NOT READY YET")
args = {...}
if #args < 1 then
	print("Usage: LuaDebugger [file path] {flags}")
	print("Flags:")
else
	if fs.exists(args[1]) then
		EmulationCode = {}
		CodeFile = fs.open(args[1],"r")
		while true do
			i=CodeFile.readLine()
			if i == nil then
				break
			else
				CodeFile[#CodeFile+1] = i
			end
		end
		function displayVarVals()
			term.clear()
			print("NumberVars =",#EmuVarVals)
			print("Select var number to read")
			inp=tonumber(read())
			print(EmuVarVals[inp])
			print(EmuVarNames[inp])
			print("Press enter to continue")
			read()
		end
		EmuVarVals = {}
		EmuVarNames = {}
		CL = 1
		while true do
			print("Select ammount of lines to emulate")
			EmulateAmmount = tonumber(read())
			for j=1,EmulateAmmount do
				--emulate!
			end
			displayVarVals()
		end
	else
		print("Invalid file path",args[1])
	end
end
