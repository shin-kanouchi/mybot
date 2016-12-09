import sys
from collections import defaultdict 
import MeCab
import math

g_word = defaultdict(lambda: 0) 
b_word = defaultdict(lambda: 0)
g_count = 0
b_count = 0
#mc = MeCab.Tagger("-Owakati")
mc = MeCab.Tagger("mecabrc")

for line in open(sys.argv[1]):
  items = line.strip().split("\t")
  if len(items) < 3: continue
  if items[2] == "1":
    g_word[items[0]] = int(items[1])
    g_count += int(items[1])
  else:
    b_word[items[0]] = int(items[1])
    b_count += int(items[1])

for line in open(sys.argv[2]):
  sent = line.strip().split("\t")[0]
  items = mc.parse(sent).strip().split("\n")
  surfs = []
  for item in items:
    if item == "EOS" or item == "": continue
    surface, pos_str = item.split("\t")
    pos = pos_str.split(",")
    if pos[0] == "助詞": continue
    else:
      surfs.append(surface)

  sent_score = 1
  for word in surfs:
    if g_word[word] + b_word[word] < 3:
      sent_score *= 0.5
      continue
    #print ( (b_word[word] + 1) / b_count )
    #print (g_count, b_count)
    word_score = math.log(float(g_word[word] + 1) / g_count ) - math.log( float(b_word[word] + 1) / b_count )
    #if word_score > 1.4:  word_score = 1.4
    if word_score > 0.34:  word_score = 0.34
    sent_score += word_score

  sent_score = sent_score - (1.1 ** len(surfs) - 1.1 )
  print ("%s\t%f" %(sent, sent_score))
