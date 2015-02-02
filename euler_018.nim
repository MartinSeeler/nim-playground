import strutils

type
  Tree = ref object
    value: int
    left: ref Tree
    right: ref Tree

const input = """
3
7 4
2 4 6
8 5 9 3
"""

const lines = splitLines(input)

proc parseLine(line: string): seq[int] =
  result = @[]
  for number in split(line):
    result.add(parseInt($number))

proc parseTree(lines: seq[string], t: var ref Tree): Tree = 
  if lines.len == 0:
    discard
  else:
    let nums = parseLine(lines[0])
    for i, x in nums:
      t.value = x
      echo x, i
    echo nums
    discard parseTree(lines[1..lines.len-1], t)

var root = new(Tree)
discard parseTree(lines[0..lines.len-2], root)
