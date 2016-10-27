class EvaluatesController < ApplicationController

  def index
    @evals = Evaluate.where('(user_x_id = ? or user_y_id = ?) and win_flag != 3', current_user.id, current_user.id).order("updated_at DESC")
    @current_user_id = current_user.id
  end

  def new
  end

  #def new #テスト開始時 createと分けたほうがいいかも
  #  evaluator = current_user.id
  #  user_x = User.where( 'id >= ?', rand(User.last.id)).first #ここの選び方を直す
  #  bot_x = Bot.order('battle_point DESC').first
  #  bot_y = Bot.where('id != ? and battle_point >= 1', bot_x.id).order('updated_at ASC').first
  #  bot_y = Bot.where('id != ?', bot_x.id).order('battle_point DESC').first if bot_y == nil
  #  topic_id = choose_topic(bot_x, bot_y)
  #  @eval = Evaluate.create(evaluator: evaluator, user_x_id: bot_x.user_id, user_y_id: bot_y.user_id, topic_id: topic_id)
  #end

  def create
    if params["battle"]
      @eval = Evaluate.where( 'state_flag = ? and user_x_id != ?', 1, current_user.id).sample  #自分にと戦える勝負待ちのevalを探す 経験値の条件を追加する    
      if @eval == nil #勝負待ちのEvaluateがなかったら
        topic_id = choose_topic
        @eval = Evaluate.create(user_x_id: current_user.id, topic_id: topic_id)
      else
        @eval.user_y_id = current_user.id
        @eval.save
      end
    else
      @eval = Evaluate.where( 'state_flag = ? and user_x_id != ? and user_y_id != ?', 2, current_user.id, current_user.id).sample
      if @eval == nil
        old_eval = Evaluate.where( 'state_flag = ? and user_x_id != ? and user_y_id != ? and evaluator != ?', 3, current_user.id, current_user.id, current_user.id).sample
        return redirect_to root_path if old_eval == nil #評価できるデータが一つもないときの処理 エラーを出す
        @eval = Evaluate.create(user_x_id: old_eval.user_x_id, user_y_id: old_eval.user_y_id, topic_id: old_eval.topic_id, state_flag: 2)
      end
      @eval.evaluator = current_user.id
      @eval.save
    end
    redirect_to controller: :pairwises, action: :new, id: 1, evaluate_id: @eval.id
  end


  def show
    #@evals = Evaluate.where('user_x_id = ? or user_y_id = ?', current_user.id, current_user.id).order("updated_at DESC")
  end


  def choose_topic
    #xのレベルor 経験値を調べて，条件を満たしているtopicで戦う
    return Topic.first.id
  end
end
