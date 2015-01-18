import math

const hi = 1000

for x in 1..hi:
  for y in x..hi:
    for z in y..hi:
      if pow(float(x), 2.0) + pow(float(y), 2.0) == pow(float(z), 2.0):
        # echo($(int(x)) & "^2 + " & $(int(y)) & "^2 = " & $(int(z)) & "^2")
        if (x + y + z == 1000):
          # echo("The answer is: " & $(int(x)) & "^2 + " & $(int(y)) & "^2 = " & $(int(z)) & "^2")
          echo($(x*y*z))
