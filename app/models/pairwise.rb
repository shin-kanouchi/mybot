class Pairwise < ActiveRecord::Base
  belongs_to :tweet, class_name: "Sentence", foreign_key: :tweet_id
  belongs_to :evaluate
  belongs_to :reply_x, class_name: "Sentence", foreign_key: :reply_x_id
  belongs_to :reply_y, class_name: "Sentence", foreign_key: :reply_y_id

end
