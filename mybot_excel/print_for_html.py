import sys

N = 1
num = 1
for line in open(sys.argv[1]):
  print('\
<hr/>\n\
<p> [%d/200] </p>\n\
<p>発話文：%s</p>\n\
<p>応答文：<input maxlength="40" name="text_%d_%d" size="40" type="text" /></p>\
' % (num, line.strip(),  N, num))
  num += 1
  if num == 201:
    num = 1
    N += 1

