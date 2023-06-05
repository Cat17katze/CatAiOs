function reset()
	shell.run(".recolor")
	term.setBackgroundColor(colors.black)
	term.setTextColor(colors.white)
	term.clear()
end
function menu(Options,MainTitle,Title,isFew)
  reset()
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
print("Please wait...")
Options = {"Open terminal","Run a program","Download a file"}
 = {"APM","wget","pastebin"}
OP = Options[menu(Options,"Welcome to CatAios!","What do you want to do?",false)]
if OP == "Open terminal" then
  shell.run("sh")
elseif OP == "Run a program" then
  print("Enter the file path from root")
  shell.run("/"..read())
elseif OP == "Download a file" then
  OP = DownloadMethods[menu(DownloadMethods,"Welcome to CatAios!","What do you want to do?",false)]
  if OP == "APM" then
    print("Enter APM command")
    shell.run("fg APM",read())
  elseif OP == "wget" then
    print("Enter URL and file name")
    shell.run("fg wget",read())
  elseif OP == "pastebin" then
    print("Enter CODE and file name")
    shell.run("fg pastebin get",read())
  end
end
shell.run("/Desktop.lua")
