import unittest, euler_common

suite "Euler common":

  test "can convert number from string to seq[int]":
    let expected: seq[int] = @[1,2,3,4,5,6,7,8,9,0]
    let actual: seq[int] = toSeq("1234567890")
    check(actual != nil)
    check(actual != nil)
    for i in 0..expected.high:
      check(actual[i] == expected[i])

  test "can convert number from arbitrary object to seq[int]":
    let expected: seq[int] = @[1,2,3,4,5,6,7,8,9,0]
    let actual: seq[int] = toSeq(1234567890'u64)
    check(actual != nil)
    check(actual != nil)
    for i in 0..expected.high:
      check(actual[i] == expected[i])
  