import os, streams, parsexml, strutils, tables, terminal, hashes

{.optimization: speed.}

system.addQuitProc(resetAttributes)

if paramCount() < 1:
  quit("Usage: gml_stats filename[.gml]")

let filename = addFileExt(paramStr(1), "gml")
let estimatedLines = float(getFileSize(filename)) / 40.0
echo "Estimated " & $estimatedLines & " lines in " & formatSize(getFileSize(filename))
let s = newFileStream(filename, fmRead)
var 
  parser: XmlParser
  atts = initCountTable[string](128)
  types = initCountTable[string](32)
  distinctAttValues = initOrderedTable[string, seq[THash]](32)

open(parser, s, filename)
var cDots = 0
echo "Start"
while true:
  parser.next()
  let nDots = int(parser.getLine / int(estimatedLines / 200))
  if nDots > cDots:
    stdout.write ((nDots-cDots).repeatStr("."))
    stdout.flushFile
    cDots = nDots
  case parser.kind 
  of xmlAttribute: 
    if likely(parser.elementName.cmpIgnoreCase("key") == 0):
      let dataKey = parser.attrValue
      while parser.kind != xmlCharData:
        parser.next()
      let dataValue = hashIgnoreStyle parser.charData
      atts.inc(dataKey)
      discard """
      if likely(distinctAttValues.hasKey(dataKey)): 
        if not distinctAttValues[dataKey].contains(dataValue):
          distinctAttValues.mget(dataKey).add(dataValue)
      else: distinctAttValues.add(dataKey, newSeq(1024) & dataValue)
      """
  of xmlElementOpen: types.inc(parser.elementName)
  of xmlEof:
    echo ""
    echo "Reached the end!"
    break
  else:
    discard
parser.close()

echo "Found " & $(types["node"]) & " nodes and " & $(types["edge"]) & " edges"
sort(atts)
for k, v in pairs(atts):
  setForeGroundColor(fgBlue)
  stdout.write(align(($v).insertSep(), 10))
  setForeGroundColor(fgWhite)
  stdout.write(" x ")
  setForeGroundColor(fgGreen)
  stdout.write($k & repeatChar(max(0, 40 - ($k).len)))
  stdout.write($(distinctAttValues[k].len))

  echo ""
  
