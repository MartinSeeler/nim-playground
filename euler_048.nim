import bigints

{.optimization: speed.}

proc solve(h: int): BigInt {.noSideEffect,inline.} =
  result = 0.initBigInt
  for x in 1..h:
    result += initBigInt(x).pow(initBigInt(x))

let sum = solve(1000)
echo sum