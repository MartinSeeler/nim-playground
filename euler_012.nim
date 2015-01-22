import math, future, strutils, times, threadpool

{.optimization: speed.}

proc divs(n: int): int =
  let high = int(sqrt(float(n+1)))
  for i in 1..high: 
    if (n mod i == 0): 
      result.inc
      if i != int(int(n) / i): result.inc

proc tri(n: int): int = 
  for i in 1..n: result.inc(i)

type triple = tuple[n: int, tri: int, divs: int]

proc firstWinner(ts: seq[triple], n: int): triple =
  for t in ts:
    if t[2] >= n:
      return t

proc getTriple(n: int): triple =
  let tri = tri(n)
  let ds = divs(tri)
  return (n, tri, ds)

proc getFirstNTriples(n: int, offset: int = 0): seq[triple] =
  var res = newSeq[triple](n+1)
  for i in 0..res.high:
    res[i] = getTriple(i+offset)
  return res

var responses = newSeq[FlowVar[seq[triple]]](15)
for i in 0..14:
  responses[i] = spawn getFirstNTriples(1000, i * 1000)

for r in responses:
  let w = firstWinner(^r, 500)
  if w != (0,0,0):
    echo w
    break



  #echo "The result for number $# is $# with $# divisors".format(n, trin, res)

# echo "The triangular number of $# is $# and has $# divisors".format(n, trin, divs(trin))


# let xs = asList(400..600).map((x: int) => (0/:asList(1..x))(sumF)).map((x: int) => divs(x)).filter((xs: List[int]) => xs.length() >= 500)
# echo xs