args = {...}
function sound(Instr,Vol,Note,VERBAL)
    state=false
    for i=1,#speakers do
    	if VERBAL == "y" then
    		print(Instr..Vol..Note,"@",i,"aka",speakers[i])
    	end
        state = speakers[i].playNote(Instr,Vol,Note)
    end
    return state
end
function play(file,Instr,CVol,VERBAL)
	local NetList = peripheral.getNames()
	speakers={}
	for i=1,#NetList do
	    if peripheral.getType(NetList[i]) == "speaker" then
	    	if VERBAL == "y" then
	    		print("Adding number",i)
	    	end
		speakers[#speakers+1] = peripheral.wrap(NetList[i])
	    end
	end
	if #speakers == 0 then
	    speakers[1] = peripheral.find("speaker")
	end
    Hand = fs.open(file,"r")
    Data={}
    while true do
        i=Hand.readLine()
        if i == nil then break end
        Data[#Data+1]=i
    end
    Hand.close()
    if CVol == nil then
	Vol = tonumber(Data[#Data-1])
	print("VOL =",Vol)
    else
	Vol = tonumber(CVol)
    end
    del=tonumber(Data[#Data])
    print("Delay =",del)
    print("Debug =",VERBAL)
    for i=1,#Data-3 do
        sound(Instr,Vol,tonumber(Data[i]),VERBAL)
        sleep(del)
    end
end
function compile(code,vol,del)
    print("Enter output path")
    output = read()
    print("Compiling...")
    file = {}
    s=peripheral.find("speaker")
    hand=fs.open(output,"w")
    for i=1,string.len(code) do
        hand.writeLine(string.sub(code,i,i))
        print(string.sub(code,i,i))
        if s == nil then else s.playNote("banjo",1,tonumber(string.sub(code,i,i))) end
        sleep(0)
    end
    hand.writeLine(vol)
    hand.writeLine(del)
    hand.close()
    print("Done!")
end
function editor()
	local NetList = peripheral.getNames()
	speakers={}
	for i=1,#NetList do
	    if peripheral.getType(NetList[i]) == "speaker" then
		speakers[#speakers+1] = peripheral.wrap(NetList[i])
	    end
	end
	if #speakers == 0 then
	    speakers[1] = peripheral.find("speaker")
	end
	print("WELCOME!")
	print("Enter your music code and press enter")
	print("Music is denoted in numbers from 0 to 9")
	RAW = read()
	print("Enter delay between notes:")
	Del = tonumber(read())
	print("Enter volume for notes:")
	Vol = tonumber(read())
	Data={}
	for i=1,string.len(RAW) do
		Data[#Data+1] = string.sub(RAW,i,i)
		sleep(0)
	end
	Data[#Data+1]=Del
    for i=1,#Data do
        sound("banjo",1.0,tonumber(Data[i]))
        sleep(del)
    end
    compile(RAW,Vol,Del)
end
if #args < 1 then
	print("MME -e")
	print("or")
	print("MME -p Instrument file")
	return false
else
	if args[1] == "-e" then
		editor()
	elseif args[1] == "-p" then
		if #args < 3 then
			print("Usage:")
			print("MME -p Instrument file (volume) (debug?)")
			return false
		else
			play(args[3],args[2],args[4],args[5])
		end
	end
end
