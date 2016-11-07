#!/usr/bin/env python
# coding: utf-8

import sys  
import twitter
import twkeys
import time
maxcount=1000
maxid =0

terms=sys.argv[1].strip().split(",") #["八意永琳","永琳","えーりん"]
search_str=" OR ".join(terms)
  
CONSUMER_KEY = twkeys.twkey['cons_key']
CONSUMER_SECRET = twkeys.twkey['cons_sec']
ACCESS_TOKEN_KEY = twkeys.twkey['accto_key']
ACCESS_TOKEN_SECRET = twkeys.twkey['accto_sec']

api = twitter.Api(consumer_key=CONSUMER_KEY,
                  consumer_secret=CONSUMER_SECRET,
                  access_token_key=ACCESS_TOKEN_KEY,
                  access_token_secret=ACCESS_TOKEN_SECRET)

#rate = api.getRateLimitStatus().getLimit()
#print ("Limit %d / %d" % (rate['resources']['search']['/search/tweets']['remaining'],rate['resources']['search']['/search/tweets']['limit']))
#tm = time.localtime(rate['resources']['search']['/search/tweets']['reset'])
#print ("Reset Time  %d:%d" % (tm.tm_hour , tm.tm_min))
#print ("-----------------------------------------\n")


found = api.GetSearch(term=search_str, count=100, result_type='recent')
i = 0
while True:
  for f in found:
    if maxid > f.id or maxid == 0: maxid = f.id
    if len(f.text) < 80:
      print (" ||| ".join(f.text.split("\n")))
      #print (f.text)
    i = i + 1
  if len(found) == 0: break
  if maxcount <= i: break
  print (maxid)
  found = api.GetSearch(term=search_str, count=100, result_type='recent', max_id=maxid-1)

#print ("-----------------------------------------\n")
#rate = api.GetRateLimitStatus()
#print ("Limit %d / %d" % (rate['resources']['search']['/search/tweets']['remaining'],rate['resources']['search']['/search/tweets']['limit']))
#tm = time.localtime(rate['resources']['search']['/search/tweets']['reset'])
#print ("Reset Time  %d:%d" % (tm.tm_hour , tm.tm_min))
