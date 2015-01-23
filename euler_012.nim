import math, future, strutils, times, threadpool

{.optimization: speed.}

proc divs(n: int): int =
  let high = int(sqrt(float(n+1)))
  for i in 1||high: 
    if (n mod i == 0): 
      result.inc
      if likely(i != int(int(n) / i)): result.inc

proc tri(n: int): int = 
  for i in 1||n: result.inc(i)

type triple = tuple[n: int, tri: int, divs: int]

proc firstWinner(ts: seq[triple], n: int): triple =
  for t in ts:
    if t[2] >= n:
      return t

var maxDiv: triple = (0,0,0)

proc getMax(ts: seq[triple]): triple =
  for t in ts:
    if t[2] >= result[2]:
      result = t

proc getTriple(n: int): triple =
  let tri = tri(n)
  let ds = divs(tri)
  return (n, tri, ds)

proc getFirstNTriples(n: int, offset: int = 0): seq[triple] =
  var res = newSeq[triple](n+1)
  for i in 0..res.high:
    res[i] = getTriple(i+offset)
  return res

proc searchWinner(divisors: int, round: int = 1): auto = 
  var responses = newSeq[FlowVar[seq[triple]]](20)
  for i in 0..19:
    responses[i] = spawn getFirstNTriples(50, round * i * 50)
  for r in responses:
    let w = firstWinner(^r, divisors)
    let max = getMax(^r)
    if maxDiv[2] < max[2]:
      maxDiv = max
      echo "Max is now " & $maxDiv
    if w != (0,0,0):
      return w
  return searchWinner(divisors, round + 1)

echo searchWinner(500, 100)


  #echo "The result for number $# is $# with $# divisors".format(n, trin, res)

# echo "The triangular number of $# is $# and has $# divisors".format(n, trin, divs(trin))


# let xs = asList(400..600).map((x: int) => (0/:asList(1..x))(sumF)).map((x: int) => divs(x)).filter((xs: List[int]) => xs.length() >= 500)
# echo xs