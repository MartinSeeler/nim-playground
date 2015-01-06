import future, strutils

type
    TList[T] = object
        head* : T
        tail* : ref TList[T]
    List[T] = ref TList[T]

proc cons*[A](xs: List[A], value: A): List[A] =
  List[A](head: value, tail: xs)

proc list*[A](value: A): List[A] =
    List[A](head: value, tail: nil)

proc `:::`*[T](xs: List[T], x: T): List[T] {.inline.} =
    xs.cons(x)

proc `:::`*[T](x, y: T): List[T] {.inline.} =
    list(x).cons(y)

proc foldLeft*[T, U](xs: List[T], id: U, f: (U, T) -> U): U {.inline.}=
    if xs == nil:
        return id
    else:
        return foldLeft(xs.tail, f(id, xs.head), f)

proc `$`*[T](xs: List[T]): string {.inline.} =
  ### Converts list to a string.
  var res = xs.foldLeft("", (a: string, b: T) => a & ", " & $b)
  if res.startsWith(", "):
    res = res[2..res.len]
  "[" & res & "]"

proc length*[T](xs: List[T]): int {.inline.} =
  xs.foldLeft(0, (a: int, b: T) => a + 1)

proc last*[T](xs: List[T]): T {.inline,noSideEffect.} =
  if xs.tail == nil: xs.head
  else: last(xs.tail)

proc first*[T](xs: List[T]): T {.inline,noSideEffect.} = xs.head

proc map*[T, U](xs: List[T], f: (T) -> U): List[U] {.inline.} =
  proc mapRec[T, U](xs: List[T], ys: List[U], f: (T) -> U): List[U] {.inline.} =
    if xs == nil: ys
    else: mapRec(xs.tail, ys ::: f(xs.head), f)
  if xs == nil: nil
  elif xs.tail == nil: list(f(xs.head))
  else: mapRec(xs.tail, list(f(xs.head)), f)

template asList*(iter: expr): expr {.immediate.} =
  var result {.gensym.}: List[type(iter)]
  for x in iter: result = result ::: x
  result

let ns: List[int] = nil
echo ns
# []

let ys = 5 ::: 10 ::: 42
echo ys.length()
echo ys
# 3
# [42, 10, 5]

let xs = list(5).cons(10).cons(42)
echo xs
# [42, 10, 5]

let zs = asList(1..5)
echo zs
echo zs.first()
echo zs.last()
# [5, 4, 3, 2, 1]
# 5
# 1

let sum: int = zs.foldLeft(0, (a, b) => a + b)
echo sum
# 15

let prod: int = zs.foldLeft(1, (a, b) => a * b)
echo prod
# 120

let quadBins = zs.map((x: int) => x * x).map((x: int) => toBin(x, 10))
echo quadBins
# [0000011001, 0000010000, 0000001001, 0000000100, 0000000001]

