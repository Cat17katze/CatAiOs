-- Shell Command Runner with Safety Measures and Argument Prompt for ComputerCraft

local function moveFileToTrash(file)
  local trashFolder = "/trash"
  if not fs.exists(trashFolder) then
      fs.makeDir(trashFolder)
  end
  local fileName = fs.getName(file)
  local newFilePath = fs.combine(trashFolder, fileName)
  fs.move(file, newFilePath)
end

local function contains(table, value)
  for _, v in pairs(table) do
      if v == value then
          return true
      end
  end
  return false
end

local function runShellCommand(command)
  local restrictedCommands = {
      "rm",
      "delete",
      "fg",
      "bg",
      "sh"
  }
  local commandParts = string.gmatch(command, "%S+")
  local firstPart = commandParts()
  if firstPart and contains(restrictedCommands, firstPart) then
      print("Error: Restricted command '" .. firstPart .. "'")
  else
      shell.run(command)
  end
end

-- Load and execute commands from a file
local function executeCommandsFromFile(filename)
  local file = fs.open(filename, "r")
  if file then
      while true do
          local command = file.readLine()
          if command == nil then
              break
          end
          if command == "!INP-ARG" then
              term.write("Argument: ")
              command = file.readLine().." "..read()
          elseif string.sub(command,1,5) == "!JUMP" then
              for jump=1,tonumber(string.sub(command,7,string.len(command)))-1 do
                file.readLine()
              end
              command = file.readLine()
          elseif command == "!RESET" then
            file.close()
            file = fs.open(filename,"r")
          end
          runShellCommand(command)
      end
      file.close()
  else
      print("Error: Failed to open file '" .. filename .. "'")
  end
end

-- Usage
local args = {...}
if #args < 1 then
  print("Usage: shellrunfile <filename>")
else
  local filename = args[1]
  executeCommandsFromFile(filename)
end
