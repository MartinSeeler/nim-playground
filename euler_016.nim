import bigints, strutils

let x = $(2.pow 1000)
var sum = 0
for d in x:
  sum += parseInt($d)

echo sum