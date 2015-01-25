import strutils

iterator collatzSeqFrom(start: int): int =
  var n = start
  while n > 1:
    yield n
    case (n mod 2)
    of 1, -1: n = 3*n + 1
    of 0: n = int(n / 2)
  yield 1

proc collatzSeq(start: int): seq[int] =
  result = @[]
  for n in collatzSeqFrom(start):
    result.add(n)

type result = tuple[start: int, len: int, seq: seq[int]]

var max: result = (1, 1, @[])
for i in 2..1_000_000:
  let currentSeq = collatzSeq(i)
  let currentRes: result = (i, currentSeq.len, currentSeq)
  if (max[1] < currentRes[1]):
    max = currentRes

echo "Starting with $#, the sequence has $# entries.\n" % [$max[0], $max[1]]
echo "The sequence is: $#" % [$max[2]]
