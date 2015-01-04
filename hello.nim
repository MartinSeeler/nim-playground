const WORLD = "World"

echo("Hello, ", WORLD)

var name = "Martin"
echo("Hi, ", $name, "!")

var
    x, y = 42

inc(x)
x.inc
echo($x)

if x < 10:
    echo("Lower than 10")
elif x > 10:
    echo("Greater than 10")
else:
    echo("Exactly 10")

var first_name = "Bernd"

# Commen

case first_name
of "":
    echo("Your name is empty?")
of "name":
    echo("Very funny")
of "Bernd", "Martin":
    echo("Cool name!")
else:
    echo "Hi, ", $first_name

for i in countup(1, 10):
    echo($i)

proc isEmpty(sentence: string): auto {.noSideEffect.}=
    if sentence.len == 0:
        return true
    else:
        return false

echo "Martin".isEmpty
echo repr(isEmpty)

type
    biggestInt = int64 #Some type classes
    biggestFloat = float64

type
    direction = enum
        north, east, south, west

let z = south
echo($z)

template `!>`(a,b: expr): expr {.immediate.}=
    let a: int = b
    echo "The result is ", $a

foo !> 5
foo2 !> 42