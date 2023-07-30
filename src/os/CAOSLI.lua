args = {...}
if #args < 1 then
  print("Usage CAOSLI.lua <path>")
  return false
end
handel=fs.open(args[1],"r")
file={}
while true do
  i=handel.readLine()
  if i == nil then
    break
  elseif string.sub(i,1,1) == "$" or string.sub(i,1,1) == ">" or string.sub(i,1,1) == "<" then
    file[#file+1] = i
  end
end
handel.close()
LIVE=0
ALPHA=0
POS=1
function FA(line)
  s=0
  e=0
  for c=1,string.len(line) do
    if string.sub(line,c,c) == "?" then
      s=c+1
    elseif string.sub(line,c,c) == ":" then
      e=c-1
      break
    end
  end
  return string.sub(line,s,e)
end
function treat(line)
  if string.sub(i,1,1) == "!" then
    return false
  elseif string.sub(i,1,1) == ">" then
    ALPHA = LIVE
  elseif string.sub(i,1,1) == "<" then
    LIVE = ALPHA
  elseif string.sub(i,1,1) == "$" then
    if string.sub(i,2,4) == "PAD" then
      Jumps[#Jumps+1]={FA(line)[1],CLINE}
    elseif string.sub(i,2,5) == "JUMP" then
      if FA(line,2)[1] > 0 then
        POS = FA(line)-1
      end
    elseif string.sub(i,2,4) == "ADD" then
      LIVE = LIVE + FA(line)
    elseif string.sub(i,2,4) == "SUB" then
      LIVE = LIVE - FA(line)
    elseif string.sub(i,2,5) == "EXEC" then
      shell.run(FA(line))
    elseif string.sub(i,2,3) == "IN" then
      LIVE=tonumber(read(FA(line)))
    elseif string.sub(i,2,4) == "OUT" then
      print(FA(line))
    elseif string.sub(i,2,5) == "SPIT" then
      print(LIVE)
    end
  end
  return true
end
while POS<#file+1 do
  if treat(file[POS]) then
    POS=POS+1
  else
    break
  end
end
