args = {...}
function reset()
  term.setBackgroundColor(colors.black)
  term.setCursorPos(1,1)
  term.clear()
  term.setTextColor(colors.lime)
end
function bar(procent,maintask)
  reset()
  print(maintask)
  print("")
  print("[*****]")
  term.setCursorPos(2,4)
  print(string.rep("#",procent/20))
  print(procent.."%")
end
if #args < 2 then
    print("Usage: LoadingScreen [list of commands] [title] {flags}")
    print("Flags: -safe to secure script from loop based crashing")
else
    for i=1,#args[1] do
      bar(100*(i/#args[1]),args[2])
      shell.run(args[1][i])
      if args[3] == "-safe" then
        sleep(1)
      end
    end
end
