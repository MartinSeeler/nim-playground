type  
  Option[T] = object
    case empty: bool
    of false: value: T
    else: nil

proc Some*[T](val: T): Option[T] =
  result.empty = false
  result.value = val

proc None*[T](): Option[T] =
  result.empty = true

proc `$`*[T](x: Option[T]): string =
  if x.empty:
    return "None"
  else:
    return "Some(" & $x.value & ")"

proc safeReadLine(): Option[string] =
  var r = "Foobar"
  if r == "": return None[string]()
  else: return Some(r)

when isMainModule:
  var test: Option[string] = None[string]()
  echo($test)
  var mSomething = safeReadLine()
  echo($mSomething)
