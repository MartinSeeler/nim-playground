import bigints, strutils

const h = 100

var sum = 0
for x in 1..h:
  for y in 1..h:
    let z = initBigInt(x).pow(initBigInt(y))
    var newSum = 0
    for d in $z:
      newSum += parseInt($d)
    if sum < newSum: sum = newSum

echo sum