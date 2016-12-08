import sys
from collections import defaultdict 
import MeCab

g_word = defaultdict(lambda: 0) 
b_word = defaultdict(lambda: 0)
count = 0
mc = MeCab.Tagger("-Owakati")

for line in open(sys.argv[1]):
  items = line.split("\t")
  if len(items) < 3: continue
  tweet = items[0]
  reply = items[1]
  bad_flag = items[2]
  #形態素解析
  words = mc.parse(tweet).strip().split(" ")
  if bad_flag == "":
    for word in words:
      g_word[word] += 1
      count += 1
  else:
    for word in words:
      b_word[word] += 1
      count += 1

#print ("word_num=%d" %count)

for k,v in sorted(g_word.items(), key=lambda x:x[1], reverse=True):
  print("%s\t%d\t1" % (k, v))

for k,v in sorted(b_word.items(), key=lambda x:x[1], reverse=True):
  print("%s\t%d\t0" % (k, v))
