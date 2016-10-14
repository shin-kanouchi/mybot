class EvaluatesController < ApplicationController

  def index
    @evals = Evaluate.where('user_x_id = ? or user_y_id = ?', current_user.id, current_user.id).order("updated_at DESC")
  end

  def new #テスト開始時
    evaluator = current_user.id
    user_x = User.where( 'id >= ?', rand(User.count) + 1 ).first #ここの選び方を直す
    while true
      user_y_id = rand(User.count) + 1 
      if user_y_id != user_x.id and User.find_by_id(user_y_id)
        break
      end
    end
    @eval = Evaluate.create(evaluator: evaluator, user_x_id: user_x.id, user_y_id: user_y_id)
  end

  #def update
  #  binding.pry
  #  @eval = Evaluate.find(params["id"])
  #  #if @eval.pairwises.count >= 10
  #  #  win_or_lose
  #  #end
  #end

  def show
    #@evals = Evaluate.where('user_x_id = ? or user_y_id = ?', current_user.id, current_user.id).order("updated_at DESC")
  end

  def win_f
    if win_flag == 1
      return "o #{self.user_x.nickname} vs #{self.user_y.nickname} x"
    elsif win_flag == 2
      return "x #{self.user_x.nickname} vs #{self.user_y.nickname} o"
    else
      return "△ #{self.user_x.nickname} vs #{self.user_y.nickname} △"
    end
  end

end
