import math, threadpool, future, strutils, times

{.optimization: speed.}

proc divs(n: int): int =
  let high = int(sqrt(float(n+1)))
  for i in 1..high: 
    if (n mod i == 0): 
      result.inc
      if i != int(int(n) / i): result.inc

proc tri(n: int): int = 
  for i in 1..n: result.inc(i)

var n = 0
var trin = 0
var res = 0

while res <= 500:
  n = n + 1
  trin = tri(n)
  res = divs(trin)
  #echo "The result for number $# is $# with $# divisors".format(n, trin, res)

echo "The triangular number of $# is $# and has $# divisors".format(n, trin, divs(trin))


# let xs = asList(400..600).map((x: int) => (0/:asList(1..x))(sumF)).map((x: int) => divs(x)).filter((xs: List[int]) => xs.length() >= 500)
# echo xs