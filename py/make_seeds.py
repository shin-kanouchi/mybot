import sys
topic_id = 1

for line in open(sys.argv[1]):
  if line.strip() == "": continue
  tweet, reply = line.strip().split(" ||| ")
  print ('sent_tweet = Sentence.where(sentence: "%s", source_flag: "3", topic_id: Topic.ids[%d]).first_or_create' % (tweet, int(topic_id)-1))
  print ('sent_reply = Sentence.where(sentence: "%s", source_flag: "3", topic_id: Topic.ids[%d]).first_or_create' % (reply, int(topic_id)-1))
  print ('Train.where(user_id: User.first.id, tweet_id: sent_tweet.id, reply_id: sent_reply.id, topic_id: Topic.ids[%d]).first_or_create' % (int(topic_id)-1))

  #replys = replys_str.split(" ||| ")
  #for reply in replys:
  #  print ('sent_reply = Sentence.where(sentence: "%s", source_flag: "3", topic_id: Topic.ids[%d]).first_or_create' % (reply, int(topic_id)-1))
  #  print ('Train.where(user_id: User.first.id, tweet_id: sent_tweet.id, reply_id: sent_reply.id, topic_id: Topic.ids[%d]).first_or_create' % (int(topic_id)-1))

