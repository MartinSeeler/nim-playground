import math, sequtils, strutils, threadpool

{.optimization: speed.}

proc divs(n: int): seq[int] =
  result = @[]
  let high = int(sqrt(float(n+1)))
  for i in 1..high: 
    if (n mod i == 0): 
      result.add(i)
      let other = int(int(n) / i)
      if likely(i != other and other != n): 
        result.add(other)

type numKind = enum perfect, deficient, abundant

proc getNumKind(x: int): numKind =
  let divs = divs(x)
  let sumOfDivs = divs.foldl(a + b)
  if sumOfDivs == x: perfect
  elif sumOfDivs < x: deficient
  else: abundant

proc factorize(n: int, given: seq[int], output: seq[int] = @[]): seq[int] = 
  if output.len == 2: 
    if n == 0: return output
    else: return @[]
  elif n >= 12:
    for x in given:
      if x <= n:
        var oSeq = output & x
        let r = factorize(n - x, given, oSeq)
        if r.len != 0: return r
    return @[]
  else: return @[]


var abundants: seq[int] = @[]
for x in 1..28123:
  if getNumKind(x) == abundant: abundants.add(x)

var sumTotal = 0
for x in 1..28123:
  sumTotal.inc(x)

var multiples: seq[int] = @[]
var abundantsSum = 0
for x in abundants:
  for y in abundants:
    let sum = x + y
    if sum <= 28123 and not multiples.contains(sum):
      abundantsSum.inc(sum)
      multiples.add(sum)

echo "Total sum is " & $sumTotal
echo "Abundant sum is " & $abundantsSum
echo "Result is " & $(sumTotal-abundantsSum)