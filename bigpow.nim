import bigints

var x = 2.pow 1000
var s = $x

echo s[0..19]
echo s[s.high - 19 .. s.high]
echo s.len
echo s