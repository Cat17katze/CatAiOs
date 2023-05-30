function eta(todo,done,delay)
  speed=delay/done
  print("ETA:",(speed*todo)*1000)
end
function reset()
  term.setBackgroundColor(colors.black)
  term.setCursorPos(1,1)
  term.clear()
  term.setTextColor(colors.lime)
end
reset()
term.blit("Welcome to CatAiOs!","2432432143124324324","fffffffffffffffffff")
print("")
print("Please relax while we prepare your computer!")
function bar(procent,maintask,comment)
  reset()
  term.blit("Welcome to CatAiOs!","2432432143124324324","ggggggggggggggggggg")
  print(maintask)
  print(comment)
  print("[*****]")
  term.setCursorPos(2,4)
  print(string.rep("#",procent/20))
  print(procent.."%")
end
function wget(link,optionalName)
  term.setTextColor(colors.black)
  shell.run("wget",link,optionalName)
end
function install(getAPM,getSKY)
  reset()
  print("Please select what version of CATAIOS to install")
  while true do
    print("For the main version press M")
    print("the main version is the most stable build")
    print("For the experimental version press E")
    print("the experimental version is the most modern version, but it is likely buggy")
    print("Alternatively press C to enter a custom build")
    E,K=os.pullEvent("key")
    if K == keys.m then
      build="https://raw.githubusercontent.com/TheAio/CatAiOs/main/"
      break
    elseif K == keys.e then
      build="https://raw.githubusercontent.com/TheAio/CatAiOs/experimental/"
      break
    elseif K == keys.c then
      print("Custom builds are linked similarly to the following example:")
      print("https://raw.githubusercontent.com/TheAio/CatAiOs/[BUILD]/")
      while true do
        print("Enter the build link")
        build=read()
        print("Testing if link works...")
        shell.run("wget",build.."version.info temp.temp")
        if fs.exists("temp.temp") then
          print("OK")
          shell.run("rm temp.temp")
          break
        else
          print("The link does not work")
          if string.sub(build,string.len(build),string.len(build)) == "/" then
            print("Are you sure you linked the raw page (no html)?")
          else
            print("Are you sure you included the last '/' in the link? (for example '..."..string.sub(build,string.len(build)-2,string.len(build)).."/)")
          end
        end
     end
     end
     break
  end
  items=5
  startInstall = os.time()
  shell.run("wget",build.."installer/introMusic.temp")
  delay = os.time() - startInstall
  shell.run("bg introMusic.temp")
  shell.run("rm introMusic.temp")
  reset()
  bar((0/items)*100,"Downloading files","main file")
  eta(items,1,delay)
  wget(build.."src/CATAIOS","CATAIOS.lua")
  if getAPM then
    bar((1/items)*100,"Downloading files","APM")
    eta(items,2,delay)
    wget("https://raw.githubusercontent.com/TheAio/CC-APM/main/APM","APM")
    bar((2/items)*100,"Downloading files","APMs")
    eta(items,3,delay)
    wget("https://raw.githubusercontent.com/TheAio/CC-APM/main/APMs","APMs")
    bar((3/items)*100,"Fetching APM files","FTP")
    eta(items,4,delay)
    shell.run("APM install 8 -y")
    if getSKY then
      bar((4/items)*100,"Fetching APM files","skynet")
      eta(items,5,delay)
      shell.run("APM install 19 -y")
    end
  end
  reset()
  bar((5/items)*100,"Downloading important files","DO NOT SHUTDOWN THE COMPUTER")
  wget(build.."installer/installList","installList.temp")
  h=fs.open("installList.temp","r")
  while true do
        i=h.readLine()
        if i == nil then
           h.close()
           break
        else
          shell.run("wget",build..i,h.readLine())
        end
  end
  if getSKY then
    bar(25,"Configuring system","Skynet")
    shell.run("skynet")
  end
  bar(50,"Configuring system","other settings")
  shell.run("set bios.strict_globals false")
  shell.run("set bios.use_multishell true")
  shell.run("mkdir secure")
  sleep(0.25)
  bar(75,"Configuring system","shell")
  shell.run("set shell.allow_disk_startup false")
  shell.run("set shell.allow_startup true")
  shell.run("set shell.autocomplete true")
  shell.run("set shell.autocomplete_hidden false")
  sleep(0.25)
  bar(100,"Configuring system","lua")
  shell.run("set lua.autocomplete true")
  shell.run("set lua.warn_against_use_of_local true")
  shell.run("set lua.warn_against_use_of_local true")
  shell.run("set lua.function_source false")
  shell.run("set lua.function_args true")
  shell.run("wget",build.."version.info version.info")
  while true do
    bar(100,"Installation complete!","Welcome!")
    if multishell.getTitle(2) == "shell" then
      break
    end
    sleep(0)
  end
  reset()
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
  print("The system will shutdown in a moment!")
  sleep(1)
  shell.run("encryptFS")
  error("if you see this, the system failed to install correctly! or you interupted things...")
end
term.setTextColor(colors.gray)
shell.run("wget https://raw.githubusercontent.com/TheAio/CatAiOs/main/LICENSE LICENSE")
shell.run("wget https://raw.githubusercontent.com/TheAio/CC-APM/main/LICENSE LICENSE2")
shell.run("wget https://raw.githubusercontent.com/osmarks/skynet/master/LICENSE LICENSE3")
if fs.exists("LICENSE") then
  if fs.exists("LICENSE2") and fs.exists("LICENSE3") then
    term.setTextColor(colors.white)
    print("Press any key to continue!")
    os.pullEvent("key")
    term.clear()
    term.setCursorPos(1,1)
    print("In order to continue, please carefully read through and accept")
    print("the GNU AFFERO GENERAL PUBLIC LICENSE Version 3, 19 November 2007")
    print("To read the license press 'R' to accept it directly press 'Y' otherwise press any other key")
    function licenseFunc(LF)
    E,K = os.pullEvent("key")
    if K == keys.y then
       print("Thank you!")
       return true
    elseif K == keys.r then
      term.clear()
      term.setCursorPos(1,1)
      f = fs.open(LF,"r")
      file={}
      while true do
        i=f.readLine()
        if i == nil then
           break
        else
          file[#file+1]=i
        end
      end
      k=0
      read = false
      while read == false do
        for j=1,40 do
          k=k+1
          if k+j == #file+1 then
            break
          else
            if file[k] == nil then
                read=true
                break
            end
            print(file[k])
          end
          print("--PRESS ENTER TO CONTINUE--")
          while true do
            E,K = os.pullEvent("key")
            if K == keys.enter then
              break
            else
              sleep(1)
            end
          end
          term.clear()
        end
      end
      sleep(1)
    else
      return false
    end
    end
    if licenseFunc("LICENSE") then
      term.clear()
      term.setCursorPos(1,1)
      print("If you want APM")
      print("please also agree to the following license")
      print("GNU GNU GENERAL PUBLIC LICENSE, Version 3, 29 June 2007")
      print("To read the license press 'R' to accept it directly press 'Y' otherwise press any other key")
      if licenseFunc("LICENSE2") then
        getAPM = true
      else
        getAPM = false
      end
      term.clear()
      term.setCursorPos(1,1)
      print("If you want Skynet")
      print("please also agree to the following license")
      print("MIT License, Copyright (c) 2018 - Heat Death of the Universe Oliver Marks")
      print("To read the license press 'R' to accept it directly press 'Y' otherwise press any other key")
      if licenseFunc("LICENSE3") then
        getSKY = true
      else
        getSKY = false
      end
      install(getAPM,getSKY)
    else
      shell.run("rm LICENSE")
      shell.run("rm LICENSE2")
    end
  else
    shell.run("rm LICENSE")
    error("Failed to fetch all license files")
  end
  printError("License files could not be downloaded")
  printError("Please make sure that your device can reach the internet!")
  error("Failed to fetch license files")
end
