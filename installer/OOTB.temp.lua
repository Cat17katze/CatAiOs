function setPal(pal)
    h = fs.open(".pal","w")
    if pal == "coder" then
        h.writeLine("0x000000")
        h.writeLine("0xf0f000")
        h.writeLine("0xffffff")
        h.writeLine("0xa00000")
        h.writeLine("0xa000f0")
        h.writeLine("0xff00ff")
        h.writeLine("0xf0a000")
        h.writeLine("0xa000af")
        h.writeLine("0x00ff00")
    elseif pal == "vanila" then
        h.writeLine("0x111111")
        h.writeLine("0xDEDE6C")
        h.writeLine("0xF0F0F0")
        h.writeLine("0xCC4C4C")
        h.writeLine("0xB266E5")
        h.writeLine("0xF2B2CC")
        h.writeLine("0xF2B233")
        h.writeLine("0xE57FD8")
        h.writeLine("0x7FCC19")
    else
    	shell.run("rm .pal")
    end
    h.close()
    shell.run(".recolor")
end
term.clear()
term.setCursorPos(1,1)
shell.run(".recolor")
shell.run("about")
term.clear()
while true do
    term.setCursorPos(1,1)
    print("Please enter a master password")
    i=read("*")
    print("Please enter the password again")
    if i == read("*") then
        break
    else
        print("The password do not match!")
    end
end
Password = i
while true do
    term.setCursorPos(1,1)
    term.clear()
    print("Please enter your username")
    Username=read()
    print("Hi",Username.."! What are your pronouns?")
    Pronouns=read()
    sel=1
    while true do
        term.clear()
        term.setCursorPos(1,1)
        term.blit("Please select a theme!","ffffffffffffff1fffffff","123456789abcdef1234567")
        print("")
        if sel == 1 then
            pal="standard"
            setPal(pal)
            term.setTextColor(colors.gray)
            print(" [ coder ] ")
            term.setTextColor(colors.white)
            print("[ standard ]")
            term.setTextColor(colors.gray)
            print(" [vanilla] ")
        elseif sel == 2 then
            pal="vanilla"
            setPal(pal)
            term.setTextColor(colors.gray)
            print(" [standard] ")
            term.setTextColor(colors.white)
            print("[ vanilla ]")
            term.setTextColor(colors.gray)
            print(" [ coder ] ")
        else
            pal="coder"
            setPal(pal)
            term.setTextColor(colors.gray)
            print(" [vanillla] ")
            term.setTextColor(colors.white)
            print("[  coder  ]")
            term.setTextColor(colors.gray)
            print(" [standard] ")
        end
        E,K = os.pullEvent("key")
        if K == keys.up then
            sel=sel-1
            if sel == 0 then
                sel = 2
            end
        elseif K == keys.down then
            sel=sel+1
            if sel == 4 then
                sel = 1
            end
        elseif K == keys.enter then
            break
        else
            printError("Controll with up/down keys and enter")
            sleep(3)
        end
    end
    setPal(pal)
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    while true do
        term.clear()
        term.setCursorPos(1,1)
        print("Is this correct?")
        print("Your name is",Username,"("..Pronouns..")")
        print("You wish to use the palette",pal)
        print("")
        print("If that is true then please enter 'yes'")
        print("otherwise press enter")
        if string.upper(read()) == "YES" then
            break
        else
            os.reboot()
        end
    end
    break
end
term.clear()
term.setCurosrPos(1,1)
print("Please wait")
setPal("")
h=fs.open(".admin","w")
h.writeLine(Username)
h.writeLine(Pronouns)
h.writeLine(password)
h.close()
fs.open("./"..Username.."/tempFile.temp","w").close()
fs.open("./sys/Lock.lock","w").close()
sleep(1)
if fs.exists("./sys/OOTB.lua") then
else
  shell.run("mv startup ./sys/OOTB.lua")
end
shell.run("rm ./"..Username.."/tempFile.temp")
sleep(1)
shell.run("mv CATAIOS.lua startup")
setPal(pal)
term.setBackgroundColor(colors.black)
term.setCursorPos(1,1)
term.clear()
term.setTextColor(colors.white)
textutils.slowPrint("WELCOME TO CATAIOS!")
print("*---*")
sleep(0.1)
term.blit("|CAT|","22342","fffff")
print("")
sleep(0.1)
term.blit("| I |","22342","fffff")
print("")
sleep(0.1)
term.blit("| OS|","22342","fffff")
print("")
sleep(0.1)
print("*---*")
print("Press enter to begin useing your brand new system!")
read()
shell.run("rm ./sys/Lock.lock")
shell.run("fg startup")
shell.run("rm install.lua")
sleep(1)
print("To truly begin useing CATAIOS, please reboot!")
print("To reboot, simply press enter")
read()
os.reboot()
