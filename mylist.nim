import future, strutils

{.experimental.}

type
    TList[T] = object
        head* : T
        tail* : ref TList[T]
    List[T] = ref TList[T]

    Predicate[T] = proc(x: T): bool

proc cons*[A](xs: List[A], value: A): List[A] {.noSideEffect.} =
  List[A](head: value, tail: xs)

proc list*[A](value: A): List[A] =
    List[A](head: value, tail: nil)

proc `::>`*[T](x: T, xs: List[T]): List[T] {.inline.} =
    xs.cons(x)

proc `::>`*[T](x, y: T): List[T] {.inline.} =
    list(y).cons(x)

proc foldLeft*[T, U](xs: List[T], id: U, f: (U, T) -> U): U =
    if xs == nil:
        return id
    else:
        return foldLeft(xs.tail, f(id, xs.head), f)

proc `/:`*[T, U](id: U, xs: List[T]): (proc(f: proc(x: U, y: T): U): U) = 
  return proc(f: proc(x: U, y: T): U): U = foldLeft(xs, id, f)

proc foldRight*[T, U](xs: List[T], id: U, f: (T, U) -> U): U =
    if xs == nil:
        return id
    else:
        return f(xs.head, foldRight(xs.tail, id, f))

proc `:\`*[T, U](id: U, xs: List[T]): (proc(f: proc(x: T, y: U): U): U) = 
  return proc(f: proc(x: T, y: U): U): U = foldRight(xs, id, f)

proc mkString*[T](xs: List[T], left: string = "List[", right: string = "]", sep: string = ", "): string =
  ### Converts list to a string.
  if xs == nil:
    left & right
  else:
    left & ($(xs.head) /: xs.tail)((a: string, b: T) => a & sep & $b) & right  

proc `$`*[T](xs: List[T]): string = xs.mkString()

proc length*[T](xs: List[T]): int =
  (0 /: xs)((a: int, b: T) => a + 1)

proc last*[T](xs: List[T]): T {.inline,noSideEffect.} =
  if xs.tail == nil: xs.head
  else: last(xs.tail)

proc first*[T](xs: List[T]): T {.inline,noSideEffect.} = xs.head

proc reverse*[T](xs: List[T]): List[T] =
  (cast[List[T]](nil) /: xs)((ys: List[T], x: T) => x ::> ys)

proc map*[T, U](xs: List[T], f: (T) -> U): List[U] =
  (cast[List[U]](nil) :\ xs)((x: T, ys: List[U]) => f(x) ::> ys)

proc filter*[T](xs: List[T], p: (x:T) -> bool): List[T] =
  (cast[List[T]](nil) :\ xs)(proc(x: T, ys: List[T]): List[T] =
      if p(x): 
        return x ::> ys
      else: 
        return ys
  )
  

template asList*(iter: expr): expr =
  var result {.gensym.}: List[type(iter)]
  for x in iter: result = x ::> result
  result.reverse()

let ns: List[int] = nil
echo ns
# []

let ys = 5 ::> 10 ::> 42
echo ys.length()
echo ys
# 3
# [42, 10, 5]

let sumF = proc(x, y: int): int = x + y
echo((0 /: (5::> 10 ::> 42))(sumF))
# 57

let xs = list(5).cons(10).cons(42)
echo xs
# [42, 10, 5]

let zs = asList(1..10)
echo zs
echo zs.first()
echo zs.last()
# [5, 4, 3, 2, 1]
# 5
# 1

let sum: int = (0:\zs)(sumF)
echo sum
# 15

# let prod: int = zs.foldLeft(1, (a, b) => a * b)
# echo prod
# 120

let quadBins = zs.map((x: int) => asList(1..x)).map((xs: List[int]) => xs.length)
echo quadBins
# [0000011001, 0000010000, 0000001001, 0000000100, 0000000001]

let modP: Predicate[int] = proc(x: int): bool = x mod 2 == 0
let yy = asList(1..10).filter(modP)
echo yy