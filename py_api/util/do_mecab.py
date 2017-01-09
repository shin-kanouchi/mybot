#!/usr/bin/env python
# -*- coding: utf-8 -*-
import MeCab

stop_words = ["こと","わ","い","ね","の","それ","う","い","ん","や",".","。","、",",","〜","ー","？","?","！","!","・"]

for line in open("/work/kanouchi/git/mybot/py_api/util/noun_stop_word.txt"):
  stop_words.append(line.strip())

def do(text, noun=False):
    mc = MeCab.Tagger("mecabrc")
    wakati = []
    itemlist = mc.parse(text).strip().split('\n')
    for item in itemlist:
        #if item == "EOS" or item == "": break
        item2 = item.strip().split("\t")
        if len(item2) == 1: continue
        surface = item2[0]
        if noun:
            pos = item2[1].split(",")[0]
            for n in noun:
                if pos == n and surface not in stop_words:
                    wakati.append(surface)
        else:
            wakati.append(surface)
    return wakati

if __name__ == '__main__':
    pass
