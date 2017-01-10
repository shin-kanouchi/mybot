#!/usr/bin/env python
# -*- coding: utf-8 -*-
import editdistance
import random


def return_nbest_edit_distance(input_tweet, input_nouns, database, n=5):
  nbest = [("", i+100000) for i in range(n)]
  for query_dic in database:
    score1 = editdistance.eval(input_tweet, query_dic["sentence"])
    score2 = editdistance.eval(input_nouns, query_dic["nouns"].split(","))
    #for w in input_nouns_list:
    #  if words01.count(w) > 0: count += 1
    total_score = score1 + 4 * score2
    for i, one_best in enumerate(nbest):
      _, one_score = one_best
      if total_score < one_score:
        nbest.insert(i, (query_dic["id"], int(total_score)))
        nbest.pop()
        #print(query_dic["sentence"])
        break
  return nbest


def matching(input_tweet, input_nouns, database, n):
  nbest = return_nbest_edit_distance(input_tweet, input_nouns, database)
  print(nbest)
  random.shuffle(nbest)
  if int(n) == 1:
    return nbest[0][0]
  else:
    return ",".join([str(nbest[i][0]) for i in range(n)])

if __name__ == '__main__':
    pass
