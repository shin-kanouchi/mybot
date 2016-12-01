import sys
import random

l = []
for line in open(sys.argv[1]):
  words = line.strip().split()
  if "<unk>" in words: continue
  if len(words) > 15: continue
  l.append("".join(words))

random.shuffle(l)
print("\n".join(l))
