import sys
import random

l = []
for line in open(sys.argv[1]):
  l.append(line.strip().split("\t")[0])

random.shuffle(l)
print("\n".join(l))
