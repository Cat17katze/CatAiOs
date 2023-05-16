if fs.exists(".pal") then
    file = fs.open(".pal","r")
    term.setPaletteColor(colors.black,tonumber(file.readLine()))
    term.setPaletteColor(colors.yellow,tonumber(file.readLine()))
    term.setPaletteColor(colors.white,tonumber(file.readLine()))
    term.setPaletteColor(colors.red,tonumber(file.readLine()))
    term.setPaletteColor(colors.purple,tonumber(file.readLine()))
    term.setPaletteColor(colors.pink,tonumber(file.readLine()))
    term.setPaletteColor(colors.orange,tonumber(file.readLine()))
    term.setPaletteColor(colors.magenta,tonumber(file.readLine()))
    term.setPaletteColor(colors.lime,tonumber(file.readLine()))
else
    term.setPaletteColor(colors.black,0x000000)
    term.setPaletteColor(colors.white,0xFFFFFF)
    term.setPaletteColor(colors.red,0xFF0000)
    term.setPaletteColor(colors.lime,0x00FF00)
    term.setPaletteColor(colors.blue,0x0000FF)
end
