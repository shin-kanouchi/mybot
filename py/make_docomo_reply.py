import sys
from doco.client import Client

tweet = sys.argv[1]

c = Client(apikey='6c61546d47537763524d6e577a68716b4e70586e49465542326a45432e6c762e41347359366d79756a492f')

reply = c.send(utt=tweet, apiname='Dialogue')
s = set([reply["utt"]])

i = 0
while len(s) < 10 and i < 15:
  print (i)
  try:
    reply = c.send(utt=tweet, apiname='Dialogue')
    s.add(reply["utt"])
  except:
    pass
  i += 1

print (s)
