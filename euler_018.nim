import strutils

const input = """
75
95 64
17 47 82
18 35 87 10
20 04 82 47 65
19 01 23 75 03 34
88 02 77 73 07 63 67
99 65 04 28 06 16 70 92
41 41 26 56 83 40 80 70 33
41 48 72 33 47 32 37 16 94 29
53 71 44 65 25 43 91 52 97 51 14
70 11 33 28 77 73 17 78 39 68 17 57
91 71 52 38 17 14 91 43 58 50 27 29 48
63 66 04 68 89 53 67 30 73 16 69 87 40 31
04 62 98 27 23 09 70 98 73 93 38 53 60 04 23
"""

const lines = splitLines(input)

proc parseLine(line: string): seq[int] =
  result = @[]
  for number in split(line):
    result.add(parseInt($number))

proc parseTree(lines: seq[string], sum: int = 0, index: int = 0): int = 
  if lines.len == 0:
    # echo "Reached sum $# and parent $#" % [$sum, $parent]
    sum
  else:
    let nums = parseLine(lines[0])
    let subLines = lines[1..lines.len-1]
    var max = 0
    for i, x in nums:
      if i in {index, index + 1}:
        # echo "will call with sum = $# and index = $#" % [$(sum + x), $i]
        let newSum = parseTree(subLines, sum + x, i)
        if newSum > max: max = newSum
    max

echo parseTree(lines[0..lines.len-2])