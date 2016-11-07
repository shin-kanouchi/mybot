#!/usr/bin/env python
# coding: utf-8

import sys  
import twitter
import twkeys

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
tweets = api.GetSearch(term=search_str, count=100, result_type='recent')
for tweet in tweets:
    if len(tweet.text) < 30:
      print(tweet.text)
