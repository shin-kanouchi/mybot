class Evaluate < ActiveRecord::Base
  has_many :pairwises
  belongs_to :user_x, class_name: "User", foreign_key: :user_x_id
  belongs_to :user_y, class_name: "User", foreign_key: :user_y_id
  belongs_to :topic

  def win_or_lose(user_id)
    if user_x_id == user_id
      user = user_x
      enemy = user_y
      user_win_flag = win_flag
    else
      user = user_y
      enemy = user_x
      user_win_flag = inverse_win_flag
    end
    user_face, enemy_face = make_face_image(user_win_flag)
    return user, enemy, user_win_flag, user_face, enemy_face
  end

  def inverse_win_flag
    if win_flag == 1 #相手の勝ち
      return 2
    elsif win_flag == 2 #相手の負け
      return 1
    else
      return win_flag #引き分け
    end
  end

  def make_face_image(win_flag)
    if win_flag == 1
      return "normal", "thinking"
    elsif win_flag == 2
      return "thinking", "normal"
    else
      return "normal", "normal"
    end
  end

end
