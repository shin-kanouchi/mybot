#!/usr/bin/env python
# coding: utf-8

import sys
import MeCab
import re

mc = MeCab.Tagger("mecabrc")
#終助詞のルール，時間表現，比較表現のルールを追加する

def rm_rule(s_surf, s_pos, keyword):
  #文長制限
  if len(s_pos) < 4 or len(s_pos) > 30 or not keyword in s_surf:
    return True
  #文頭の品詞制限
  first_pos1 = s_pos[0][0]
  if first_pos1 == "助詞" or first_pos1 == "助動詞" or first_pos1 == "接続詞":
    return True
  #文末の品詞制限
  last_pos1 = s_pos[-1][0]
  last_pos2 = s_pos[-1][1]
  if last_pos1 == "助詞" or last_pos1 == "名詞":
    if last_pos2 == "格助詞" or last_pos2 == "係助詞" or last_pos2 == "接続助詞" or last_pos2 == "並列助詞" or last_pos2 != "形容動詞語幹":
      return True
  #文間の品詞制限
  for pos in s_pos[1:-1]:
    if pos[0] == "助詞" and pos[1] == "終助詞":
      return True
  #キーワード前後の品詞制限
  key_i = s_surf.index(keyword)
  if key_i != 0 and s_pos[key_i-1][0] == "名詞":
    return True
  if key_i != len(s_pos)-1 and s_pos[key_i+1][0] == "名詞": #ここでかなり殺してる
    return True
  #人名のフィルタリング
  for i, pos in enumerate(s_pos):
    if pos[0] == "名詞" and i != key_i:
      if pos[1] == "代名詞" or (pos[1] == "固有名詞" and pos[2] == "人名"):
        return True

  return False

def split_symbol(sents, keyword):
  new_sent_surf = []
  new_sent_pos = []
  items = mc.parse(sents).strip().split("\n")
  for item in items:
    if item == "EOS" or item == "": continue
    surface, pos_str = item.split("\t")
    pos = pos_str.split(",")
    if pos[0] == "記号":
      if not rm_rule(new_sent_surf, new_sent_pos, keyword):
        return "".join(new_sent_surf)
      new_sent_surf = []
      new_sent_pos = []
    else:
      new_sent_surf.append(surface)
      new_sent_pos.append(pos)
  return False

def preprocess(line, keyword):
  sentss = line.strip().split("\n")
  for sents in sentss:
    if not sents.count(keyword) or sents.count("@"): continue
    return split_symbol(sents, keyword)
  return False

if __name__ == "__main__":
  pass
