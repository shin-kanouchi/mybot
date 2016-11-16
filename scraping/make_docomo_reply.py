import sys
from time import sleep
from doco.client import Client
c = Client(apikey='6c61546d47537763524d6e577a68716b4e70586e49465542326a45432e6c762e41347359366d79756a492f')

f = open(sys.argv[2], "w")
for tweet in open(sys.argv[1]):
  reply = c.send(utt=tweet, apiname='Dialogue')
  s = set([reply["utt"]])
  i = 0
  while len(s) < 6 and i < 8:
    sleep(3)
    try:
      reply = c.send(utt=tweet, apiname='Dialogue')
      s.add(reply["utt"])
    except:
      pass
    i += 1


  print( "%s |||| %s" % (tweet.strip(), " ||| ".join(list(s))))  #, file=f)
  sleep(40)
