class Sentence < ActiveRecord::Base
  has_many :tweet_replys, class_name: "Train", foreign_key: :tweet_id
  has_many :replys, through: :tweet_replys
  has_many :reply_tweets, class_name: "Train", foreign_key: :reply_id
  has_many :tweets, through: :reply_tweets

  def docomo_reply
    client = Docomoru::Client.new(api_key: '6c61546d47537763524d6e577a68716b4e70586e49465542326a45432e6c762e41347359366d79756a492f')
    while true
      reply = client.create_dialogue(self.sentence).body["utt"]
      if reply.length < 40
        break
      end
    end
    Sentence.where(sentence: reply).first_or_create #DBに含まれていたらそれをとる。無ければnew()
  end

end
