import sys
topic_id = 1
sys.path.append("util")
import editdistance
import do_mecab
n = 3

tweets_list = []

for line in open(sys.argv[1]):
  if line.strip() == "": continue
  tweet, reply = line.strip().split(" ||| ")
  tweet_nouns = do_mecab.do(tweet, ["名詞"])
  reply_nouns = do_mecab.do(reply, ["名詞"])

  tweet_rep_dic = {}
  tweet_rep_dic["tweet"] = tweet
  tweet_rep_dic["reply"] = reply
  tweet_rep_dic["t_nouns"] = tweet_nouns
  tweet_rep_dic["r_nouns"] = reply_nouns
  tweets_list.append(tweet_rep_dic)

for line in open(sys.argv[2]):
  tweet = line.strip()
  nouns = do_mecab.do(tweet, ["名詞"])
  nbest = [("", i+100000) for i in range(n)]
  for tweet_rep_dic in tweets_list:
    score1 = editdistance.eval(tweet, tweet_rep_dic["tweet"])
    score2 = editdistance.eval(nouns, tweet_rep_dic["t_nouns"])
    score3 = editdistance.eval(nouns, tweet_rep_dic["r_nouns"])
    #for w in input_nouns_list:
    #  if words01.count(w) > 0: count += 1
    total_score = score1 + 4 * score2 + 6 * score3
    for i, one_best in enumerate(nbest):
      _, one_score = one_best
      if total_score < one_score:
        nbest.insert(i, (tweet_rep_dic["reply"], int(total_score)))
        nbest.pop()
        break
  for one in nbest:
    print ('%s ||| %s' % (tweet, one[0]))
  #return nbest

#  print ('sent_tweet = Sentence.where(sentence: "%s", nouns: "%s", source_flag: "3", topic_id: Topic.ids[%d]).first_or_create' % (tweet, ",".join(tweet_nouns), int(topic_id)-1))
#  print ('sent_reply = Sentence.where(sentence: "%s", nouns: "%s", source_flag: "3", topic_id: Topic.ids[%d]).first_or_create' % (reply, ",".join(reply_nouns), int(topic_id)-1))
#  print ('Train.where(user_id: User.first.id, tweet_id: sent_tweet.id, reply_id: sent_reply.id, topic_id: Topic.ids[%d]).first_or_create' % (int(topic_id)-1))

