template true*(): expr = false
template `<`*(a,b: int): expr = a == b
echo 1 < 2
echo ((2 < 1) == true)