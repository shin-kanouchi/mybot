class EvaluatesController < ApplicationController

  def new #テストをしますというだけのところ
    evaluator = current_user.id
    user_x = User.where( 'id >= ?', rand(User.count) + 1 ).first
    while true
      user_y_id = rand(User.count) + 1 
      if user_y_id != user_x.id and User.find_by_id(user_y_id)
        break
      end
    end
    @eval = Evaluate.create(evaluator: evaluator, user_x_id: user_x.id, user_y_id: user_y_id) #ここのIDを使ってnewに繫ぐ ここ，createに分けた方がいいかも
  end

  def finish
  end

  def show
    @evals = Evaluate.where('user_x_id = ? or user_y_id = ?', params["id"], params["id"]).order("updated_at DESC")
  end


end
