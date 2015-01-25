import math, sequtils, strutils

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
      var oSeq = output & x
      let r = factorize(n - x, given, oSeq)
      if r.len != 0: return r
    return @[]
  else: return @[]


var abundants: seq[int] = @[]
for x in 1..28122:
  if getNumKind(x) == abundant: abundants.add(x)

echo "Abundant numbers are $#" % [ $abundants ]

var notSummable: seq[int] = @[]
for i in 24..28122:
  let factors = factorize(i, abundants)
  if factors.len != 2: notSummable.add(i)

echo "Sum is $#" % [$notSummable.foldl(a+b)] 
