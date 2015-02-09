import strutils, streams, os, future, re, asyncfile, asyncdispatch

{.optimization: speed.}

if paramCount() < 1:
  quit("Usage: less2sass filename[.less]")

proc main() {.async.} =
    let filename = addFileExt(paramStr(1), "less")
    # Simple write/read test.
    block:
      let file = openAsync(filename, fmRead)
      let data = await file.readAll()
      file.close()
      for line in splitLines(data):
        var matches: array[0..MaxSubpatterns-1, string]
        echo line.replace(re("@(?!font-face|import|media|keyframes|-.*)"), "$")
        echo line.replace(re("\.([\w\-]*)\s*\((.*)\)\s*\{"), "@mixin \1\(\2\)\n{")
        # if line.match(re("@(?!font-face|import|media|keyframes|-)(.*)"), matches):
        #    echo "$" & matches[0]


discard main()
      
