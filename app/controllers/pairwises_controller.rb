class PairwisesController < ApplicationController

  def index
  end

  def new
    @eval = Evaluate.find(params["evaluate_id"])
    @tweet = Sentence.where( 'id >= ?', rand(Sentence.last.id)).first #最近学習していないもので，という条件を付ける
    reply_x = choose_reply(@eval.user_x_id, @tweet.sentence)
    reply_y = choose_reply(@eval.user_y_id, @tweet.sentence)
    @pairwise = Pairwise.create(evaluate_id: @eval.id, tweet_id: @tweet.id, reply_x_id: reply_x.id, reply_y_id: reply_y.id)
  end

  def update #evaluates/:evaluate_id/pairwises/:id
    pairwise = Pairwise.find(params["id"])
    pairwise.inequality_flag = params["inequality_flag"]
    pairwise.save
    
    #10問解いたら終わる
    @eval = Evaluate.find(params["evaluate_id"])
    if @eval.pairwises.count < 10
      redirect_to controller: :pairwises, action: :new
    else
      #勝敗計算
      @eval.win_flag = calc_win_flag
      @eval.save

      #バトルポイント付与
      bot = Bot.where('user_id = ?', current_user.id).first
      bot.battle_point += 1
      bot.save

      #rankの操作
      calc_rank

      redirect_to controller: :pairwises, action: :index
    end
  end

  def calc_win_flag
    scores = @eval.pairwises.group(:inequality_flag).order('count_inequality_flag DESC').limit(3).count(:inequality_flag)
    x_score = 0
    y_score = 0
    x_score += scores[1] if scores.has_key?(1)
    y_score += scores[2] if scores.has_key?(2)

    if x_score > y_score
      return 1
    elsif x_score < y_score
      return 2
    else
      return 0
    end
  end

  def calc_rank
    bot_x = Bot.where(user_id: @eval.user_x_id).first
    bot_y = Bot.where(user_id: @eval.user_y_id).first
    if @eval.win_flag == 1
      bot_x.bot_rank += 10
      bot_y.bot_rank -= 5
    elsif @eval.win_flag == 2
      bot_x.bot_rank -= 5
      bot_y.bot_rank += 10
    else
      bot_x.bot_rank += 2
      bot_y.bot_rank += 2
    end
    bot_x.save
    bot_y.save
  end


end
