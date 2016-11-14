#!/usr/bin/env python
# coding: utf-8

import sys
import twitter
import twkeys
import preprocess
from time import sleep

maxcount=1000

CONSUMER_KEY = twkeys.twkey['cons_key']
CONSUMER_SECRET = twkeys.twkey['cons_sec']
ACCESS_TOKEN_KEY = twkeys.twkey['accto_key']
ACCESS_TOKEN_SECRET = twkeys.twkey['accto_sec']

api = twitter.Api(consumer_key=CONSUMER_KEY,
                  consumer_secret=CONSUMER_SECRET,
                  access_token_key=ACCESS_TOKEN_KEY,
                  access_token_secret=ACCESS_TOKEN_SECRET)

f = open(sys.argv[2], "w")
f.close()

for line in open(sys.argv[1]):
  maxid = 0
  search_str = line.strip()
  found = api.GetSearch(term=search_str, count=100, result_type='recent')
  i = 0
  sents = []
  while True:
    for f in found:
      if maxid > f.id or maxid == 0: maxid = f.id
      if len(f.text) < 80:
        try:
          sent = preprocess.preprocess(f.text, search_str)
          if sent: sents.append(sent)
        except: pass
      i = i + 1
    if len(found) == 0: break
    if maxcount <= i: break
    #print (maxid)
    found = api.GetSearch(term=search_str, count=100, result_type='recent', max_id=maxid-1)

  sents = list(set(sents))
  with open(sys.argv[2], 'a') as f:
    print ("\n".join(sents), file=f)
  sleep(50)
