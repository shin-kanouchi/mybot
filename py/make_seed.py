import sys

for line in open(sys.argv[1]):
  if line.startswith("#"): continue
  if line.strip() == "": continue
  print ('Sentence.create(sentence: "%s", source_flag: "3")' % line.strip())
