import sequtils

echo toSeq(1 || 999).filterIt((it mod 3 == 0) or (it mod 5 == 0)).foldl(a + b)