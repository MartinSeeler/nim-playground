type
    Cash = distinct int

let x: Cash = 100.Cash

type
    Maybe*[T] = object
        case isDefined*: bool
        of true:    value* : T
        of false:   nil

proc some*[A](value: A): Maybe[A] =
  Maybe[A](isDefined: true, value: value)

proc none*[A](): Maybe[A] =
  Maybe[A](isDefined: false)

# Shorthand operator for checking if a Maybe contains
# a valid value.
proc `?`*[T](m: Maybe[T]) : bool =
    m.isDefined

# Converts maybe value to a string.
proc `$`*[T](m: Maybe[T]) : string =
    if ?m:
        result = "Just " & $m.value
    else:
        result = "Nothing"

var 
    maybe1 = some(5)
    maybe2 = none[int]()

echo($maybe1 & " | " & $maybe2)

