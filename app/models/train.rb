class Train < ActiveRecord::Base
  belongs_to :reply, class_name: "Sentence", foreign_key: :reply_id
  belongs_to :tweet, class_name: "Sentence", foreign_key: :tweet_id

end
