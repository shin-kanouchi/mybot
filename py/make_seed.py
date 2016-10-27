import sys

for line in open(sys.argv[1]):
  if line.startswith("#"):
    topic_id = line[1:].strip().split(",")[0]
    continue
  if line.strip() == "": continue
  print ('Sentence.where(sentence: "%s", source_flag: "3", topic_id: Topic.ids[%d]).first_or_create' % (line.strip(), int(topic_id)-1))
