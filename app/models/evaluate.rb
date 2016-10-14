class Evaluate < ActiveRecord::Base
  has_many :pairwises
  belongs_to :user_x, class_name: "User", foreign_key: :user_x_id
  belongs_to :user_y, class_name: "User", foreign_key: :user_y_id

end
