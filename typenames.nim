import typetraits, future, mylist

let f = proc(x: int): int {.closure,noSideEffect.} = x * x
let xs = asList(1..100) !! 5
echo name(type(f))
echo name(type(xs))