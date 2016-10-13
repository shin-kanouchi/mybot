class Evaluate < ActiveRecord::Base
  has_many :pairwises
  belongs_to :user_x, class_name: "User", foreign_key: :user_x_id
  belongs_to :user_y, class_name: "User", foreign_key: :user_y_id

  def win_or_lose
    win_flag = pairwises.group(:inequality_flag).order('count_inequality_flag DESC').limit(1).count(:inequality_flag).keys[0]
    if win_flag == 1
      return "o #{self.user_x.nickname} vs #{self.user_y.nickname} x"  
    elsif win_flag == 2
      return "x #{self.user_x.nickname} vs #{self.user_y.nickname} o"
    else
      return "△ #{self.user_x.nickname} vs #{self.user_y.nickname} △"
    end
  end

end
