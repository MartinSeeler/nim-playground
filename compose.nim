import future

proc `.>`*[A,B,C](g: A -> B, f: B -> C): A -> C = (x: A) => f(g(x))

proc quadF(x: int): int = x * x
proc toStringF(x: int): string = $x

var quadtoStringF = quadF .> toStringF
echo quadtoStringF(10)