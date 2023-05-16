error("This file is not ready yet!")
function reset()
  term.setBackgroundColor(colors.black)
  term.setCursorPos(1,1)
  term.clear()
  term.setTextColor(colors.lime)
end
reset()
term.blit("Welcome to CatAiOs!","24324321431be4fbe4f","fffffffffffffffffff")
print("Please relax while we prepare your computer!")
function bar(procent,maintask,comment)
  reset()
  term.blit("Welcome to CatAiOs!","24324321431be4fbe4f","fffffffffffffffffff")
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
  if getAPM then
    bar(10,"Downloading files","APM")
    wget("https://raw.githubusercontent.com/TheAio/CC-APM/main/APM","APM")
    bar(15,"Downloading files","APMs")
    wget("https://raw.githubusercontent.com/TheAio/CC-APM/main/APMs","APMs")
    bar(50,"Fetching APM files","FTP")
    shell.run("APM install 8 -y")
    if getSKY then
      bar(100,"Fetching APM files","skynet")
    end
    shell.run("APM install 19 -y")
  end
  bar(20,"Downloading files","Source files")
end
term.setTextColor(colors.gray)
shell.run("wget https://raw.githubusercontent.com/TheAio/CatAiOs/main/LICENSE LICENSE")
shell.run("wget https://raw.githubusercontent.com/TheAio/CC-APM/main/LICENSE LICENSE2")
shell.run("wget https://raw.githubusercontent.com/osmarks/skynet/master/LICENSE LICENSE3")
if fs.exists("LICENSE") then
  if fs.exists("LICENSE2") and fs.exists("LICENSE3") then
    term.setTextColor(colors.white)
    term.clear()
    term.setCursorPos(1,1)
    print("In order to continue, please carefully read through and accept")
    print("the GNU AFFERO GENERAL PUBLIC LICENSE Version 3, 19 November 2007")
    print("To read the license press 'R' to accept it directly press 'Y' otherwise press any other key")
    function licenseFunc(LF)
          E,K = os.pullEvent("key")
    if K == keys.y then
       print("Thank you!")
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
      while true do
        for j=1,20 do
          k=k+1
          if k == #file+1 then
            break
          else
            print(file[k])
          end
          print("--PRESS ENTER TO CONTINUE--")
          while true do
            if os.pullEvent("key") == keys.enter then
              break
            else
              sleep(1)
            end
          end
          term.clear()
        end
      end
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
