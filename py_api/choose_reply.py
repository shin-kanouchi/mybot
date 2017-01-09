#!/usr/bin/env python
# -*- coding: utf-8 -*-

from collections import defaultdict
import numpy as np
import pymysql.cursors
import sys
sys.path.append("util")
import do_mecab
import collect_matching_word

db_name = "mybot_production"
host = "fomalhaut"
username = "root"
passwd = "mamochan"
sql = "SELECT trains.id, sentences.sentence, sentences.nouns FROM trains INNER JOIN sentences ON trains.tweet_id = sentences.id where trains.user_id = %s and trains.adequacy_flag > 0"
#sql_rep = "SELECT sentences.id, sentences.sentence FROM trains INNER JOIN sentences ON trains.reply_id = sentences.id where trains.id = %s"


class Choose_Reply:
  def __init__(self, model_path):
    #self.model = pickle.load(open(model_path, 'rb'))
    self.model = model_path
    self.cursor = "" #connection.cursor()
    self.cand_num = 20
    self.user_dic = {}

  def choose(self, user_id, tweet, nbest=1):
    connection = pymysql.connect(host='localhost', user=username, password=passwd, db=db_name, charset='utf8', cursorclass=pymysql.cursors.DictCursor)
    self.cursor = connection.cursor()
    self.cursor.execute(sql, user_id)
    train_db = self.cursor.fetchall() #2list
    nouns = do_mecab.do(tweet, ["名詞"])
    #print(tweet, nouns)
    train_id = collect_matching_word.matching(tweet, nouns, train_db, nbest)
    #self.cursor.execute(sql_rep, train_id)
    #reply_info = self.cursor.fetchall()
    #print(reply_info)
    connection.close()
    #if len(reply_info) == 0: return ""
    return str(train_id)


if __name__ == '__main__':
  pass
