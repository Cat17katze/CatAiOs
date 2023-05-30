args = {...}
if #args == 0 then
  print("Usage: .power.lua {action}")
  print("Actions:")
  print("SafeShutdown - Safely power off the computer")
  print("FullShutdown - Power off the computer completely")
  print("FakeShutdown - Pretends to power off the computer")
  print("HardShutdown - Power off the computer UNSAFELY")
  print("Reboot - Safely reboots the computer")
  return false
end
function Safe()
  if multishell.getCount() > 1 then
    print("Software is still running, continuing in 5 seconds anyways")
    os.queueEvent("SHUTDOWN",5)
    sleep(5)
  else
    os.queueEvent("SHUTDOWN",0)
  end
  shell.run("encryptFS")
end
if args[1] == "SafeShutdown" then
  shell.run("/.recolor")
  Safe()
  term.setBackgroundColor(colors.black)
  term.clear()
  term.setCursorPos(1,1)
  term.setTextColor(colors.orange)
  print("It is now safe to power off your computer!")
  print("or press any key to reboot")
  sleep(1)
  os.pullEvent("key")
  shell.run("/startup")
  return false
elseif args[1] == "FullShutdown" then
  shell.run("/.recolor")
  Safe()
  term.setBackgroundColor(colors.black)
  term.clear()
  os.shutdown()
elseif args[1] == "FakeShutdown" then
  shell.run("/.recolor")
  Safe()
  term.setBackgroundColor(colors.black)
  term.clear()
  return false
elseif args[1] == "HardShutdown" then
  print("WARNING - HARD SHUTDOWN WILL CORRUPT THE SECURED FILES!")
  print("CONTINUING IN 5 SECONDS")
  sleep(1)
  term.setBackgroundColor(colors.black)
  term.clear()
  os.shutdown()
elseif args[1] == "Reboot" then
  shell.run("/.recolor")
  Safe()
  term.setBackgroundColor(colors.black)
  term.clear()
  os.reboot()
else
  print("UNKNOWN COMMAND!")
end
