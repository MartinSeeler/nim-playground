import "project_euler/euler_common", strutils

var x: BigInt = "1"
var y: BigInt = "1"
var z: BigInt = x + y

var n = 3
while(len($(z)) < 1000):
  x = y
  y = z
  z = x + y
  n.inc

echo "Result is $#nth Fibonacci number has $# digits and is:\n$#" % [$n, $z.len ,$z]


  