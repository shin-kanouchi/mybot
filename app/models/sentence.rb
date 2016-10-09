class Sentence < ActiveRecord::Base
  has_many :tweet_replys, class_name: "Train", foreign_key: :tweet_id
  has_many :replys, through: :tweet_replys
  has_many :reply_tweets, class_name: "Train", foreign_key: :reply_id
  has_many :tweets, through: :reply_tweets
  
end
