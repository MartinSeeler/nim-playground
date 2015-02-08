import tables, terminal

var t = initCountTable[string](128)

t["hello"] = 1
t["foo"] = 10
t["foo"] = t["foo"] + 1

system.addQuitProc(resetAttributes)
write(stdout, "never mind")
eraseLine()
#setCursorPos(2, 2)
writeStyled("styled text ", {styleBright, styleBlink, styleUnderscore})
setForeGroundColor(fgBlue)
writeln(stdout, "ordinary text")

styledEcho("styled text ", {styleUnderscore})     
resetAttributes()
proc double(x: int): int =
    x + x

echo 5.double