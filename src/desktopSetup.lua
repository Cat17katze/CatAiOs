BGImages = {"PrideFlag","TransexualFlag","Non-binary_Flag","None","Online","Custom"}
function reset()
	shell.run(".recolor")
	term.setBackgroundColor(colors.black)
	term.setTextColor(colors.white)
	term.clear()
end
function menu(Options,MainTitle,Title,isFew)
	print(MainTitle)
	print(Title)
	local n=1
	while true do
		term.setCursorPos(1,3)
		term.setTextColor(colors.gray)
		if n<#options then
			print(Options[n+1])
		else
			print(Options[1])
		end
		term.setTextColor(colors.white)
		print(Options[n])
		if isFew == false then
			term.setTextColor(colors.gray)
			if n>1 then
				print(Options[n-1])
			else
				print(Options[#Options])
			end
		end
		E,K = os.pullEvent("key")
		if K == keys.down then
			n=n-1
		elseif K == keys.up then
			n=n+1
		elseif K == keys.enter then
			return n
		end
		if n < 1 then
			n=#Options
		elseif n > #Options then
			n=1
		end
	end
end
reset()
BG = BGImages[menu(BGImages,"Welcome to the desktop setup tool!","Select a background image",false)]
if BG == "PrideFlag" then
	shell.run("wget https://raw.githubusercontent.com/TheAio/CatAiOs/Experimental/media/Pride.nfp /BG.nfp")
elseif BG == "TransexualFlag" then
	shell.run("wget https://raw.githubusercontent.com/TheAio/CatAiOs/Experimental/media/Trans.nfp /BG.nfp")
elseif BG == "Non-binary_Flag" then
	shell.run("wget https://raw.githubusercontent.com/TheAio/CatAiOs/Experimental/media/Enby.nfp /BG.nfp")
elseif BG == "None" then
	fs.open("/BG.nfp","w").close()
elseif BG == "Online" then
	print("Enter the WGET link")
	shell.run("wget",read(),"/BG.nfp")
elseif BG == "Custom" then
	shell.run("paint /BG.nfp")
end
reset()
print("Please wait...")
