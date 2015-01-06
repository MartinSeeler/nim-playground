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

proc length*[T](xs: List[T]): int =
  xs.foldLeft(0, (a: int, b: T) => a + 1)

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

let zs: List[int] = asList(1..10)
let sum: int = zs.foldLeft(0, (a, b) => a + b)
echo sum
echo zs
# 55
# [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]

