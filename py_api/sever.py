#!/usr/bin/env python
# -*- coding: utf-8 -*-

from bottle import route, run, post, request
import choose_reply

@route("/reply", method='POST')
#@route("/reply")#/<user_id>")
def reply():#user_id="2"):
  user_id = request.forms.get('user_id')
  tweet = request.forms.decode().get('tweet')
  return reply_db.choose(user_id, tweet)


@route("/nbest_replys", method='POST')
def reply():
  user_id = request.forms.get('user_id')
  tweet = request.forms.decode().get('tweet')
  n = request.forms.get('n')
  return reply_db.choose(user_id, tweet, nbest=int(n))


if __name__ == '__main__':
  reply_db = choose_reply.Choose_Reply("リンゴが食べたい")
  run(host='localhost', port=9998, debug=True)
