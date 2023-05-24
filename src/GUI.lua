local tArgs = { ... }
if #tArgs < 7 then
  print("Usage: gui <x> <y> <width> <height> <text> <background color> <text color> <file>")
  return
end

local x = tonumber(tArgs[1])
local y = tonumber(tArgs[2])
local width = tonumber(tArgs[3])
local height = tonumber(tArgs[4])
local text = tostring(tArgs[5])
local backgroundColor = tonumber(tArgs[6])
local textColor = tonumber(tArgs[7])
local fileName = tostring(tArgs[8])

-- Create a new GUI window
local guiWindow = window.create(term.current(), 1, 1, 20, 10)
guiWindow.setBackgroundColor(colors.lightGray)
guiWindow.clear()

-- Function to create a button
local function createButton(x, y, width, height, text, backgroundColor, textColor)
  -- Draw the button background
  guiWindow.setBackgroundColor(backgroundColor)
  for i = 1, height do
    guiWindow.setCursorPos(x, y + i - 1)
    guiWindow.write(string.rep(" ", width))
  end
  
  -- Draw the button text
  guiWindow.setTextColor(textColor)
  local textX = x + math.floor(width / 2) - math.floor(#text / 2)
  local textY = y + math.floor(height / 2)
  guiWindow.setCursorPos(textX, textY)
  guiWindow.write(text)
  
  -- Return the button's coordinates and dimensions
  return x, y, width, height
end

-- Create a button
local buttonX, buttonY, buttonWidth, buttonHeight = createButton(x, y, width, height, text, backgroundColor, textColor)

-- Function to check if coordinates are within button area
local function checkClick(x, y, buttonX, buttonY, buttonWidth, buttonHeight)
  return x >= buttonX and x <= buttonX + buttonWidth - 1 and y >= buttonY and y <= buttonY + buttonHeight - 1
end

-- Function to run the file content
local function runFileContent(fileName)
  local file = fs.open(fileName, "r")
  if file then
    local fileContent = file.readAll()
    file.close()
    local func, err = load(fileContent, "=" .. fileName)
    if func then
      func()
    else
      print("Error loading file: " .. err)
    end
  else
    print("File not found: " .. fileName)
  end
end

-- Main event loop
while true do
  local event, param1, param2, param3 = os.pullEvent()
  if event == "mouse_click" then
    local clickX, clickY = param2, param3
    if checkClick(clickX, clickY, buttonX, buttonY, buttonWidth, buttonHeight) then
      -- Button clicked
      runFileContent(fileName)
      break
    end
  end
end
