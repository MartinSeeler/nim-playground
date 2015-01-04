import sequtils

{.optimization: speed.}

proc fib(n: int, x = 1, y = 1): seq[int] {.noSideEffect.} =
    if unlikely((n - 1) == 0):
        return @[x]
    else:
        return @[x] & fib(n - 1, y, x + y)

echo fib(40).filterIt(it mod 2 == 0 and it <= 4_000_000).foldl(a + b)