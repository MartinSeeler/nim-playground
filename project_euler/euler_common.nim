import strutils, sequtils

proc toSeq*(str: string): seq[int] =
  result = @[]
  for x in str:
    result = concat(result, @[parseInt($x)])
  discard

proc toSeq*[T](x: T): seq[int] = toSeq($x)
