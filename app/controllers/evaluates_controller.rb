class EvaluatesController < ApplicationController

  def index
    @evals = Evaluate.where('(user_x_id = ? or user_y_id = ?) and win_flag != 3', current_user.id, current_user.id).order("updated_at DESC")
    @current_user_id = current_user.id
  end

  def new #テスト開始時 createと分けたほうがいいかも
    evaluator = current_user.id
    user_x = User.where( 'id >= ?', rand(User.last.id)).first #ここの選び方を直す
    bot_x = Bot.order('battle_point DESC').first
    bot_y = Bot.where('id != ? and battle_point >= 1', bot_x.id).order('updated_at ASC').first
    bot_y = Bot.where('id != ?', bot_x.id).order('battle_point DESC').first if bot_y == nil
    
    @eval = Evaluate.create(evaluator: evaluator, user_x_id: bot_x.user_id, user_y_id: bot_y.user_id)
  end

  def show
    #@evals = Evaluate.where('user_x_id = ? or user_y_id = ?', current_user.id, current_user.id).order("updated_at DESC")
  end

  #def win_f
  #  if win_flag == 1
  #    return "o #{self.user_x.nickname} vs #{self.user_y.nickname} x"
  #  elsif win_flag == 2
  #    return "x #{self.user_x.nickname} vs #{self.user_y.nickname} o"
  #  else
  #    return "△ #{self.user_x.nickname} vs #{self.user_y.nickname} △"
  #  end
  #end

end
