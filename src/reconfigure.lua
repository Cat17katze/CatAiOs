shell.run("set bios.strict_globals false")
shell.run("set bios.use_multishell true")
shell.run("mkdir secure")
shell.run("set shell.allow_disk_startup false")
shell.run("set shell.allow_startup true")
shell.run("set shell.autocomplete true")
shell.run("set shell.autocomplete_hidden false")
shell.run("set lua.autocomplete true")
shell.run("set lua.warn_against_use_of_local true")
shell.run("set lua.warn_against_use_of_local true")
shell.run("set lua.function_source false")
shell.run("set lua.function_args true")
shell.run(".recolor")
shell.run("alias shutdown /.shutdown")
shell.run("alias reboot /.reboot")
function DetectPNP()
  local NetList = peripheral.getNames()
  speakers={}
  for i=1,#NetList do
      if peripheral.getType(NetList[i]) == "speaker" then
          speakers[#speakers+1] = peripheral.wrap(NetList[i])
      end
      sleep(0)
  end
  if #speakers == 0 then
      speakers[1] = peripheral.find("speaker")
  end
  monitors={}
  for i=1,#NetList do
      if peripheral.getType(NetList[i]) == "monitor" then
          monitors[#monitors+1] = peripheral.wrap(NetList[i])
      end
      sleep(0)
  end
  if #speakers == 0 then
      monitors[1] = peripheral.find("monitor")
  end
  modems={}
  for i=1,#NetList do
      if peripheral.getType(NetList[i]) == "modem" then
          modems[#modems+1] = peripheral.wrap(NetList[i])
      end
      sleep(0)
  end
  if #modems == 0 then
      modems[1] = peripheral.find("modem")
  end
end
DetectPNP()
