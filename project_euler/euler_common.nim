import strutils, sequtils

type BigInt* = seq[int]

proc `$`*(xs: BigInt): string =
  result = ""
  for x in xs:
    result = result & $x

converter toBigInt*(str: string): BigInt =
  result = @[]
  for x in str:
    result = concat(result, @[parseInt($x)])
  discard

proc toBigInt*[T](x: T): BigInt = toBigInt($x)

proc sumCol(xs: seq[BigInt], rev_index: int = 0): int =
  for x in xs:
    if x.len > rev_index:
      result += x[x.len-rev_index-1]

proc sum(xs: seq[BigInt], rev_index: int = 0): BigInt =
  result = @[]
  var reminder = 0
  for i in 0..xs[1].len-1:
    let sum = sumCol(xs, i) + reminder
    let num = int(sum mod 10)
    reminder = int((sum - num) / 10)
    result = concat(@[num], result)
  if reminder > 0:
    var reminders: seq[int] = @[]
    for i in $reminder:
      let r = parseInt($i)
      reminders.add(r)
    result = concat(reminders, result)

proc `+`*(x, y: BigInt): BigInt = sum(@[x, y])

proc `*`(x: BigInt, y: int): BigInt =
  result = @[]
  var reminder = 0
  for n in countDown(x.len-1, 0):
    let p = (x[n]*y) + reminder
    let num = int (p mod 10)
    reminder = int((p - num) / 10)
    result = concat(@[num], result)
  var reminders: seq[int] = @[]
  if reminder > 0:
    for i in $reminder:
      let r = parseInt($i)
      reminders.add(r)
  result = concat(reminders, result)

proc `*`(y: int, x: BigInt): BigInt = x * y

proc div10(x: BigInt): BigInt = x[0..x.len-2]
proc mod10(x: BigInt): int = x[x.len-1]

# proc `*`(x, y: BigInt): BigInt =
#   result = @[]
#   var reminder: BigInt = "0"
#   for n in countDown(x.len-1, 0):
#     let p: BigInt = (x[n] * y) + reminder
#     let num = mod10(p)
#     reminder = div10(p - num)
#     result = concat(@[num], result)
#   var reminders: seq[int] = @[]
#   if reminder > 0:
#     for i in $reminder:
#       let r = parseInt($i)
#       reminders.add(r)
#   result = concat(reminders, result)


when isMainModule:
  var x: BigInt = "100"
  for i in countDown(99, 2):
    x = x * i
  var res = 0
  for n in x:
    res += n
  echo res
