import mylist, future, strutils, times

{.optimization: speed.}

proc divs(n: int): int =
  var t0 = cpuTime()
  for i in 2..n: 
    if (n mod i == 0): result = result + 1
  echo "divs took [s] ", cpuTime() - t0

proc tri(n: int): int = 
  var t0 = cpuTime()
  for i in 1..n: result = result + i
  echo "tri took [s] ", cpuTime() - t0

var n = 0
var trin = 0
var res = 0
var maxRes = 0
var maxTri = 0
while res <= 500:
  n = n + 1
  trin = tri(n)
  res = divs(trin)
  echo "The result for number $# is $# with $# divisors".format(n, trin, res)

echo "The triangular number of $# is $# and has $# divisors".format(n, trin, res)


# let xs = asList(400..600).map((x: int) => (0/:asList(1..x))(sumF)).map((x: int) => divs(x)).filter((xs: List[int]) => xs.length() >= 500)
# echo xs