import sys
from collections import defaultdict

d = defaultdict(lambda: 0)
for line in open(sys.argv[1]):
  k, v = line.strip().split()
  if int(v) > 100000:
    d[k] = v


for line in open(sys.argv[2]):
  if line.strip() in d:
    print (line.strip())
    
